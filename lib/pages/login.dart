import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto_apps/global.dart';
import 'package:proyecto_apps/pages/principal.dart';
import 'package:proyecto_apps/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late final pref;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> validarDatos(String email, String password) async {
    final response = await LoginService().validar(email, password);

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login

      await pref.setString('usuario', email);

      Global.login = email;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Principal()));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'El pepe ete sech',
        loopAnimation: false,
      );
    }
  }

  String? login_guardado = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargaPreferencia();
  }

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    login_guardado = pref.getString("usuario");
    emailController.text = login_guardado == null ? "" : login_guardado!;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = const SizedBox(height: 30);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // SizedBox(
              //   width: 400,
              //   height: 200,
              //   child: Image.asset('assets/tocho.jpg', fit: BoxFit.fill),
              // ),
              sizedBox,
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      hintText: "Ingrese su email",
                      labelText: "Email",
                      suffixIcon:
                          const Icon(Icons.email, color: Colors.black54))),
              sizedBox,
              TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      hintText: "Ingrese su password",
                      labelText: "password",
                      suffixIcon: const Icon(Icons.remove_red_eye))),
              sizedBox,
              sizedBox,
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo, shape: StadiumBorder()),
                      onPressed: () {
                        if (emailController.text.length == 0) {
                          Fluttertoast.showToast(
                              msg: "Ingrese un email valido",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          validarDatos(
                              emailController.text, passwordController.text);
                        }
                      },
                      child: Text("Acceder ඞ"))),
              sizedBox,
              GestureDetector(
                onLongPress: () {
                  print("Longpress");
                },
                onTap: () {
                  print("hola");
                },
                child: Text(
                  "¿Olvido su password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // AQUI LA DIRECCION PARA LA PAGINA DE SIGN_UP
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
