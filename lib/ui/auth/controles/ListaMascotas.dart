import 'package:flutter/material.dart';
import 'package:mypetapp/data/services/peticionesPetsFirebase.dart';

class ListaMascotas extends StatefulWidget {
  const ListaMascotas({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListaMascotasState createState() => _ListaMascotasState();
}

class _ListaMascotasState extends State<ListaMascotas> {
  List<Map<String, dynamic>> _mascotas = [];

  @override
  void initState() {
    super.initState();
    _getMascotas();
  }

  Future<void> _getMascotas() async {
    List<Map<String, dynamic>> mascotas =
        await PeticionesPet.consultarMascotas();

    setState(() {
      _mascotas = mascotas;
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
          Text('Lista De Mascota',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
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
      child: ListView.builder(
        padding: const EdgeInsets.all(18.0),
        itemCount: _mascotas.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> mascota = _mascotas[index];

           return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListTile(
                  leading: mascota['foto'] != ''
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            mascota['foto'],
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(right: 5, left: 5),
                          child: Icon(Icons.pets, size: 50, color: Color.fromARGB(255, 106 ,59 ,27)),
                        ),
                  title: Text(
                    mascota['nombre'],
                    style: const TextStyle(color: Color.fromARGB(255, 10, 10, 10)),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  PeticionesPet.eliminarmascota(mascota['id']);
                  _getMascotas();
                },
                icon: const Icon(Icons.delete, size: 40, color: Colors.white),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          );
        },
      ),
    ),
  );
}
}
