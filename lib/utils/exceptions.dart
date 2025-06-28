class ApplicationException implements Exception {
  ApplicationException(this.message, {this.stackTrace, this.isWarning = false});
  final String message;
  final StackTrace? stackTrace;
  final bool isWarning;

  @override
  String toString() {
    return message;
  }
}
