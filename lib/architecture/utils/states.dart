import 'package:flutter_app/api/model/request_error.dart';

class StreamState<T> {}

class LoadingState<T> extends StreamState<T> {
  final bool isLoading;

  LoadingState(this.isLoading);
}

class SuccessState<T> extends StreamState<T> {
  final T data;

  SuccessState(this.data);
}

class FailureState<T> extends StreamState<T> {
  final RequestError failure;

  FailureState(this.failure);
}
