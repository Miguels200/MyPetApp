import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Importa esta biblioteca para File
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart'
    as http; // Importa http para hacer solicitudes HTTP

class PeticionesPet {
  static final String baseUrl =
      'http://35.184.213.200:3000'; // Cambia esto por la URL de tu servidor

static Future<void> crearmascota(Map<String, dynamic> pets, foto) async {
  print(pets['foto']);

  var url = '';
  if (foto != null) {
    url = await cargarfoto(foto, pets['nombre']);
  }
  print(url);
  pets['foto'] = url.toString();

  try {
    var response = await http.post(
      Uri.parse('$baseUrl/pets'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pets),
    );

    if (response.statusCode != 201) { // 201 es el código de éxito para creación
      throw Exception('Failed to create pet');
    }
  } catch (e) {
    print(e);
  }
}

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("pets");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }

  static Future<void> actualizarmascota(
      String id, Map<String, dynamic> pets) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/pets/$id'),
        body: pets,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update pet');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> eliminarmascota(String id) async {
    try {
      var response = await http.delete(Uri.parse('$baseUrl/pets/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete pet');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Map<String, dynamic>>> consultarMascotas() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser
          ?.uid; // Por ejemplo, suponiendo que tienes un método para obtener el ID del usuario

      var response = await http.get(Uri.parse('$baseUrl/pets?idUser=$userId'));

      if (response.statusCode == 200 || response.statusCode == 304) {
        // Convierte el cuerpo de la respuesta de String a List<dynamic>
        List<dynamic> data = json.decode(response.body);
        // Mapea los elementos de la lista y conviértelos a Map<String, dynamic>
        List<Map<String, dynamic>> mascotas =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
        return mascotas;
      } else {
        throw Exception('Failed to fetch pets: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
