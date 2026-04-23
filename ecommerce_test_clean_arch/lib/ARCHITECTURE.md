# Arquitectura — Feature: Login

## Visión general

La feature de login sigue una **arquitectura en capas** que separa responsabilidades de forma estricta. Cada capa solo conoce a la inmediatamente inferior, nunca al revés. La inyección de dependencias se resuelve con **Riverpod** (usando `riverpod_annotation` + code generation).

```
┌─────────────────────────────────────────────────┐
│                  PRESENTACIÓN                   │
│  LoginScreen → LoginViewModel → LoginUseCase    │
├─────────────────────────────────────────────────┤
│                    DOMINIO                      │
│            LoginManager (interfaz)              │
├─────────────────────────────────────────────────┤
│                     DATOS                      │
│   LoginManagerImpl → LoginService (interfaz)    │
├─────────────────────────────────────────────────┤
│                 INFRAESTRUCTURA                 │
│           LoginServiceImpl (Dio HTTP)           │
└─────────────────────────────────────────────────┘
```

---

## Estructura de carpetas

```
lib/login/
├── data/
│   ├── interfaces/
│   │   └── login_service.dart        # Contrato del servicio HTTP
│   └── login_manager_impl.dart       # Repositorio: delega a LoginService
├── di/
│   ├── login_providers.dart          # Providers Riverpod de la feature
│   └── login_providers.g.dart        # Generado por build_runner
├── infrastructure/
│   └── login_service_impl.dart       # Implementación HTTP con Dio
├── presentation/
│   ├── interfaces/
│   │   └── login_use_case.dart       # Contrato del caso de uso
│   ├── navigatorstates/
│   │   └── login_navigator_state.dart
│   ├── screens/
│   │   └── login_screen.dart         # UI principal
│   └── viewmodel/
│       ├── login_state.dart          # Estado inmutable
│       ├── login_viewmodel.dart      # Lógica de presentación
│       └── login_viewmodel.g.dart    # Generado por build_runner
└── usecases/
    ├── interfaces/
    │   └── login_manager.dart        # Contrato del repositorio
    └── login_usecase_impl.dart       # Impl. del caso de uso
```

---

## Capas detalladas

### 1. Infraestructura — `LoginServiceImpl`

**Archivo:** `infrastructure/login_service_impl.dart`  
**Implementa:** `LoginService`

Responsabilidad única: ejecutar la llamada HTTP al endpoint de autenticación usando **Dio**.

- Recibe `Dio` por constructor (inyectado desde `login_providers.dart`).
- Retorna `Result<String, DioException>`: el token en caso de éxito, o un `DioException` ante error de red o servidor.
- No contiene ninguna lógica de negocio.

---

### 2. Datos — `LoginManagerImpl`

**Archivo:** `data/login_manager_impl.dart`  
**Implementa:** `LoginManager`

Repositorio que actúa como **anti-corrupción** entre la infraestructura y el dominio.

- Delega la llamada a `LoginService`.
- Traduce `DioException` → `DomainError` mediante `dioExceptionMapper`.
- Retorna `Result<String, DomainError>`.

**Interfaz:** `usecases/interfaces/login_manager.dart`

```dart
abstract class LoginManager {
  Future<Result<String, DomainError>> login(String email, String password);
}
```

---

### 3. Dominio — `LoginUseCaseImpl`

**Archivo:** `usecases/login_usecase_impl.dart`  
**Implementa:** `LoginUseCase`

Orquesta la lógica de negocio del login.

- Delega en `LoginManager`.
- Traduce `DomainError` → `UiError` para que la presentación no conozca errores de dominio.
- Retorna `Result<String, UiError>`.

**Interfaz:** `presentation/interfaces/login_use_case.dart`

```dart
abstract class LoginUseCase {
  Future<Result<String, UiError>> invoke(String email, String password);
}
```

---

### 4. Presentación

#### `LoginState`

**Archivo:** `presentation/viewmodel/login_state.dart`

Estado inmutable de la pantalla. El `LoginViewModel` emite nuevas instancias via `copyWith`.

| Campo            | Tipo                  | Descripción                                           |
| ---------------- | --------------------- | ----------------------------------------------------- |
| `email`          | `String`              | Valor actual del campo email                          |
| `password`       | `String`              | Valor actual del campo contraseña                     |
| `viewState`      | `ViewState<void>`     | Estado de UI: `Ready`, `Loading`, `ErrorState`        |
| `navigatorState` | `LoginNavigatorState` | Orden de navegación: `NoNavigation`, `GoToHomeScreen` |

---

#### `LoginNavigatorState`

**Archivo:** `presentation/navigatorstates/login_navigator_state.dart`

Sealed class usada para comunicar eventos de navegación desde el ViewModel a la pantalla, sin que el ViewModel conozca el contexto de Flutter.

```
LoginNavigatorState (sealed)
├── NoNavigation     → estado inicial, no navegamos
└── GoToHomeScreen   → login exitoso, ir a /home
```

---

#### `LoginViewModel`

**Archivo:** `presentation/viewmodel/login_viewmodel.dart`  
**Tipo Riverpod:** `@riverpod` Notifier (`LoginState`)

Gestiona el estado y expone acciones a la pantalla. Inyecta `LoginUseCase` via `ref.read(loginUseCaseProvider)`.

**Flujo del método `login()`:**

```
1. Validar email con regex
       │ inválido → emitir ErrorState("Email inválido") y return
       ↓
2. Validar password no vacío
       │ vacío → emitir ErrorState("Ingresá tu contraseña") y return
       ↓
3. Emitir Loading
       ↓
4. Llamar a LoginUseCase.invoke(email, password)
       ↓
5. Éxito → emitir Ready + navigatorState: GoToHomeScreen
   Error → emitir ErrorState(uiError.message)
```

| Método                     | Descripción                     |
| -------------------------- | ------------------------------- |
| `onEmailChanged(value)`    | Actualiza `state.email`         |
| `onPasswordChanged(value)` | Actualiza `state.password`      |
| `login()`                  | Valida y ejecuta el caso de uso |
| `clearError()`             | Resetea `viewState` a `Ready`   |

---

#### `LoginScreen`

**Archivo:** `presentation/screens/login_screen.dart`  
**Tipo:** `ConsumerStatefulWidget`

Pantalla de login. Se suscribe al `LoginViewModel` con `ref.watch` para reconstruirse, y con `ref.listen` para reaccionar a cambios de navegación.

**Responsabilidades:**

- Escuchar cambios de texto en los `TextEditingController` y delegarlos al ViewModel.
- Llamar a `login()` al presionar el botón.
- Mostrar `SnackBar` en caso de error.
- Navegar a `/home` cuando `navigatorState` cambia a `GoToHomeScreen` (via `ref.listen` → `_handleNavigation`).

---

## Inyección de dependencias — `login_providers.dart`

```
loginServiceProvider       → LoginServiceImpl(Dio())
        ↓
loginManagerProvider       → LoginManagerImpl(loginServiceProvider)
        ↓
loginUseCaseProvider       → LoginUseCaseImpl(loginManagerProvider)
        ↓
loginViewModelProvider     → LoginViewModel (definido en login_viewmodel.dart)
                             inyecta loginUseCaseProvider via ref.read
```

Todos los providers son generados por `riverpod_annotation` + `build_runner`.

---

## Flujo de errores

```
DioException          (infraestructura)
      ↓  dioExceptionMapper
DomainError           (dominio)
      ↓  LoginUseCaseImpl
UiError               (presentación)
      ↓  LoginViewModel → ErrorState<void>
SnackBar en LoginScreen
```

Cada capa traduce el error al tipo que le corresponde, manteniendo el aislamiento entre capas.

---

## Convenciones

- Las **interfaces** se ubican junto a quien las **consume**, no junto a quien las implementa.
  - `LoginService` vive en `data/interfaces/` (la consume `LoginManagerImpl`).
  - `LoginManager` vive en `usecases/interfaces/` (la consume `LoginUseCaseImpl`).
  - `LoginUseCase` vive en `presentation/interfaces/` (la consume `LoginViewModel`).
- **`ref.read`** se usa en métodos de acción (no reconstruye el widget).
- **`ref.watch`** se usa en `build()` para reconstruir la UI ante cambios de estado.
- **`ref.listen`** se usa para side effects (navegación, snackbars) que no deben reconstruir.
