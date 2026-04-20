// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$counterRepositoryHash() => r'8223b0f9594934188fa03bbbb573d93229b834df';

/// See also [counterRepository].
@ProviderFor(counterRepository)
final counterRepositoryProvider =
    AutoDisposeProvider<CounterRepositoryImpl>.internal(
      counterRepository,
      name: r'counterRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$counterRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CounterRepositoryRef = AutoDisposeProviderRef<CounterRepositoryImpl>;
String _$counterUseCaseHash() => r'354d4f616e3c314d42fc3793c76273a6e8fa997e';

/// See also [counterUseCase].
@ProviderFor(counterUseCase)
final counterUseCaseProvider = AutoDisposeProvider<ICounterUseCase>.internal(
  counterUseCase,
  name: r'counterUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$counterUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CounterUseCaseRef = AutoDisposeProviderRef<ICounterUseCase>;
String _$counterNotifierHash() => r'825ffb5d44e00d80bc75f5ffba3daff1f9906ccd';

/// See also [CounterNotifier].
@ProviderFor(CounterNotifier)
final counterNotifierProvider =
    AutoDisposeAsyncNotifierProvider<CounterNotifier, Counter>.internal(
      CounterNotifier.new,
      name: r'counterNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$counterNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CounterNotifier = AutoDisposeAsyncNotifier<Counter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
