import 'package:flutter/material.dart';
import 'package:proyecto_apps/pages/crearMensaje.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      width: 220,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                "Integrantes",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Creditos(),
                  ),
                );
              },
            ),
            //ListTile(
            //  title: const Text("Agregar Nota"),
            //  onTap: () {
            //    Navigator.push(
            //      context,
            //      MaterialPageRoute(
            //        builder: (context) => CrearMensaje(),
            //      ),
            //    );
            //  },
            //),
          ],
        ),
      ),
    );
  }
}

class Creditos extends StatelessWidget {
  const Creditos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: const [
            Text(
              "Nicolas 'Zso' Rojas",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Vicente 'Chulz' Schultz",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
