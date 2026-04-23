sealed class ViewState<T> {
  const ViewState();
}

class Ready<T> extends ViewState<T> {
  const Ready();
}

class Loading<T> extends ViewState<T> {
  const Loading();
}

class ErrorState<T> extends ViewState<T> {
  final String message;
  const ErrorState(this.message);
}
