class DomainError {
  final String message;

  const DomainError(this.message);

  @override
  String toString() => 'DomainError: $message';
}
