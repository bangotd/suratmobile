import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_app/network_utils/constant.dart';


class Network{
  final String _url = url+'api/v1';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}