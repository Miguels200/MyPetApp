import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mypetapp/ui/auth/home.dart';
import 'package:uuid/uuid.dart';

import '../../../data/services/peticionesPetsFirebase.dart';
import '../../../domain/controller/controllerControlPets.dart';

class ControlPets extends StatefulWidget {
  const ControlPets({Key? key}) : super(key: key);

  @override
  State<ControlPets> createState() => _ControlPetsState();
}

class _ControlPetsState extends State<ControlPets> {
  AgregarControlPets controlup = Get.find();
  String? selectedMascota;
  TextEditingController controlFechaCita = TextEditingController();
  TextEditingController controlVeterinaria = TextEditingController();
  TextEditingController controlDetallesCita = TextEditingController();
  TextEditingController controlPeso = TextEditingController();
  TextEditingController controlProximaCita = TextEditingController();
  DateTime? selectedDate;
  DateTime? selectedProximaCitaDate;
  List<Map<String, dynamic>> mascotas = [];
  late Uuid uuid;
  late String id;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controlFechaCita.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectProximaCitaDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedProximaCitaDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedProximaCitaDate) {
      setState(() {
        selectedProximaCitaDate = picked;
        controlProximaCita.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> cargarDatosMascotas() async {
    var resultado = await PeticionesPet.consultarMascotas();

    setState(() {
      mascotas = resultado;
    });
  }

  @override
  void initState() {
    super.initState();
    uuid = Uuid();
    id = uuid.v4();
    cargarDatosMascotas();
  }

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
        title: Row(
          children: [
           
            const SizedBox(width: 8),
            const Text('Agregar Control',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
          ],
        ),
      ),
      body: Container(
        
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home1.png"),
            fit: BoxFit.cover,
          ),
        ),
  

        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 52),
              DropdownButtonFormField<String>(
                value: selectedMascota,
                items: mascotas.map((mascota) {
                  return DropdownMenuItem<String>(
                    value: mascota['nombre'].toString(),
                    child: Text(mascota['nombre']),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedMascota = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Seleccionar mascota',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 4, color: Color.fromARGB(255, 247, 248, 248)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 246, 246, 246)),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Fecha de la cita:',
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
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controlFechaCita,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 4, color: Color.fromARGB(255, 241, 242, 243)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 2, color: Color.fromARGB(255, 246, 247, 248)),
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
              const SizedBox(height: 15),
              const Text(
                'Veterinaria:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: controlVeterinaria,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 4, color: Color.fromARGB(255, 252, 253, 253)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 237, 239, 240)),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la veterinaria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Detalles de la cita:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(255, 245, 246, 248), width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: controlDetallesCita,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Peso:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: controlPeso,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 4, color: Color.fromARGB(255, 244, 243, 245)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 242, 244, 245)),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el peso de la mascota';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Próxima cita:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  _selectProximaCitaDate(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controlProximaCita,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 4, color: Color.fromARGB(255, 247, 247, 248)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 2, color: Color.fromARGB(255, 243, 243, 243)),
                      ),
                      hintStyle: const TextStyle(color: Color.fromARGB(255, 248, 248, 251)),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: const Color.fromARGB(255, 106 ,59 ,27),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                child: const Text("Registrar control",style: TextStyle(
    color: Color.fromARGB(255, 239, 240, 241), fontSize: 18,// Cambia el color aquí
  ),
                ),
                style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 106 ,59 ,27),// Cambia el color aquí
  ),
                onPressed: () {
                  if (selectedMascota == null || selectedMascota!.isEmpty) {
                    // Mostrar mensaje de error
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content:
                              const Text('Por favor, selecciona una mascota.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (controlFechaCita.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Por favor, ingresa la fecha de la cita.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (controlVeterinaria.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Por favor, ingresa el nombre de la veterinaria.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (controlPeso.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Por favor, ingresa el peso de la mascota.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (controlProximaCita.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Por favor, ingresa la fecha de la próxima cita.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Resto del código para registrar el control
                    User? user = FirebaseAuth.instance.currentUser;
                    String? userId = user?.uid;
                    var catalogo = <String, dynamic>{
                      // 'idControl': id,
                      'selectmascota': selectedMascota,
                      'fechaCita': controlFechaCita.text,
                      'veterinaria': controlVeterinaria.text,
                      'detallesCita': controlDetallesCita.text,
                      'peso': controlPeso.text,
                      'proximacita': controlProximaCita.text,
                      'idUser': userId
                    };

                    controlup.crearControlMascota(catalogo);
                    // Registro exitoso
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Registro exitoso'),
                          content: const Text(
                              'El control de la mascota ha sido registrado exitosamente.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
