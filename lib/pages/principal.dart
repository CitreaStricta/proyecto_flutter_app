import 'package:flutter/material.dart';
import 'package:proyecto_apps/features/navbar.dart';
import '../global.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navBar(),
      appBar: AppBar(
        title: Text("Principal ${Global.login}"),
      ),
    );
  }
}
