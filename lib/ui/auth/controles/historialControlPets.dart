import 'package:flutter/material.dart';
import 'package:mypetapp/ui/auth/controles/actualizarControlPets.dart';

import '../../../data/services/peticionesControlPetsFirebase.dart';

class HistorialControlWidget extends StatefulWidget {
  const HistorialControlWidget({Key? key}) : super(key: key);

  @override
  _HistorialControlState createState() => _HistorialControlState();
}

class _HistorialControlState extends State<HistorialControlWidget> {
  List<Map<String, dynamic>> _controlmascotas = [];

  @override
  void initState() {
    super.initState();
    _getControlMascotas();
  }

  Future<void> _getControlMascotas() async {
    List<Map<String, dynamic>> mascotas =
        await PeticionesControlPet.consultarControlMascotas();

    setState(() {
      _controlmascotas = mascotas;
    });
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
          Text(
            'Historia De Mascotas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25, // Ajusta según necesidad, 24 podría ser muy grande dependiendo del dispositivo
            ),
          ),
        ],
      ),
    ),
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: _controlmascotas.length,
          itemBuilder: (context, index) {
            final mascota = _controlmascotas[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: 355,
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 226),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              mascota['selectmascota'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Fecha: ${mascota['fechaCita']}',
                              ),
                            ),
                            SizedBox(height: 3),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Veterinaria: ${mascota['veterinaria']}',
                              ),
                            ),
                            SizedBox(height: 3),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Detalles: ${mascota['detallesCita']}',
                              ),
                            ),
                            SizedBox(height: 3),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Peso: ${mascota['peso']} kg',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 5),
                                  Text('Editar'),
                                ],
                              ),
                              value: 'editar',
                            ),
                            const PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 5),
                                  Text('Eliminar'),
                                ],
                              ),
                              value: 'eliminar',
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == 'editar') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ActualizarControlPets(
                                    controlId: mascota['id']),
                              ),
                            );
                          } else if (value == 'eliminar') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirmar eliminación'),
                                  content: Text(
                                      '¿Estás seguro de que deseas eliminar este control?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Eliminar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        PeticionesControlPet.eliminarcontrolmascota(
                                            mascota['id']);
                                        _getControlMascotas();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
}
