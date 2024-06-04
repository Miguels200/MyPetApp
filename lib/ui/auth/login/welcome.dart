import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mypetapp/ui/auth/login/login.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    // Se inicia la animación del logo con un pequeño retardo
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _showLogo = true;
      });

      // Redirige a la pantalla de login después de 3 segundos
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/recordar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 3),
              curve: Curves.easeInOut,
              opacity: _showLogo ? 1.0 : 0.0, // Opacidad animada del logo
              child: Image.asset(
                'assets/images/logo3.png', // Ruta de tu logo en los assets
                width: 200, // Ancho del logo
              ),
            ),
          ),
        ],
      ),
    );
  }
}
