import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';

import '../../data/network/json_converter.dart';

class JsonToTypeConverter extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap = jsonConverters;

  JsonToTypeConverter();

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(
          response.body, typeToJsonFactoryMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function? jsonParser) {
    var jsonMap = json.decode(jsonData);

    /// Convert [type] from response to lower case to ensure it matches dto's constructors.
    if (jsonMap is Map<String, dynamic>) {
      if (jsonMap.containsKey('type')) {
        jsonMap.update("type", (value) => value.toString().toLowerCase());
      } else {
        if (jsonMap.containsKey('success')) {
          bool apiStatus = jsonMap['success'];
          jsonMap['type'] = apiStatus ? "success" : "error";
        }
        if (jsonMap.containsKey('data')) {
          jsonMap.addAll({"type": "success"});
        } else {
          final response = {'type': 'error'};
          if (!jsonMap.containsKey('status')) {
            response.addAll({'status': '-1'});
          }
          if (!jsonMap.containsKey('message')) {
            var errorMsg = '';
            if (jsonMap.containsKey('detail')) {
              errorMsg = jsonMap['detail'];
            } else {
              errorMsg = "Message not provided by server";
            }
            response.addAll({'message': errorMsg});
          }

          jsonMap.addAll(response);
        }
      }
    }

    try {
      if (jsonParser != null) {
        if (jsonMap is List) {
          return jsonMap
              .map((item) =>
                  jsonParser(item as Map<String, dynamic>) as InnerType)
              .toList() as T;
        }
        return jsonParser(jsonMap);
      } else {
        return jsonMap;
      }
    } catch (e) {
      log(e.toString());
      return jsonMap;
    }
  }
}
