import 'package:get/get.dart';
import 'package:mypetapp/data/services/peticionesControlPetsFirebase.dart';

class AgregarControlPets extends GetxController {
  Future<void> crearControlMascota(Map<String, dynamic> mascota) async {
    await PeticionesControlPet.crearcontrolmascota(mascota);
  }

  Future<void> eliminarControlMascota(String id) async {
    await PeticionesControlPet.eliminarcontrolmascota(id);
  }

  Future<void> actualizarControlMascota(
      String id, Map<String, dynamic> mascota) async {
    await PeticionesControlPet.actualizarcontrolmascota(id, mascota);
  }

  Future<void> consultarControlMascota() async {
    await PeticionesControlPet.consultarControlMascotas();
  }

  Future<void> cargarDatosControl(String id) async {
    await PeticionesControlPet.datosControl(id);
  }
}
