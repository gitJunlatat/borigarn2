import 'dart:convert';
import 'package:borigarn/core/manager/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class LocationPlace {
  String? placeName;
  String? placeId;
  double latitude;
  double longitude;
  String? url;
  String? address;
  String? addressInfo;

  LocationPlace(
      {this.placeName,
        this.placeId,
        required this.latitude,
        required this.longitude,
        this.url,
        this.address,
        this.addressInfo});
}

class Suggestion {
  final String? placeId;
  final String? placeAddress;
  final String? placeName;
  Suggestion({this.placeId, this.placeAddress, this.placeName});
}

class GoogleMapService {
  final client = Client();
  final sessionToken;
  GoogleMapService(this.sessionToken);

  final apiKey = 'AIzaSyCG3Z33xWUkmjilvJYnuT4nuBQltosfnA0';

  Future<List<Suggestion>> fetchSuggestionsFromRadius(
      input, double lat, double lng, double radius, String languageCode) async {
    debugPrint('>>>> GoogleMapService fetchSuggestionsFromRadius');
    // final request =
    //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&location=$lat,$lng&radius=$radius&language=$languageCode&components=country:th&key=$apiKey&sessiontoken=$sessionToken';
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&location=$lat,$lng&radius=$radius&language=th&key=$apiKey&sessiontoken=$sessionToken';
    debugPrint('>>>> GoogleMapService request : $request');
    final response = await client.get(Uri.parse(request));
    debugPrint('>>>> GoogleMapService response : $response');

    if (response.statusCode == 200) {
      debugPrint('>>>> GoogleMapService statusCode : 200');
      final result = json.decode(response.body);
      if (result['status'] == 'ZERO_RESULTS') {
        debugPrint('>>>> GoogleMapService result status : ZERO_RESULTS');
        return [];
      }
      if (result['status'] == 'OK') {
        debugPrint('>>>> GoogleMapService result status : OK');
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(
            placeId: p['place_id'],
            placeAddress: p['description'],
            placeName: p['structured_formatting']?['main_text']))
            .toList();
      }
      debugPrint('>>>> GoogleMapService result status : NOT OK');
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<LocationPlace> getPlaceDetail(
      {required double latitude, required double longitude}) async {
    final request =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&language=th&key=$apiKey';
    debugPrint('=====>$request');
    final response = await client
        .get(Uri.parse(request))
        .timeout(const Duration(seconds: 30));
    debugPrint(request);

    debugPrint('=====>${response.statusCode}');

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        List components = result['results'];
        final mapPlace =
        LocationPlace(latitude: latitude, longitude: longitude);
        if (components.isNotEmpty) {
          mapPlace.placeId = null;
          mapPlace.placeName = null;
          try {
            mapPlace.address = result['results'][3]['formatted_address'];
          } catch (e) {
            debugPrint(e.toString());
          }


          print(result['results'][1]);
          log.e(mapPlace.address);
          mapPlace.url = null;
          return mapPlace;
          // return result['results'][0]['formatted_address'];
        } else {
          return mapPlace;
        }
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<LocationPlace> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&language=th&key=$apiKey&sessiontoken=$sessionToken';
    debugPrint('>>>> GoogleMapService getPlaceDetailFromId request : $request');
    final response = await client.get(Uri.parse(request));
    debugPrint(
        '>>>> GoogleMapService getPlaceDetailFromId response : $response');

    if (response.statusCode == 200) {
      debugPrint('>>>> GoogleMapService getPlaceDetailFromId statusCode : 200');
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        debugPrint(
            '>>>> GoogleMapService getPlaceDetailFromId result : $result');

        final lat = result['result']['geometry']['location']['lat'];
        final lng = result['result']['geometry']['location']['lng'];
        debugPrint('>>>> GoogleMapService getPlaceDetailFromId lat : $lat');
        debugPrint('>>>> GoogleMapService getPlaceDetailFromId lng : $lng');

        final mapPlace = LocationPlace(latitude: lat, longitude: lng);
        mapPlace.placeId = placeId;
        mapPlace.placeName = result['result']['name'];
        mapPlace.address = result['result']['formatted_address'];
        mapPlace.url = result['result']['url'];
        return mapPlace;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}


