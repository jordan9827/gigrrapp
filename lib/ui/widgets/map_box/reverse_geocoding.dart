// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'package:square_demo_architecture/data/network/dtos/map_box_response.dart';
// import '../../../util/enums/place_types.dart';
//
// class ReverseGeoCoding {
//   final String apiKey;
//   final String? language;
//   final LocationData? location;
//   final int? limit;
//   final String? country;
//   final List<PlaceType> types;
//
//   final String _url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/';
//
//   ReverseGeoCoding({
//     required this.apiKey,
//     this.language,
//     this.location,
//     this.limit,
//     this.country,
//     this.types = const [PlaceType.address],
//   });
//
//   String _createUrl(LocationData location) {
//     String finalUrl = "$_url${location.longitude},${location.latitude}.json?";
//     finalUrl += 'access_token=$apiKey';
//     if (this.location != null) {
//       finalUrl +=
//           '&proximity=${this.location!.longitude}%2C${this.location!.latitude}';
//     }
//
//     if (limit != null) {
//       finalUrl += '&limit=$limit&types=address';
//     }
//
//     if (country != null) {
//       finalUrl += '&country=$country';
//     }
//
//     if (language != null) {
//       finalUrl += '&language=$language';
//     }
//
//     return finalUrl;
//   }
//
//   Future<List<MapBoxPlace>?> getAddress(LocationData location) async {
//     String url = _createUrl(location);
//     final response = await http.get(Uri.parse(url));
//     print("getAddress $url");
//     if (response.body.contains('message')) {
//       throw Exception(json.decode(response.body)['message']);
//     }
//     return Predictions.fromRawJson(response.body).features;
//   }
// }
