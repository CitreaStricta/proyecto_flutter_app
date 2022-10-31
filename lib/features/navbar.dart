import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proyecto_apps/pages/login.dart';
import 'package:proyecto_apps/pages/page1.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text("Log Out"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Integrantes"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => credito(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Agregar Nota"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page1(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class credito extends StatelessWidget {
  const credito({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Center(
              child: Column(
        children: [
          Center(
            child: Text("Nicolas 'Zso' Rojas"),
          ),
          Center(
            child: Text("Vicente 'Chulz' Schultz"),
          )
        ],
      ))),
    );
  }
}
