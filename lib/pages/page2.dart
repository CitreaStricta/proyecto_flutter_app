import 'package:flutter/material.dart';
import 'package:proyecto_apps/features/navbar.dart';
import 'package:proyecto_apps/pages/page1.dart';

import '../global.dart';
import '../models/todo.dart';
import '../widgets/database_helper.dart';
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("${Global.login}"),
      ),
      body: FutureBuilder<List<Todo>>(
        future: DatabaseHelper.instance.retrieveTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(
                      "By ${snapshot.data![index].login} At ${snapshot.data![index].time!}"),
                  isThreeLine: true,
                  leading: Text(snapshot.data![index].id.toString()),
                  onTap: () =>
                      _navigateToDetail(context, snapshot.data![index]),
                  trailing: IconButton(
                      alignment: Alignment.center,
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        // _deleteTodo(snapshot.data![index]);
                        // setState(() {});
                      }),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

_deleteTodo(Todo todo) {
  DatabaseHelper.instance.deleteTodo(todo.id!);
}

_navigateToDetail(BuildContext context, Todo todo) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Page1(todo: todo)),
  );
}
