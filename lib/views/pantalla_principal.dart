import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/result_manager.dart';
import '../models/test_result.dart';
import 'views.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _selectedIndex = 0;
  bool _isTestHovered = false;
  final ResultManager _resultManager = ResultManager();

  void _navigateToTab(int index) {
    if (index == _selectedIndex) return;
    
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaPerfil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentResults = _resultManager.getRecentResults();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = kIsWeb && screenWidth > 800;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 1200 : double.infinity,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isDesktop ? 24 : 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuA4DO2yOPKDC3cmgRmFZfQSRFTl_aXnrY2YXTK7Kr1I7yy-nmSTFjnhMsvLB3saicwJIt4z8DwMoixOC_Kg5V_I3L1eokXg8Aii7j0VeXyETMGIiHpwGauh__wCuZdknh9aFD9cuJOC6kJhCNkEMBuVFoc-Ysa5o4L2hN20qpqC6ID3zCPEHevyMdhFCUBFKXDH7nh7aGO8towkzUYJeBLaa0l2hv-RC8wlRZGZWcLh0V3P5cQPLE4Tfazb4jMFeL87O9lGkx2HyqlS',
                            ),
                            radius: isDesktop ? 30 : 20,
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Inicio',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, Sofia',
                            style: TextStyle(
                              fontSize: isDesktop ? 28 : 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF121617),
                            ),
                          ),
                          SizedBox(height: isDesktop ? 30 : 20),

                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const TestsScreen()),
                              );
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
                                      ? const Color(0xFF0052FF).withValues(alpha: 0.3)
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

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 32 : 16, 
                        vertical: isDesktop ? 30 : 20
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carreras Destacadas',
                            style: TextStyle(
                              fontSize: isDesktop ? 26 : 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF121617),
                            ),
                          ),
                          SizedBox(height: isDesktop ? 18 : 12),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildCareerCard(
                                  imageUrl:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCcIFpt9OxmhsqKarIdcM7hoFrWzUDCg1xFqSt5E5MpJoivKeT9RBV4HGoH4jmEqGmbL-7r-NUtMEJkvyqfohyofUdBAk0BHntMQ7MwLVrG1f9NbHe_3gFPMsFh94Xw9H1WCVe97098iAS1mOqUnS_mY7rGjacz_dfxK0dHPyHlNUpS-f7ENAAFdd3NOM9BRu-j6-QL9XcaicmkNelkym1zfa3b6WefMgSJavT4WwsgRSOi5LeN6q9f0OyYxui3ZBAHk6Vqsc5zCvnk',
                                  title: 'Médico',
                                  description: 'Profesional de la salud',
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                _buildCareerCard(
                                  imageUrl:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBFr1zXdezl1vxFCR7qgHvXVKJJWc6vDf7s_J57A16RMKXIUSq-XD506NmAUhSuVqOwHe1u18Wjc-Atdc599WvvzwLcKt-WEGDS-B3bQUuWf4EsHft0RRS8JBoGEvB9PubKZYQ9_4B3qhj7z16aIhdIBxTauXFcpz4yttdHm3DP-4A7wgaVNcOMyNq4DMswYkJ5lhY_pnzsa66mJ3FyeJQaA9rt0h0nJ3Np2PmRIKinucgmnfajN1-9U8GfIrYFJW1KX1gm58YlNDHh',
                                  title: 'Ingeniero',
                                  description: 'Diseña y construye',
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                _buildCareerCard(
                                  imageUrl:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCJFbJLYCEDTWyD5rsxe5XbxVibQ56a9Sr0d1kWBApS1KEzxwb6Zz2xRI6OFrK8USKu5qF8M-_R1EHd-oC-ddwceYOxuQ3uMy4Mro7zJ_Tjur5dvxZ0CJJFfKRDL9jed5xZK8Zrr8Qvedt6EJp1I1NJd5ONPiSIp-diRdEAhgrJ7aIJql0Xe2XZIhu1ZXXvNbVQA6RhXHJu1jWx2ItqPDp8b9OHpRKv7RhPIMUFaJhq86nX02O2itQnCScU4qWzLjtc8OfcrY37I95n',
                                  title: 'Arquitecto',
                                  description: 'Crea diseños de edificios',
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Resultados Recientes',
                            style: TextStyle(
                              fontSize: isDesktop ? 26 : 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF121617),
                            ),
                          ),
                          SizedBox(height: isDesktop ? 18 : 12),

                          if (recentResults.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.assignment_outlined,
                                    color: Color(0xFF657C86),
                                    size: 60,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'No hay resultados recientes',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF121617),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Completa un test para ver tus resultados aquí',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF657C86),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Column(
                              children: recentResults.map((result) {
                                return _buildResultCard(result);
                              }).toList(),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: isDesktop ? 60 : 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
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
            _buildNavButton(1, Icons.list, 'Tests'),
            _buildNavButton(2, Icons.bar_chart, 'Resultados'),
            _buildNavButton(3, Icons.work, 'Carreras'),
            _buildNavButton(4, Icons.person, 'Perfil'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(TestResult result) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.testTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF121617),
                  ),
                ),
                Text(
                  'Completado el ${result.formattedDate}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF657C86),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerCard({
    required String imageUrl,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = kIsWeb && screenWidth > 800;
    final cardWidth = isDesktop ? 180.0 : 150.0;
    final cardHeight = isDesktop ? 200.0 : 170.0;
    
    return SizedBox(
      width: cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 12 : 8),
          Text(
            title,
            style: TextStyle(
              fontSize: isDesktop ? 17 : 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF121617),
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: isDesktop ? 15 : 13,
              color: const Color(0xFF657C86),
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _navigateToTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFF0052FF) : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF637D88),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
