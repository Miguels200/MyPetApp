import 'package:get/get.dart';

import 'package:mypetapp/data/services/peticionesPetsFirebase.dart';

class ControlPets extends GetxController {
  Future<void> crearMascota(Map<String, dynamic> mascota, foto) async {
    await PeticionesPet.crearmascota(mascota, foto);
  }

  Future<void> eliminarMascota(String id) async {
    await PeticionesPet.eliminarmascota(id);
  }

  Future<void> actualizarMascota(
      String id, Map<String, dynamic> mascota) async {
    await PeticionesPet.actualizarmascota(id, mascota);
  }

  Future<void> consultarMascota() async {
    await PeticionesPet.consultarMascotas();
  }
}
