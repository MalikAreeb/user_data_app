import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:user_data/network/api_endpoints.dart';
import 'package:user_data/network/exeption_handling/app_exeptions.dart';
import 'package:user_data/network/services/base_api_services.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String endPoint, {String? queryString}) async {
    var responseJson;
    // var token = await getAuthToken();
    if (kDebugMode) {
      print("URL: ${Uri.parse("${ApiEndPoints.baseUrl}/${endPoint}")}");
      print("Query: $queryString");
    }
    try {
      final response = await http.get(
          Uri.parse("${ApiEndPoints.baseUrl}/${endPoint}?${queryString}"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "Authorization": token ?? ""
          });
      responseJson = returnResponse(response);
      if (kDebugMode) {
        print("After Decode-->> ${responseJson}");
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on UnauthorisedException {
      rethrow;
    } on ApiException {
      rethrow;
    }
    if (kDebugMode) {
      print("Returing response----> ${responseJson}");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response httpResponse) {
    if (kDebugMode) {
      print("Http Code: ${httpResponse.statusCode}");
      print("Response: ${httpResponse.body}");
    }
    switch (httpResponse.statusCode) {
      case 200:
        if (kDebugMode) {
          print("Decoding----> ${json.decode(httpResponse.body)}");
        }
        return json.decode(httpResponse.body);
      case 400:
      case 401:
      case 500:
        return json.decode(httpResponse.body);
      case 403:
        throw ApiException("403: Unauthorised exception");
      case 404:
        throw UnauthorisedException(httpResponse.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communication with server' +
              ' with status code : ${httpResponse.statusCode}',
        );
    }
  }
}
