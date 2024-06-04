import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgoPassword extends StatefulWidget {
  const ForgoPassword({super.key});

  @override
  State<ForgoPassword> createState() => _ForgoPasswordState();
}

class _ForgoPasswordState extends State<ForgoPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                  "Enlace de restablecimiento de contraseña enviado! Consultar su correo electrónico.",
                  textAlign: TextAlign.center),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }
  
@override
Widget build(BuildContext context) {
  // Obtiene el tamaño de la pantalla
  final size = MediaQuery.of(context).size;

  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(

      backgroundColor: Colors.transparent, // Hacer la AppBar transparente
      elevation: 0, // Quitar la sombra de la AppBar
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    body: SingleChildScrollView(
      child: Container(
        // Asegura que el contenedor tenga un tamaño mínimo que cubra toda la pantalla, pero puede crecer con el contenido
        constraints: BoxConstraints(minHeight: size.height),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/recordar.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              const SizedBox(height: 65),
              const Image(
                image: AssetImage("assets/images/logo2.png"),
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 50),
              const Text(
                "Por Favor, introduzca su dirreción de email. Recibirás un enlace para crear una nueva contraseña por correo electrónico",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade500),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () => passwordReset(),
                color: const Color.fromARGB(255, 80, 49, 5),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(
                    "Restablecer contraseña",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
             const  Spacer(), // Usar Spacer para asegurar que el contenido se distribuya a lo largo del contenedor
            ],
          ),
        ),
      ),
    ),
  );
 
}}
