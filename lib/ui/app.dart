import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypetapp/ui/auth/controles/ListaMascotas.dart';
import 'package:mypetapp/ui/auth/controles/controlPets.dart';
import 'package:mypetapp/ui/auth/controles/pets.dart';

import 'package:mypetapp/ui/auth/veterinaria/listaveterinaria.dart';


import 'package:mypetapp/ui/auth/veterinaria/veterinariainfo.dart';
import 'package:mypetapp/ui/auth/login/welcome.dart';

import 'auth/home.dart';
import 'auth/login/login.dart';
import 'auth/login/recuperarContraseña.dart';
import 'auth/login/register.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WelcomeScreen',
      initialRoute: '/welcome',
      routes: {
         "/welcome": (context) =>  Welcome(),
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/registroMascota": (context) => const Pets(),
        "/home": (context) => Home(),
        "/controlPets": (context) => const ControlPets(),
        "/listaMascotas": (context) => const ListaMascotas(),
        "/recordarContraseña": (context) => const ForgoPassword(),
        "/veterinariainfo": (context) => const VeterinaryInfo(),
         "/googlemaps": (context) => ListaVeterinarias()
      },
    );
  }
}
