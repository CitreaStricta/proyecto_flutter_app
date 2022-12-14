import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
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

  Future<void> recovery(String user, dynamic context) async {
    await http
        .get(Uri.parse('${Global.baseApiUrl}/api/Usuarios'))
        .then((http.Response response) {
      final List<dynamic> data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        if (data[i]['login'] == user) {
          //return data[i]['pass'].toString();
          CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            text: 'Su password es ${data[i]['pass'].toString()}',
            loopAnimation: false,
          );
        }
      }
    });
  }
}
