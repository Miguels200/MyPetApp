import 'dart:convert'; // Importa esta biblioteca para usar json.decode
import 'package:http/http.dart'
    as http; // Importa http para hacer solicitudes HTTP
import 'package:firebase_auth/firebase_auth.dart';

class PeticionesControlPet {
  // static final String baseUrl =
  //     'http://api-service-pets:3000'; // Cambia esto por la URL de tu servidor
 static final String baseUrl =
      'http://35.184.213.200:3000'; 
  static Future<void> crearcontrolmascota(Map<String, dynamic> pets) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/controlpets'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pets),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create control pet');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> actualizarcontrolmascota(
      String id, Map<String, dynamic> pets) async {
    try {
      var response = await http.put(
        Uri.parse('$baseUrl/controlpets/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pets),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update control pet');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> eliminarcontrolmascota(String id) async {
    try {
      var response = await http.delete(Uri.parse('$baseUrl/controlpets/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete control pet');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Map<String, dynamic>>> consultarControlMascotas() async {
    try {
      // Obtiene el ID del usuario desde tu servicio de autenticación
      String? userId = FirebaseAuth.instance.currentUser?.uid; 
      // Por ejemplo, suponiendo que tienes un método para obtener el ID del usuario

      var response = await http.get(Uri.parse('$baseUrl/controlpets?idUser=$userId'));

      if (response.statusCode == 200) {
        // Convierte el cuerpo de la respuesta de String a List<dynamic>
        List<dynamic> data = json.decode(response.body);
        // Mapea los elementos de la lista y conviértelos a Map<String, dynamic>
        List<Map<String, dynamic>> mascotas =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
        return mascotas;
      } else {
        throw Exception('Failed to fetch control pets');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> datosControl(String id) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/controlpets/$id'));

      if (response.statusCode == 200) {
        // Convierte el cuerpo de la respuesta de String a Map<String, dynamic>
        Map<String, dynamic> data = json.decode(response.body);
        return [data];
      } else {
        throw Exception('Failed to fetch control pet data');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
