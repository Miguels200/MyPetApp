import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypetapp/domain/controller/controllerControlPets.dart';
import 'package:mypetapp/domain/controller/controllerPerfilFirebase.dart';
import 'package:mypetapp/domain/controller/controllerPetsFirebase.dart';
import 'package:mypetapp/domain/controller/controllerUserFirebase.dart';
import 'package:mypetapp/ui/app.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAeDZJu3jFkBLnNFZkikkDdBz_adYwHkP4",
              authDomain: "mypetapp-570da.firebaseapp.com",
              projectId: "mypetapp-570da",
              storageBucket: "mypetapp-570da.appspot.com",
              messagingSenderId: "946165842097",
              appId: "1:946165842097:web:8b30c79f39118cafede290"))
      : await Firebase.initializeApp();

  Get.put(ControlUserAuth());
  Get.put(ControlUserPerfil());
  Get.put(ControlPets());
  Get.put(AgregarControlPets());
  runApp(const App());
}
