import 'dart:convert';
import 'dart:io';

import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:http/http.dart' as http;

import 'general.dart';

class HttpRequests {
  static httpGetRequest(context, String url, Map<String, String> headers,
      Function(String, Map<String, String>) success, Function error) async {
    // if (await General.getStringSP('token') != null)
    //   headers[HttpHeaders.authorizationHeader] =
    //       'Bearer ${await General.getStringSP('token')}';
    // headers['Accept-Language']=await General.getStringSP('lang');
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    headers[HttpHeaders.connectionHeader] = 'keep-alive';
    print(headers);
    if (url.contains(Constants.wooAuth))
      url += '&lang=${await General.getStringSP('lang') ?? 'ar'}';
    print(url);
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      print('result: ${response.body}');
      print('result header: ${response.headers}');
      success(response.body, response.headers);
    } else {
      print(response.body);
      var data = json.decode(response.body);
      General.showErrorDialog(context, data['message']);
      error();
    }
  }

  static httpPostRequest(
      context,
      url,
      Map<String, String> headers,
      Map<String, dynamic> body,
      Function(String) success,
      Function error) async {
    print('POST Request: ' + url);
    //print('POST Body: ${General.removeNulls(body)}');
    // if (await General.getStringSP('token') != null)
    //   headers[HttpHeaders.authorizationHeader] =
    //       '${await General.getStringSP('token')}';
    // headers['Accept-Language']=await General.getStringSP('lang');
    headers[HttpHeaders.contentTypeHeader] =
        'application/x-www-form-urlencoded';
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.contentTypeHeader] = 'application/json; charset=utf-8';
    print(headers);
    var response = await http.post(Uri.parse(url),
        body: json.encode(General.removeNulls(body)),
        headers: headers,
        encoding: Encoding.getByName('utf-8'));
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      success(response.body);
    } else {
      print(response.body);
      var data = json.decode(response.body);
      error();
      General.showErrorDialog(context, data['message']);
    }
  }

  static httpPutRequest(
      context,
      url,
      Map<String, String> headers,
      Map<String, dynamic> body,
      Function(String) success,
      Function error) async {
    print(url);
    // if (await General.getStringSP('token') != null)
    //   headers[HttpHeaders.authorizationHeader] =
    //       'Bearer ${await General.getStringSP('token')}';
    // headers['Accept-Language']=await General.getStringSP('lang');
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    headers[HttpHeaders.acceptHeader] = 'application/json';
    print(headers);
    var response = await http.put(Uri.parse(url),
        body: json.encode(body), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      success(response.body);
    } else {
      var data = json.decode(response.body);
      General.showErrorDialog(context, data['message']);
      error();
    }
  }
}
