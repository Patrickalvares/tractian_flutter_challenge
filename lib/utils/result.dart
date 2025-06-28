class Result<FAILURE extends ApplicationFailure, SUCCESS> {
  Result.success(this.success) : failure = null;
  Result.failure(this.failure) : success = null;
  final SUCCESS? success;
  final FAILURE? failure;

  bool get isSuccess => failure == null;
  bool get isFailure => success == null;

  SUCCESS get getSuccess => success as SUCCESS;
  FAILURE get getFailure => failure as FAILURE;

  @override
  String toString() {
    return isSuccess ? 'Success: $success' : 'Failure: $failure';
  }

  T when<T>(T Function(FAILURE failure) onFailure, T Function(SUCCESS success) onSuccess) {
    if (isSuccess) {
      return onSuccess(success as SUCCESS);
    } else {
      return onFailure(failure as FAILURE);
    }
  }
}

class ApplicationFailure implements Exception {
  ApplicationFailure(this.message, {StackTrace? stackTrace})
    : stackTrace = stackTrace ?? StackTrace.current;
  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return message;
  }
}
