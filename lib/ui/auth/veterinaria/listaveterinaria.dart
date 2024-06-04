import 'package:flutter/material.dart';
import 'package:mypetapp/ui/auth/veterinaria/veterinaria.dart';
import 'package:mypetapp/ui/auth/veterinaria/veterinaria_card.dart';


class ListaVeterinarias extends StatelessWidget {
  final List<Veterinaria> veterinarias = [
Veterinaria(
  nombre: "Veterinaria Animalitos",
  direccion: "Diagonal 21 # Trasversal 21 -35",
  telefono: "+57 320 6354717",
  logoUrl: 'assets/images/logo4.png',
  /*mapaUrl: "https://g.co/kgs/nWeK9VJ",
  instagramUrl: "https://www.instagram.com/veterinaria__animalitos_/",
  whapUrl:"https://api.whatsapp.com/send?phone=573206354717",onTapWhatsapp: () {  },*/
  publicidadUrl: "assets/images/publicidad5.jpg", 
),
Veterinaria(
  nombre: "Clínica Veterinaria Pulgas",
  direccion: "Cra. 19D #7a 25",
  telefono: "+57 300 7366038",
  logoUrl: 'assets/images/pu2.png',
  /*mapaUrl: "https://www.google.com/maps?um=1&fb=1&gl=co&sa=X&geocode=KZXMW1rSuYqOMeklBQP2_HTU&daddr=Cra.+19D+%237a+25,+La+Elvira,+Valledupar,+Cesar&ved=2ahUKEwix-ePOqKyGAxUVi6sHHbJOBo0QiBN6BQgAEMoC",
  instagramUrl: "https://www.instagram.com/pulgasvalledupar/",
  whapUrl:"https://api.whatsapp.com/send/?phone=573007366038&text&type=phone_number&app_absent=0",onTapWhatsapp: () {  },*/
  publicidadUrl: "assets/images/pu1.png",
),
Veterinaria(
  nombre: "DogtorPet Clínica Veterinaria",
  direccion: "Carrera 19 # 9 A - 69",
  telefono: "+57 301 6422167\n+57 322 5270309",
  logoUrl: 'assets/images/logo5.png',
  /*mapaUrl: "https://www.google.com/maps/place//data=!4m2!3m1!1s0x8e8ab9e8010d7c49:0x137d85f1925afd35",onTapWhatsapp: () {  },
  instagramUrl: "https://www.instagram.com/dogtorpetclinica/?hl=es",
  whapUrl: "https://beacons.ai/dogtorpet",*/


  
  publicidadUrl: "assets/images/pu3.png",
),

  ];

  
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
        title: const Text('Veterinarias',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/veterinaria1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
            itemCount: veterinarias.length,
            itemBuilder: (context, index) {
              return VeterinariaCard(
                nombre: veterinarias[index].nombre,
                direccion: veterinarias[index].direccion,
                telefono: veterinarias[index].telefono,
                logoUrl: veterinarias[index].logoUrl,
                
                
                
                publicidadUrl: veterinarias[index].publicidadUrl, 
              );
            },
          ),
        ],
      ),
    );
  }
}

