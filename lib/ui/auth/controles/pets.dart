import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypetapp/domain/controller/controllerPetsFirebase.dart';
import 'package:mypetapp/domain/controller/controllerUserFirebase.dart';

class Pets extends StatefulWidget {
  const Pets({Key? key}) : super(key: key);

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  ControlPets controlup = Get.find();
  ControlUserAuth userController = Get.find();
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlRaza = TextEditingController();
  TextEditingController controlFechaNacimiento = TextEditingController();
  String? selectedSexo;
  ImagePicker picker = ImagePicker();
  var _image;

  _galeria() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  _camara() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controlFechaNacimiento.text = picked.toString();
      });
    }
  }

  bool _validateFields() {
    return controlNombre.text.isNotEmpty &&
        controlRaza.text.isNotEmpty &&
        controlFechaNacimiento.text.isNotEmpty &&
        selectedSexo != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        title: const Row(
          children: [
            SizedBox(width: 8),
               Text('Registrar',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home1.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                'Nombre:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: controlNombre,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 4, color: Color.fromARGB(255, 250, 249, 249)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 250, 251, 251)),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Raza:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            
              TextField(
                controller: controlRaza,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 4, color: Color.fromARGB(255, 249, 250, 250)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 247, 248, 248)),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Fecha nacimiento:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: controlFechaNacimiento,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 4, color: Color.fromARGB(255, 252, 252, 253)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 2, color: Color.fromARGB(255, 249, 249, 250)),
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: const Color.fromARGB(255, 106 ,59 ,27),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Sexo:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedSexo,
                items: <String>['Macho', 'Hembra']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSexo = newValue;
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 4, color: Color.fromARGB(255, 237, 237, 238)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 249, 250, 250)),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _opcioncamara(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 100,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: _image != null
                          ? Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            )
                          : Icon(
                              Icons.camera_alt,
                              color: const Color.fromARGB(255, 106 ,59 ,27),
                            ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              ElevatedButton(
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), backgroundColor: const Color.fromARGB(255, 106 ,59 ,27), // Cambia el color de fondo del botón
  ),
  onPressed: () {
    if (_validateFields()) {
      User? user = FirebaseAuth.instance.currentUser;
      String? userId = user?.uid;
      var catalogo = <String, dynamic>{
        'nombre': controlNombre.text,
        'raza': controlRaza.text,
        'fechaNacimiento': controlFechaNacimiento.text,
        'sexo': selectedSexo,
        'foto': '',
        'idUser': userId
      };

      controlup.crearMascota(catalogo, _image);
      Get.toNamed('/home');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Campos obligatorios'),
          content:
              const Text('Por favor, completa todos los campos.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  },
  child: Text(
    "Registrar Mascota",
    style: TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold), // Estilo del texto
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  void _opcioncamara(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 106 ,59 ,27),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library,color: Color.fromARGB(255, 248, 247, 247),),
                  title: const Text('Imagen de Galeria',style: TextStyle(color: Color.fromARGB(255, 253, 253, 252)),),
                  onTap: () {
                    _galeria();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera,color: Color.fromARGB(255, 248, 247, 247),),
                  title: const Text('Capturar Imagen',style: TextStyle(color: Color.fromARGB(255, 253, 253, 252)),),
                  onTap: () {
                    _camara();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
