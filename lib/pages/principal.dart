import 'package:flutter/material.dart';
import 'package:proyecto_apps/features/navbar.dart';
import 'package:proyecto_apps/pages/page1.dart';
import '../global.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("${Global.login}"),
      ),
    );
  }
}
