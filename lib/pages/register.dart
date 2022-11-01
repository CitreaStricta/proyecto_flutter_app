import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto_apps/global.dart';
import 'package:proyecto_apps/pages/login.dart';
import 'package:proyecto_apps/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final pref;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  Future<void> registrarDatos(String user, String password) async {
    final response = await LoginService().registrar(user, password);

    print("register status code: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login
      Global.login = user;
      Navigator.pop(context);
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Ese user ya está registrado',
        loopAnimation: false,
      );
    }
  }

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
  }

  SizedBox sizedBox(double height) {
    return SizedBox(height: height);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Crea tu cuenta",
                textScaleFactor: 1.2,
              ),
              sizedBox(30),
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  hintText: "Ingrese su nombre de usuario",
                  labelText: "Usuario",
                  suffixIcon: const Icon(Icons.person),
                ),
              ),
              sizedBox(10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                  hintText: "Ingrese su password",
                  labelText: "Password",
                  suffixIcon: const Icon(Icons.lock),
                ),
              ),
              sizedBox(10),
              TextField(
                controller: passwordConfirmController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                  hintText: "Confirme su password",
                  labelText: "Confirmar password",
                  suffixIcon: const Icon(Icons.lock),
                ),
              ),
              sizedBox(60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.indigo,
                  shape: const StadiumBorder(),
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: () {
                  if (userController.text.isEmpty) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Oops...',
                      text: 'Debes proporcionar un nombre de usuario',
                      loopAnimation: false,
                    );
                  } else if (passwordController.text.isEmpty) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Oops...',
                      text: 'Debes proporcionar una password',
                      loopAnimation: false,
                    );
                  } else if (passwordConfirmController.text.isEmpty) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Oops...',
                      text: 'Debes confirmar la password',
                      loopAnimation: false,
                    );
                  } else if (!passwordController.text
                      .contains(passwordConfirmController.text)) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Oops...',
                      text: 'Las passwords deben coincidir',
                      loopAnimation: false,
                    );
                  } else {
                    registrarDatos(
                      userController.text,
                      passwordController.text,
                    );
                  }
                },
                child: const Text("Registrarse"),
              ),
              sizedBox(30),
              GestureDetector(
                onTap: () {
                  // AQUI LA DIRECCION PARA LA PAGINA DE SIGN_UP
                },
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // AQUI TAMBIEN LA DIRECCION PARA LA PAGINA DE SIGN_UP
                  },
                  child: const Text(
                    "Ya tengo cuenta",
                    style: TextStyle(
                      color: Colors.blue,
                      inherit: false,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
