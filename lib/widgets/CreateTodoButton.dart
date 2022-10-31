import 'package:flutter/material.dart';

import '../pages/page1.dart';

class CreateTodoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateToCreateTodoScreen(context);
      },
      child: const Text('Crear Tarea'),
    );
  }

  _navigateToCreateTodoScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => Page1()),
    );
    //  Scaffold.of(context)
    //    ..removeCurrentSnackBar()
    //    ..showSnackBar(SnackBar(content: Text("$result")));

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$result")));
  }
}
