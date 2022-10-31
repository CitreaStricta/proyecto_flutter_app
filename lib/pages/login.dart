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

<<<<<<< HEAD
=======
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
          builder: (context) => Principal(),
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

>>>>>>> 2c537208fd8425b088b6754355afbb23d4c2d4bb
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
              sizedBox(10),
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

  Future<void> validarDatos(String email, String password) async {
    final response = await LoginService().validar(email, password);

    print("login status code: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login
      await pref.setString('Usuario', email);
      Global.login = email;
      // EL INICIO PARA EL CONTEXTO DE LA PANTALLA "Principal" ESTA BIEN AQUI?
      // NO SERIA MEJOR PARA LAS PERSONAS QUE LEEN EL CODIGO QUE ESTE
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
        text: 'Email o password incorrectos',
        loopAnimation: false,
      );
    }
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
    emailController.text = login_guardado == null ? "" : login_guardado!;
  }

  SizedBox sizedBox(double _height) {
    return SizedBox(height: _height);
  }
}
