part of mapbox_search;

class Predictions {
  String? type;
  List<MapBoxPlace>? features;

  Predictions.prediction({
    this.type,
    this.features,
  });

  Predictions.empty() {
    type = '';
    features = [];
  }

  factory Predictions.fromRawJson(String str) =>
      Predictions.fromJson(json.decode(str));

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      Predictions.prediction(
        type: json["type"],
        features: List<MapBoxPlace>.from(
            json["features"].map((x) => MapBoxPlace.fromJson(x))),
      );
}

class MapBoxPlace {
  String id;
  String type;
  String addressNumber;
  String text;
  String placeName;
  Coordinates? coordinates;
  PlaceContext placeContext;

  MapBoxPlace({
    this.id = "",
    this.type = "",
    this.addressNumber = "",
    this.text = "",
    this.placeName = "",
    this.coordinates,
    required this.placeContext,
  });

  factory MapBoxPlace.fromRawJson(String str) =>
      MapBoxPlace.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapBoxPlace.fromJson(Map<String, dynamic> json) {
    return MapBoxPlace(
      id: json["id"] ?? "",
      type: json["type"] ?? "",
      addressNumber: json["address"] ?? "",
      text: json["text"] ?? "",
      placeName: json["place_name"] ?? "",
      coordinates: json["context"] != null
          ? Coordinates.fromJson(json["center"])
          : Coordinates(),
      placeContext: json["context"] != null
          ? PlaceContext.fromJson(json["context"])
          : PlaceContext(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "address": addressNumber,
        "text": text,
        "place_name": placeName,
      };

  @override
  String toString() => text;
}

class Coordinates {
  final double latitude;

  final double longitude;

  Coordinates({
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  static Coordinates fromJson(List json) {
    return Coordinates(latitude: json[0], longitude: json[1]);
  }
}

class PlaceContext {
  final String locality;

  final String city;

  final String state;

  final String postCode;

  final String country;

  final String neighborhood;

  PlaceContext({
    this.city = "",
    this.state = "",
    this.postCode = "",
    this.country = "",
    this.locality = "",
    this.neighborhood = "",
  });

  static PlaceContext fromJson(List json) {
    return PlaceContext(
      locality: getKeyValue(json, ("locality")),
      city: getKeyValue(json, "place"),
      state: getKeyValue(json, ("region")),
      postCode: getKeyValue(json, "postcode"),
      country: getKeyValue(json, "country"),
      neighborhood: getKeyValue(json, "neighborhood"),
    );
  }

  static String getKeyValue(List json, String key) {
    try {
      return json
          .where((element) => (element["id"] as String).contains(key))
          .toList()[0]["text"];
    } catch (e) {
      return "";
    }
  }
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
