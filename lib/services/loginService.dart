import 'dart:convert';

import 'package:http/http.dart' as http;

import '../global.dart';

class LoginService {
  Future<http.Response> validar(String login, String pass) async {
    return await http.post(
      Uri.parse('${Global.baseApiUrl}/api/Usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'login': login,
          'pass': pass,
        },
      ),
    );
  }

  Future<http.Response> registrar(String login, String pass) async {
    return await http.post(
      Uri.parse('${Global.baseApiUrl}/api/Usuarios?login=$login&pass=$pass'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
