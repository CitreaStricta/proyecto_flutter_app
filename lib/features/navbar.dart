import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proyecto_apps/pages/login.dart';

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
        ],
      ),
    );
  }
}
