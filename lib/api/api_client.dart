import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/model/request_error.dart';
import 'package:flutter_app/i18n/strings.dart';

import 'api_service.dart';
import 'api_strings.dart';
import 'util/error_json_converter.dart';
import 'util/example_interceptor.dart';
import 'util/jaguar_json_converter.dart';

class ApiClient {
  final BuildContext context;

  ApiClient(this.context);

  static final ChopperClient chopper = ChopperClient(
    baseUrl: baseUrl,
    services: [
      ApiService.create(),
    ],
    converter: JaguarJsonConverter(),
    errorConverter: ErrorJsonConverter(),
    interceptors: [
      ExampleInterceptor(),
      HttpLoggingInterceptor(),
    ],
  );

  static final apiService = chopper.getService<ApiService>();

  Future<Response<String>> getExampleString(String token) {
    return _callRequest(apiService.getExampleString(token));
  }

  Future<Response<T>> _callRequest<T>(Future<Response<T>> apiCall) async {
    try {
      Response<T> res = await apiCall;
      return res;
    } on Response catch (errorResponse) {
      return Future.error(RequestError(
        errorResponse.statusCode,
        errorResponse.body,
        errorResponse,
      ));
    } catch (exception) {
      if (exception is SocketException) {
        return Future.error(RequestError(
          -1,
          Strings.of(context).textNoInternet,
          exception,
        ));
      } else {
        return Future.error(RequestError(
          -1,
          exception.toString(),
          exception,
        ));
      }
    }
  }
}
