// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dtplusmerchant/const/url_constant.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ApiServices {
  final String _baseUrl = UrlConstant.baseUrl;

  Future<dynamic> get(String url, {Map<String, String>? header}) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, String> ?requestHeader, Map ?body}) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: requestHeader, body: json.encode(body));
      responseJson = _returnResponse(response);
    } catch (e) {
      return BadRequestException();
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {Map<String, String> ?requestHeader, Map? body}) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + url),
          headers: requestHeader, body: json.encode(body));
      responseJson = _returnResponse(response);
    } catch (e) {
      throw BadRequestException();
    }
    return responseJson;
  }

  Future<dynamic> patch(String url,
      {Map<String, String> ?requestHeader, Map? body}) async {
    var responseJson;
    try {
      final response = await http.patch(Uri.parse(_baseUrl + url),
          headers: requestHeader, body: json.encode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url,
      {Map<String, String> ?requestHeader, Map ?body}) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url),
          headers: requestHeader, body: json.encode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        log(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
