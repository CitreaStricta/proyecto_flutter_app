import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto_apps/global.dart';
import 'package:proyecto_apps/pages/principal.dart';
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  Future<void> validarDatos(String email, String password) async {
    final response = await LoginService().validar(email, password);

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login
      await pref.setString('Usuario', email);
      Global.login = email;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Principal(),
        ),
      );
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Algo salió mal :(',
        loopAnimation: false,
      );
    }
  }

  Future<void> registrarDatos(String email, String password) async {
    final response = await LoginService().registrar(email, password);

    print("register status code: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login
      Global.login = email;
      Navigator.pop(context);
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Ese email ya está registrado',
        loopAnimation: false,
      );
    }
  }

  String? login_guardado = "";

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
  }

  SizedBox sizedBox(double _height) {
    return SizedBox(height: _height);
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
              // SizedBox(
              //   width: 400,
              //   height: 200,
              //   child: Image.asset('assets/tocho.jpg', fit: BoxFit.fill),
              // ),
              const Text(
                "Crea tu cuenta",
                textScaleFactor: 1.2,
              ),
              sizedBox(30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  hintText: "Ingrese su email",
                  labelText: "Email",
                  suffixIcon: const Icon(Icons.email, color: Colors.black54),
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
                  labelText: "Confirm password",
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
                  if (emailController.text.isEmpty) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Oops...',
                      text: 'Debes proporcionar un email',
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
                      emailController.text,
                      passwordController.text,
                    );
                  }
                },
                child: Text("Registrarse"),
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
