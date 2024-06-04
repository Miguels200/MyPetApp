import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mypetapp/ui/auth/controles/ListaMascotas.dart';
import 'package:mypetapp/ui/auth/controles/controlPets.dart';
import 'package:mypetapp/ui/auth/veterinaria/listaveterinaria.dart';

import 'package:mypetapp/ui/auth/controles/historialControlPets.dart';
import 'package:mypetapp/ui/auth/controles/pets.dart';
import 'package:mypetapp/ui/auth/login/login.dart';

import 'package:mypetapp/ui/auth/veterinaria/veterinariainfo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navegar a la pantalla de mascotas
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  ListaVeterinarias(),
          ),
        );
        break;
      case 1:
        // Navegar a la pantalla de perfil
        // Aquí deberías reemplazar 'Perfil' con el nombre de tu pantalla de perfil
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const VeterinaryInfo()
          ),
        );
        
    }
  }

  final List<String> imagePaths = [
    'assets/images/publicidad1.jpg',
    'assets/images/publicidad2.jpg',
    'assets/images/publicidad3.jpg',
  ];


  @override
  void initState() {
    super.initState();
    _getPerfil();
  }

  Future<void> _getPerfil() async {

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                child: ClipOval(
                  child: Image.asset("assets/images/logo1.png"),
                ),
              ),
              const Text(
                'MyPetApp',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Login(),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/home.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 18 / 9,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                    ),
                    items: imagePaths.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Pets(),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              height: 225,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/AddMascota.png'),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ControlPets(),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              height: 225,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/AgregarControl.png'),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HistorialControlWidget(),
                                ),
                              );
                            },
                            child: Container(
                              width: 175,
                              height: 225,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/Historial.png'),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ListaMascotas(),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              height: 225,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/ListaMascotas.png'),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset( 0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Barra de navegación inferior con imagen de fondo
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/barra.png"), // Ruta de la imagen de fondo
                    fit: BoxFit.cover,
                  ),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent, // Fondo transparente para que se vea la imagen de fondo
                  items: [ BottomNavigationBarItem(
                      icon: Icon(Icons.pets, color: Colors.white), // Color de ícono blanco
                      label: 'Veterinarias',
                    ),
                    /*BottomNavigationBarItem(
                      icon: Icon(Icons.history, color: Colors.white), // Color de ícono blanco
                      label: 'Historial',
                    ),*/
                    BottomNavigationBarItem(
                      icon: Icon(Icons.info_outline, color: Colors.white), // Color de ícono blanco
                      label: 'Info',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.amber,
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  unselectedItemColor: Colors.white,
                  selectedLabelStyle: TextStyle(color: Colors.white),
                  unselectedLabelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}


    
