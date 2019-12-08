import 'dart:async';

import 'package:chopper/chopper.dart';

import '../api_strings.dart';

class ExampleInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {

    return request;
  }
}
