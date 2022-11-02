import 'package:flutter/material.dart';
import 'package:proyecto_apps/features/navbar.dart';
import 'package:proyecto_apps/pages/crearMensaje.dart';

import '../global.dart';
import '../models/todo.dart';
import '../widgets/database_helper.dart';

class Lista extends StatefulWidget {
  Lista({Key? key}) : super(key: key);

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  late Future<List<Todo>> futureTodo;

  @override
  void initState() {
    super.initState();
    futureTodo = api_handler.instance.retrieveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('¡Bienvenido, ${Global.login}!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CrearMensaje(),
            ),
          );
        },
        tooltip: 'Crear nota',
        child: const Icon(Icons.add_rounded),
      ),
      body: FutureBuilder<List<Todo>>(
        future: api_handler.instance.retrieveTodos(),
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
                  // trailing: IconButton(
                  //   alignment: Alignment.center,
                  //   icon: const Icon(Icons.delete),
                  //   onPressed: () async {
                  //     // _deleteTodo(snapshot.data![index]);
                  //     // setState(() {});
                  //   },
                  // ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Oops!");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

_deleteTodo(Todo todo) {
  api_handler.instance.deleteTodo(todo.id!);
}

_get_Details() {}

_navigateToDetail(BuildContext context, Todo todo) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CrearMensaje(todo: todo)),
  );
}
