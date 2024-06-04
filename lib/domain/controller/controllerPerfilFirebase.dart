import 'package:get/get.dart';
import 'package:mypetapp/data/services/peticionesPerfilFirebase.dart';

class ControlUserPerfil extends GetxController {
  Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    await Peticiones.crearcatalogo(catalogo, foto);
  }

  Future<void> consultarUsuario() async {
    await Peticiones.consultarUsuario();
  }
}
