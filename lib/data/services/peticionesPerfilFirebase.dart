import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class Peticiones {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    print(catalogo['foto']);

    var url = '';
    if (foto != null) {
      url = await Peticiones.cargarfoto(
          foto, catalogo['nombre'] + catalogo['apellido']);
    }
    print(url);
    catalogo['foto'] = url.toString();

    await _db.collection('perfiles').doc().set(catalogo).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<dynamic> cargarfoto(var foto, var idArt) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Perfiles");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idArt).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }

  static Future<void> actualizarcatalogo(
      String id, Map<String, dynamic> catalogo) async {
    await _db.collection('catalogoTI').doc(id).update(catalogo).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('catalogoTI').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<List<Map<String, dynamic>>> consultarUsuario() async {
    List<Map<String, dynamic>> mascotas = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('perfiles')
          .where('idUser', isEqualTo: currentUser.uid)
          .get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        mascotas.add(data);
      });
    }
    return mascotas;
  }
}
