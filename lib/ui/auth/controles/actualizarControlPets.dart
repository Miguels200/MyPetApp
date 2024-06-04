import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mypetapp/data/services/peticionesControlPetsFirebase.dart';
import 'package:mypetapp/ui/auth/home.dart';
import '../../../domain/controller/controllerControlPets.dart';

class ActualizarControlPets extends StatefulWidget {
  final String controlId;

  const ActualizarControlPets({required this.controlId, Key? key})
      : super(key: key);

  @override
  _ActualizarControlPetsState createState() => _ActualizarControlPetsState();
}

class _ActualizarControlPetsState extends State<ActualizarControlPets> {
  AgregarControlPets controlup = Get.find();
  String? selectedMascota;
  TextEditingController controlFechaCita = TextEditingController();
  TextEditingController controlVeterinaria = TextEditingController();
  TextEditingController controlDetallesCita = TextEditingController();
  TextEditingController controlPeso = TextEditingController();
  TextEditingController controlProximaCita = TextEditingController();
  DateTime? selectedFechaCita;
  DateTime? selectedProximaCita;
  List<Map<String, dynamic>> mascotas = [];

  Future<void> _selectFechaCita(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFechaCita ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedFechaCita) {
      setState(() {
        selectedFechaCita = picked;
        controlFechaCita.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectProximaCita(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedProximaCita ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedProximaCita) {
      setState(() {
        selectedProximaCita = picked;
        controlProximaCita.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> cargarDatosMascotas() async {
    var resultado = await PeticionesControlPet.datosControl(widget.controlId);

    setState(() {
      mascotas = resultado;
      if (mascotas.isNotEmpty) {
        selectedMascota = mascotas[0]['selectmascota'].toString();
        controlFechaCita.text = mascotas[0]['fechaCita'].toString();
        controlVeterinaria.text = mascotas[0]['veterinaria'].toString();
        controlDetallesCita.text = mascotas[0]['detallesCita'].toString();
        controlPeso.text = mascotas[0]['peso'].toString();
        controlProximaCita.text = mascotas[0]['proximacita'].toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cargarDatosMascotas();
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
          Text('Actualizar Mascota',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                 ),
                 ),
                 ],
                ),
                ),
      body: Column(
        children: [
       
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/home1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                             'Mascota:',style: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 8),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white), // Agregar borde blanco
  ),
  child: DropdownButtonFormField<String>(
    decoration: const InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      border: InputBorder.none, // Eliminar borde del InputDecoration
    ),
    value: selectedMascota,
    items: mascotas
        .map((mascota) => DropdownMenuItem<String>(
              value: mascota['selectmascota'].toString(),
              child: Text(mascota['selectmascota'].toString()),
            ))
        .toList(),
    onChanged: (value) {
      setState(() {
        selectedMascota = value;
      });
    },
    autovalidateMode: AutovalidateMode.disabled, // Disable user interaction
  ),
),


 const SizedBox(height: 10),
  const Text(
  'Fecha de cita:',
  style: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 8),
GestureDetector(
  onTap: () => _selectFechaCita(context),
  child: AbsorbPointer(
    child: TextFormField(
      controller: controlFechaCita,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent, // Sin fondo
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Borde blanco en estado enfocado
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Borde blanco en estado desenfocado
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: Icon(Icons.calendar_today, color: const Color.fromARGB(255, 106 ,59 ,27)), // Icono de calendario en el lado derecho
      ),
    ),
  ),
),

    const SizedBox(height: 10),
    const Text(
  'Veterinaria:',
  style: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 8),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.white), // Borde blanco
  ),
  child: TextFormField(
    controller: controlVeterinaria,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent, // Sin fondo
      border: InputBorder.none, // Sin borde en el input decoration
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    ),
  ),
),

    const SizedBox(height: 10),
const Text(
  'Detalles de la cita:',
  style: TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 8),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.white), // Borde blanco
  ),
  child: TextFormField(
    controller: controlDetallesCita,
    maxLines: 3,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent, // Sin fondo
      border: InputBorder.none, // Sin borde en el input decoration
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    ),
  ),
),

    const SizedBox(height: 10),
const Text(
  'Peso (kg):',
  style: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 8),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.white), // Borde blanco
  ),
  child: TextFormField(
    controller: controlPeso,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.allow(
        RegExp(r'^\d+\.?\d{0,1}'),
      ),
    ],
    decoration: const InputDecoration(
      filled: true,
      fillColor: Colors.transparent, // Sin fondo
      border: InputBorder.none, // Sin borde en el input decoration
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    ),
  ),
),

const SizedBox(height: 10),
const Text(
  'Próxima cita:',
  style: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 8),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.white), // Borde blanco
  ),
  child: GestureDetector(
    onTap: () => _selectProximaCita(context),
    child: AbsorbPointer(
      child: TextFormField(
        controller: controlProximaCita,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.transparent, // Sin fondo
          border: InputBorder.none, // Sin borde en el input decoration
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          suffixIcon: Icon(
            Icons.calendar_today_rounded, // Icono del calendario
            color:  Color.fromARGB(255, 106 ,59 ,27), // Color marrón del icono
          ),
        ),
      ),
    ),
  ),
),

SizedBox(height: 15,),
SizedBox(
  width: double.infinity,
  height: 60,
  child: ElevatedButton(
    onPressed: () async {
      if (selectedMascota != null &&
          controlFechaCita.text.isNotEmpty &&
          controlVeterinaria.text.isNotEmpty &&
          controlDetallesCita.text.isNotEmpty &&
          controlPeso.text.isNotEmpty &&
          controlProximaCita.text.isNotEmpty) {
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
        controlup.actualizarControlMascota(
            widget.controlId, catalogo);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Actualización exitosa'),
              content: const Text(
                  'El control de la mascota ha sido actualizado exitosamente.'),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 106 ,59 ,27)), // Color marrón del botón
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: const Text('Cerrar', style: TextStyle(color: Colors.white)), // Letras blancas
                ),
              ],
            );
          },
        );
      } else {
        Get.snackbar('Error',
            'Por favor, complete todos los campos',
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM);
      }
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 106 ,59 ,27)),
    ),
    child: const Text(
      'Actualizar',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Letras blancas
      ),
    ),
  ),
),

                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
