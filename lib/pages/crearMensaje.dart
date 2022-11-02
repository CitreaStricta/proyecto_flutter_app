import 'package:flutter/material.dart';

import '../global.dart';
import '../models/todo.dart';
import '../widgets/database_helper.dart';

class CrearMensaje extends StatefulWidget {
  static const routeName2 = '/detailTodoScreen';
  Todo? todo;

  CrearMensaje({Key? key, this.todo}) : super(key: key);

  @override
  State<CrearMensaje> createState() => _CrearMensajeState(todo);
}

class _CrearMensajeState extends State<CrearMensaje> {
  Todo? todo;
  final descriptionTextController = TextEditingController();
  final titleTextController = TextEditingController();

  _CrearMensajeState(this.todo);

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      descriptionTextController.text = todo!.content;
      titleTextController.text = todo!.title;
    }
  }

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
    titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingreso de Tareas'),
      ),
      body: Column(
        children: <Widget>[
          // area de titulo
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  labelText: "Título"),
              maxLines: 1,
              controller: titleTextController,
            ),
          ),
          // area de texto (descripcion)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  labelText: "Descripción"),
              maxLines: 10,
              controller: descriptionTextController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () async {
            if (titleTextController.text.isEmpty) {
              var snackBar =
                  const SnackBar(content: Text('Debe ingresar el título'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              if (descriptionTextController.text.isEmpty) {
                var snackBar = const SnackBar(
                    content: Text('Debe ingresar la descripción'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                _saveTodo(
                    titleTextController.text, descriptionTextController.text);
                setState(() {});
              }
            }
          }),
    );
  }

  _saveTodo(String title, String content) async {
    if (todo == null) {
      api_handler.instance.insertTodo(Todo(
        title: titleTextController.text,
        content: descriptionTextController.text,
        login: Global.login,
      ));
      Navigator.pop(context, "Tu tarea fue guardada.");
    } else {
      await api_handler.instance.updateTodo(Todo(
        id: todo?.id,
        login: Global.login,
        title: title,
        content: content,
      ));
      Navigator.pop(context);
    }
  }
}
