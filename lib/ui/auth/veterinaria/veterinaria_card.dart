import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VeterinariaCard extends StatelessWidget {
  final String nombre;
  final String direccion;
  final String telefono;
  final String logoUrl;

  final String publicidadUrl;

  VeterinariaCard({
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.logoUrl,

    required this.publicidadUrl, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          _mostrarInformacionVeterinaria(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(logoUrl),
                    radius: 30,
                  ),
                 const  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     const  SizedBox(height: 5),
                      Text(
                        direccion,
                        style: const  TextStyle(fontSize: 16),
                      ),
                      Text(
                        telefono,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarInformacionVeterinaria(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nombre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(publicidadUrl),
              const SizedBox(height: 20),
              Text("Dirección: $direccion"),
              Text("Teléfono: $telefono"),
              const SizedBox(height: 10),
            
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,color: Color.fromARGB(249, 6, 6, 6)
                ),
                ),
            ),
          ],
        );
      },
    );
  }

  void _abrirUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      
      throw 'No se puede abrir la URL: $url';
    }
  }
}
