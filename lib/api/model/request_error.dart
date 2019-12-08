import 'package:flutter/material.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'request_error.jser.dart';

class RequestError {

  final int code;

  final String error;

  final dynamic data;

  RequestError(this.code, this.error, this.data);

}

@GenSerializer()
class RequestErrorSerializer extends Serializer<RequestError>
    with _$RequestErrorSerializer {}
