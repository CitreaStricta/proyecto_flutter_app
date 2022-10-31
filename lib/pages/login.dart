import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto_apps/global.dart';
import 'package:proyecto_apps/pages/page2.dart';
import 'package:proyecto_apps/pages/principal.dart';
import 'package:proyecto_apps/pages/register.dart';
import 'package:proyecto_apps/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final pref;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> validarDatos(String user, String password) async {
    final response = await LoginService().validar(user, password);

    print("login status code: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login
      await pref.setString('Usuario', user);
      Global.login = user;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Page2(),
        ),
      );
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Usuario o password incorrectos',
        loopAnimation: false,
      );
    }
  }

  void recoverPassword(String user) {
    LoginService().recovery(user, context);
  }

  String? login_guardado = "";

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    cargaPreferencia();
  }

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    login_guardado = pref.getString("Usuario");
    userController.text = login_guardado == null ? "" : login_guardado!;
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
                "Inicia sesión",
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
                  suffixIcon: const Icon(Icons.person, color: Colors.black54),
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
                  } else {
                    validarDatos(
                      userController.text,
                      passwordController.text,
                    );
                  }
                },
                child: Text("Acceder"),
              ),
              sizedBox(30),
              GestureDetector(
                onLongPress: () {
                  print("Longpress");
                },
                onTap: () {
                  print("hola");
                },
                child: TextButton(
                  onPressed: () {
                    if (userController.text.isEmpty) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        title: 'Oops...',
                        text: 'Debes proporcionar un nombre de usuario',
                        loopAnimation: false,
                      );
                    } else {
                      recoverPassword(userController.text);
                    }
                  },
                  // AQUI TAMBIEN LA DIRECCION PARA LA PAGINA DE SIGN_UP
                  child: const Text(
                    "¿Olvido su password?",
                    style: TextStyle(
                      color: Colors.blue,
                      inherit: false,
                    ),
                  ),
                ),
              ),
              sizedBox(3),
              GestureDetector(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    );
                    // AQUI TAMBIEN LA DIRECCION PARA LA PAGINA DE SIGN_UP
                  },
                  child: const Text(
                    "Crear una cuenta",
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
