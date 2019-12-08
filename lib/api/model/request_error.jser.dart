// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_error.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$RequestErrorSerializer implements Serializer<RequestError> {
  @override
  Map<String, dynamic> toMap(RequestError model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'code', model.code);
    setMapValue(ret, 'error', model.error);
    setMapValue(ret, 'data', passProcessor.serialize(model.data));
    return ret;
  }

  @override
  RequestError fromMap(Map map) {
    if (map == null) return null;
    final obj = new RequestError(
        map['code'] as int ?? getJserDefault('code'),
        map['error'] as String ?? getJserDefault('error'),
        passProcessor.deserialize(map['data']) ?? getJserDefault('data'));
    return obj;
  }
}
