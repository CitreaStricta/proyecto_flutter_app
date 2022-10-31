import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../global.dart';
import '../models/todo.dart';

import 'package:http/http.dart' as http;

class DatabaseHelper {
  DatabaseHelper._();
  static const databaseName =
      'todos_database.db'; // el nombre de la base de dato
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database!;
  }

  updateTodo(Todo todo) async {
    final db = await database;

    await db.update(Todo.TABLENAME, todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> insertTodo(Todo todo) async {
    // final db = await http.post(Uri.parse('${Global.baseApiUrl}/api/mensajes'));
    //db.execute("insert into " + Todo.TABLENAME +"(content,title) values ('" + todo.content +2')
    final response =
        await http.post(Uri.parse('${Global.baseApiUrl}/api/mensajes'), body: {
      'login': todo.login,
      'titulo': todo.title,
      'texto': todo.content,
    });
    final String responseString = response.body;

    if (response.statusCode == 201) {
      return null;
    } else {
      return responseString;
    }

    // return await http.post(
    //   Uri.parse('${Global.baseApiUrl}/api/mensajes'),
    //   body: jsonEncode(
    //     <String, dynamic>{
    //       'login': Global.login,
    //       'title': todo.title,
    //       'content': todo.content,
    //     },
    //   ),
    // );

    // var res = await db.insert(Todo.TABLENAME, todo.toMap(),
    //     conflictAlgorithm: ConflictAlgorithm.replace);
    // return res;
  }

  Future<List<Todo>> retrieveTodos() async {
    final db = await http.get(Uri.parse('${Global.baseApiUrl}/api/mensajes'));

    var json = jsonDecode(db.body);

    // final List<Map<String, dynamic>> json = await db.headers;
    return List.generate(json.length, (i) {
      return Todo(
        time: json[i]['fecha'],
        id: json[i]['id'],
        login: json[i]['login'],
        content: json[i]['texto'],
        title: json[i]['titulo'],
      );
    });
  }

  deleteTodo(int id) async {
    var db = await database;
    db.delete(Todo.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, content TEXT)");
    });
  }
}
