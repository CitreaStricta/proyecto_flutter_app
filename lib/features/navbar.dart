import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proyecto_apps/pages/login.dart';

class navBar extends StatelessWidget {
  const navBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: Text("Log Out"),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => login())),
        )
      ],
    ));
  }
}
