import 'package:flutter/material.dart';

class VeterinaryInfo extends StatefulWidget {
  const VeterinaryInfo({Key? key}) : super(key: key);

  @override
  _VeterinaryInfoState createState() => _VeterinaryInfoState();
}

class _VeterinaryInfoState extends State<VeterinaryInfo> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String backgroundImage = "assets/images/info1.png";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        backgroundImage = _tabController.index == 0 
            ? "assets/images/info1.png" 
            : "assets/images/gato.png";
      });
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
        title: const Text(
          'Información Veterinaria',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                'Perros',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Gatos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            Builder(
              builder: (context) => _buildDogInfo(context),
            ),
            _buildCatInfo(),
          ],
        ),
      ),
    );
  }

Widget _buildDogInfo(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Vacunación',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'Los perros deben ser vacunados a las 6-8 semanas de edad. Las vacunas principales incluyen:',
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 4.0,
                  title: const Text(
                    'Vacunación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Las vacunas principales incluyen:\n\n'
                    '1. Parvovirus\n'
                    '2. Moquillo\n'
                    '3. Hepatitis\n'
                    '4. Leptospirosis\n'
                    '5. Rabia\n\n'
                    'Consulta con tu veterinario para un calendario de vacunación adecuado.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Desparasitación',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'Es importante desparasitar a los perros regularmente para prevenir parásitos intestinales.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Desparasitación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Los cachorros deben ser desparasitados por primera vez a las 2-3 semanas de edad.\nLuego, desparasítalos cada 2 semanas hasta las 12 semanas de edad, y después cada mes hasta los 6 meses de edad. Consulta con tu veterinario para un plan adecuado.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Baño',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'Los perros deben ser bañados cada 4-6 semanas, dependiendo de la raza y tipo de pelaje.',
              textAlign: TextAlign.justify,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Baño del Perro',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Los perros deben ser bañados cada 4-6 semanas, dependiendo de la raza y tipo de pelaje. Si el perro tiene problemas de piel o suciedad extrema, consulta con tu veterinario para un plan de baño adecuado.',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Corte de Pelo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'El corte de pelo de tu perro depende de la raza y tipo de pelaje. En general, muchos perros necesitan ser cortados cada 6-8 semanas.',
              textAlign: TextAlign.justify,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Corte de Pelo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'El corte de pelo de tu perro depende de la raza y tipo de pelaje. En general, muchos perros necesitan ser cortados cada 6-8 semanas. Sin embargo, algunas razas pueden necesitar cortes más frecuentes, mientras que otras pueden necesitar menos. Consulta con tu peluquero canino para un plan de corte de pelo adecuado.',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Cuidado Dental',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'El cuidado dental es esencial para prevenir problemas dentales en los perros.',
              textAlign: TextAlign.justify,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Cuidado Dental',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Los perros necesitan cuidado dental regular para prevenir problemas como el sarro y la gingivitis. Cepilla los dientes de tu perro regularmente con pasta dental específica para perros y consulta con tu veterinario sobre la limpieza dental profesional si es necesario.',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


 Widget _buildCatInfo() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Vacunación',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'Los gatos deben ser vacunados a las 8-9 semanas de edad. Las vacunas principales incluyen:',
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 4.0,
                  title: const Text(
                    'Vacunación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Las vacunas principales incluyen:\n\n'
                    '1. Panleucopenia\n'
                    '2. Rinotraqueitis\n'
                    '3. Calicivirus\n'
                    '4. Rabia\n\n'
                    'Consulta con tu veterinario para un calendario de vacunación adecuado.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Desparasitación',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'Es importante desparasitar a los gatos regularmente para prevenir parásitos intestinales.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Desparasitación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Los gatitos deben ser desparasitados por primera vez a las 6-8 semanas de edad.\nLuego, desparasítalos cada 2 semanas hasta las 12 semanas de edad, y después cada mes hasta los 6 meses de edad. Consulta con tu veterinario para un plan adecuado.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Baño',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'Los gatos no necesitan ser bañados con frecuencia, a menos que estén muy sucios o tengan problemas de piel.',
              textAlign: TextAlign.justify,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Baño del Gato',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Los gatos suelen mantenerse limpios a través del acicalamiento. Sin embargo, pueden necesitar un baño ocasional si se ensucian mucho o tienen problemas de piel. Utiliza champús específicos para gatos y consulta a tu veterinario para un plan de baño adecuado.',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Corte de Uñas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'El corte de uñas es importante para evitar que los gatos se lastimen a sí mismos o a otros.',
              textAlign: TextAlign.justify,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Corte de Uñas',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Las uñas de los gatos deben ser cortadas regularmente para evitar que se lastimen a sí mismos o a otros. Usa cortaúñas específicos para gatos y ten cuidado de no cortar demasiado cerca de la parte rosada de la uña, donde están los vasos sanguíneos. Si no te sientes cómodo haciéndolo, consulta a tu veterinario o a un profesional.',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: const Text(
              'Cuidado Dental',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: const Text(
              'El cuidado dental es esencial para prevenir problemas dentales en los gatos.',
              textAlign: TextAlign.justify,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Cuidado Dental',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Los gatos necesitan cuidado dental regular para prevenir problemas como el sarro y la gingivitis. Cepilla los dientes de tu gato regularmente con pasta dental específica para gatos y consulta con tu veterinario sobre la limpieza dental profesional si es necesario.',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}
