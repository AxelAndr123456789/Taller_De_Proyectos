import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diseño Stitch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Epilogue',
        useMaterial3: true,
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _selectedIndex = 0;
  bool _isTestHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // AÑADIDO: Scroll para evitar overflow
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                // Header con avatar y título
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuA4DO2yOPKDC3cmgRmFZfQSRFTl_aXnrY2YXTK7Kr1I7yy-nmSTFjnhMsvLB3saicwJIt4z8DwMoixOC_Kg5V_I3L1eokXg8Aii7j0VeXyETMGIiHpwGauh__wCuZdknh9aFD9cuJOC6kJhCNkEMBuVFoc-Ysa5o4L2hN20qpqC6ID3zCPEHevyMdhFCUBFKXDH7nh7aGO8towkzUYJeBLaa0l2hv-RC8wlRZGZWcLh0V3P5cQPLE4Tfazb4jMFeL87O9lGkx2HyqlS',
                        ),
                        radius: 20,
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Inicio',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF121617),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // Saludo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hola, Sofia',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF121617),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Nueva sección de test
                      InkWell(
                        onTap: () {
                          print('Tomar Nuevo Test presionado');
                        },
                        onHover: (hovering) {
                          setState(() {
                            _isTestHovered = hovering;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(
                              color: _isTestHovered
                                  ? const Color(0xFF0052FF).withOpacity(0.3)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nuevo',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF657C86),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    AnimatedDefaultTextStyle(
                                      duration: const Duration(milliseconds: 200),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _isTestHovered
                                            ? const Color(0xFF0052FF)
                                            : const Color(0xFF121617),
                                      ),
                                      child: const Text('Tomar Nuevo Test'),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Descubre tu camino profesional ideal con nuestra última evaluación.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF657C86),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBlYrcl6zA9TR987a1cg4VcUP8YP8AWV5TYB0puseqDj5GMQ0Gdpw1upLtWZun55kfr_-pXKSya9bAdZzMFP_AEWFcGGw34o3-uful07LGfjzGw1KXIK6KXFS8AxTGDO7MK2p6gY1yUsN7f1kDWKJiKdlHCtAhXhp4RRi5nPyTndB0vuZWE_CCLd53EZhdUTL88kqEHeHEKA4g3Uoi3cEJ2RrYli586EXWGiBMiOt7xKCDwSyRumqlZn8OIYUxb5s4knQxUZST6U6Cw',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Carreras destacadas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Carreras Destacadas',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF121617),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lista horizontal de carreras - SIN altura fija
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCcIFpt9OxmhsqKarIdcM7hoFrWzUDCg1xFqSt5E5MpJoivKeT9RBV4HGoH4jmEqGmbL-7r-NUtMEJkvyqfohyofUdBAk0BHntMQ7MwLVrG1f9NbHe_3gFPMsFh94Xw9H1WCVe97098iAS1mOqUnS_mY7rGjacz_dfxK0dHPyHlNUpS-f7ENAAFdd3NOM9BRu-j6-QL9XcaicmkNelkym1zfa3b6WefMgSJavT4WwsgRSOi5LeN6q9f0OyYxui3ZBAHk6Vqsc5zCvnk',
                              title: 'Médico',
                              description: 'Profesional de la salud',
                            ),
                            const SizedBox(width: 12),
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBFr1zXdezl1vxFCR7qgHvXVKJJWc6vDf7s_J57A16RMKXIUSq-XD506NmAUhSuVqOwHe1u18Wjc-Atdc599WvvzwLcKt-WEGDS-B3bQUuWf4EsHft0RRS8JBoGEvB9PubKZYQ9_4B3qhj7z16aIhdIBxTauXFcpz4yttdHm3DP-4A7wgaVNcOMyNq4DMswYkJ5lhY_pnzsa66mJ3FyeJQaA9rt0h0nJ3Np2PmRIKinucgmnfajN1-9U8GfIrYFJW1KX1gm58YlNDHh',
                              title: 'Ingeniero',
                              description: 'Diseña y construye',
                            ),
                            const SizedBox(width: 12),
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCJFbJLYCEDTWyD5rsxe5XbxVibQ56a9Sr0d1kWBApS1KEzxwb6Zz2xRI6OFrK8USKu5qF8M-_R1EHd-oC-ddwceYOxuQ3uMy4Mro7zJ_Tjur5dvxZ0CJJFfKRDL9jed5xZK8Zrr8Qvedt6EJp1I1NJd5ONPiSIp-diRdEAhgrJ7aIJql0Xe2XZIhu1ZXXvNbVQA6RhXHJu1jWx2ItqPDp8b9OHpRKv7RhPIMUFaJhq86nX02O2itQnCScU4qWzLjtc8OfcrY37I95n',
                              title: 'Arquitecto',
                              description: 'Crea diseños de edificios',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Últimos resultados
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resultados Recientes',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF121617),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tarjeta de resultado
                      InkWell(
                        onTap: () {
                          print('Resultado presionado');
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xFFF0F3F4),
                                ),
                                child: const Icon(
                                  Icons.bar_chart,
                                  color: Color(0xFF121617),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Test de Aptitud Profesional',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF121617),
                                      ),
                                    ),
                                    Text(
                                      'Completado el 15-01-2024',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF657C86),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF121617),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Espacio antes de la navegación
                const SizedBox(height: 40),

                // Barra de navegación inferior (FIJA abajo)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFF0F3F4)),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavButton(0, Icons.home, 'Inicio'),
                      _buildNavButton(1, Icons.assessment, 'Tests'),
                      _buildNavButton(2, Icons.list_alt, 'Resultados'),
                      _buildNavButton(3, Icons.work, 'Carreras'),
                      _buildNavButton(4, Icons.person, 'Perfil'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCareerCard({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 150, // Reducido un poco más
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print('Carrera $title seleccionada');
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 150,
              height: 170, // Reducido para evitar overflow
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15, // Reducido ligeramente
              fontWeight: FontWeight.w500,
              color: Color(0xFF121617),
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13, // Reducido ligeramente
              color: Color(0xFF657C86),
            ),
            maxLines: 2, // Limitar a 2 líneas
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF0052FF).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF657C86),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11, // Reducido para evitar overflow
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF657C86),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}