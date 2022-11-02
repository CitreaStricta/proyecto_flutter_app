import 'dart:convert';

import '../global.dart';
import '../models/todo.dart';

import 'package:http/http.dart' as http;

class api_handler {
  api_handler._();
  static final api_handler instance = api_handler._();

// eventual metodo para actualizar los "todo"
  updateTodo(Todo todo) async {}

// incerta los "todo" por medio de la api
  Future insertTodo(Todo todo) async {
    final response =
        await http.post(Uri.parse('${Global.baseApiUrl}/api/mensajes'), body: {
      'login': todo.login,
      'titulo': todo.title,
      'texto': todo.content,
    });

    if (response.statusCode == 201) {
      print("respuesta 201");
    } else {
      throw Exception("no volvio el 201 :(");
    }
  }

  Future<List<Todo>> retrieveTodos() async {
    final response =
        await http.get(Uri.parse('${Global.baseApiUrl}/api/mensajes'));

    if (response.statusCode == 200) {
      print(response.body);
      var json = jsonDecode(response.body);
      return List.generate(json.length, (i) {
        return Todo(
          time: json[i]['fecha'],
          id: json[i]['id'],
          login: json[i]['login'],
          content: json[i]['texto'],
          title: json[i]['titulo'],
        );
      });
    } else {
      throw Exception('Failed to load SismosDTO');
    }
  }

  deleteTodo(int id) async {
    // eventual metodo de delete de mensajes
  }
}
