import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypetapp/ui/auth/controles/auth_google.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mypetapp/domain/controller/controllerUserFirebase.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  String emailValue = '';
  String passwordValue = '';
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    loadLastValues();
  }

  Future<void> loadLastValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailValue = prefs.getString('email') ?? '';
      passwordValue = prefs.getString('password') ?? '';
      user.text = emailValue;
      pass.text = passwordValue;
    });
  }

  Future<void> saveLastValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailValue);
    await prefs.setString('password', passwordValue);
  }

  @override
  Widget build(BuildContext context) {
    ControlUserAuth controlua = Get.find();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Loginn.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 50),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height *
                      0.4, // Ajuste aquí para subir los campos
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: user,
                      onChanged: (value) {
                        setState(() {
                          emailValue = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10), // Añadir padding
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.brown,
                            width:
                                1.0, // Asegurarse de que el ancho del borde sea suficiente
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.brown,
                            width:
                                1.0, // Asegurarse de que el ancho del borde sea suficiente
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: pass,
                      onChanged: (value) {
                        setState(() {
                          passwordValue = value;
                        });
                      },
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10), // Añadir padding
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 80, 49, 5),
                            width:
                                1.0, // Asegurarse de que el ancho del borde sea suficiente
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 80, 49, 5),
                            width:
                                1.0, // Asegurarse de que el ancho del borde sea suficiente
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            saveLastValues();
                            controlua
                                .ingresarUser(user.text, pass.text)
                                .then((value) {
                              if (controlua.userValido == null) {
                                Get.snackbar(
                                  "Usuarios",
                                  controlua.mensajesUser,
                                  duration: const Duration(seconds: 4),
                                  backgroundColor:
                                      const Color.fromARGB(255, 150, 137, 101),
                                );
                              } else {
                                Get.snackbar(
                                  "Usuarios",
                                  controlua.mensajesUser,
                                  duration: const Duration(seconds: 4),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 242, 226),
                                );
                                Get.toNamed("/home");
                              }
                            });
                          },
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(left: 15),
                              width: 300,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 80, 49, 5),
                              ),
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          try {
                            final user = await AuthUser.loginGoogle();
                            if (user != null) {
                              Get.offAllNamed("/home");
                            }
                          } on FirebaseAuthException catch (error) {
                            print(error.message);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    error.message ?? 'Ups... Algo salio mal')));
                          } catch (error) {
                            print(error);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                          }
                        },
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/go.png',
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Inicia sesión con Google',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/register");
                          },
                          child: const Text(
                            'Registrarse',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/recordarContraseña");
                          },
                          child: const Text(
                            'Recordar Contraseña',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
