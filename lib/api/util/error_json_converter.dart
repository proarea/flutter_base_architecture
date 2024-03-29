import 'package:chopper/chopper.dart';
import 'package:flutter_app/api/model/request_error.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

final serializerRepo = SerializerRepoImpl(serializers: [
  RequestErrorSerializer(),
]);

class ErrorJsonConverter extends JsonConverter {
//  @override
//  Response<ResultType> convertResponse<ResultType, Item>(Response response) {
//    final jsonResult = decodeJson(response);
//    return jsonResult.replace<ResultType>(body: _decode<Item>(jsonResult.body));
//  }
//
//  dynamic _decode<Item>(entity) {
//    if (entity is Item) return entity;
//
//    final serializer = serializerRepo.getByType<Item>(Item);
//    if (serializer == null) return null;
//    if (entity is Map) return serializer.fromMap(entity);
//    if (entity is List) return serializer.fromList(entity.cast<Map>());
//    return entity;
//  }
//
//  @override
//  Request convertRequest(Request request) => super.convertRequest(
//    request.replace(
//      body: serializerRepo.to(request.body),
//    ),
//  );

  final _errorSerializer = RequestErrorSerializer();

  @override
  Response convertError<ResultType, ItemType>(Response response) {
    // use [JsonConverter] to decode json
    final jsonRes = super.convertError(response);
    return jsonRes.replace(body: _errorSerializer.fromMap(jsonRes.body));
  }
}
