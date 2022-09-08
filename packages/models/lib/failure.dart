class Failure implements Exception {
  final String message;
  final Object error;

  Failure({
    this.message = 'An error occured',
    required this.error,
  });

  @override
  String toString() {
    return '$message: $error';
  }
}
