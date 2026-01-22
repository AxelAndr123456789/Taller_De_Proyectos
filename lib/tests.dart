import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tests Stitch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Epilogue',
        useMaterial3: true,
      ),
      home: const TestsScreen(),
    );
  }
}

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  int _selectedIndex = 1; // Tests está seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header con botón de regreso y título
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: const Color(0xFF111618),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111618),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Espacio para centrar
                ],
              ),
            ),

            // Contenido desplazable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Test 1: Intereses Vocacionales
                    _buildTestCard(
                      category: 'Intereses Vocacionales',
                      title: 'Descubre Tu Pasión',
                      description:
                          'Explora carreras alineadas con tus intereses y pasiones.',
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuB1EDx4Ly3T3eE-pK-GoFg9aqAsDQGarLGTEKfSslbhTk046A7g5ka9FOussvOzLhd-u70PmCaozOR3JGlUmsY0tq7EoR3MaDd8NUmqqyX4eAR030Wg-k8urTeCWVrCF1D3EUwHq1UqOPkwJqjMdepMq3VZ0dnVWKS8Pjw6hVKiccsZgRxAE2AVOjEvHcwZhi06opm7EzyFsxTgL1uDmcVmGspUEUatbi4Pf75-kcX-h7q7d58JTH3a5Nz4LOUv_23BcAFJ-UK64Yl0',
                    ),
                    const SizedBox(height: 16),

                    // Test 2: Aptitudes
                    _buildTestCard(
                      category: 'Aptitudes',
                      title: 'Descubre Tus Fortalezas',
                      description:
                          'Identifica tus talentos naturales y habilidades para encontrar caminos profesionales adecuados.',
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAUnQmCqYGAalEH844C6WJmOI9hOwBm7qLPbZdEOEN1rbIESN-C2DZB6gm7PT5x4hi_9-x9IRq2XldbOpkJToL2Vmltf7f_s_wSBFqNIPSrZL0CMiuK2D1JGaFxhxBOz04jy3nVuGuPDSlKXUnumAYLcutVfhw7BfnrJ64TgU3uvm0RQHbJZhV4Z28eFXtNCVNM7VaQe3ehHCepeQML2DsYJYRmPCuD0-IXNgvnRnG5NnBLbf-WDWSK5UjHZSuMCkj-8fRbtU1dMNXW',
                    ),
                    const SizedBox(height: 16),

                    // Test 3: Personalidad
                    _buildTestCard(
                      category: 'Personalidad',
                      title: 'Conoce Tu Verdadero Yo',
                      description:
                          'Comprende tus rasgos de personalidad y cómo se adaptan a diferentes profesiones.',
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCF_N0UNsQaHoperFMXs7Q2wlfVn-WGy4gefWoL0ztTQ9Eu_nxSfp6rX5gVtiMQU8TIwBySIvlVu7fYTmMQImoeAvIV6yhRhC9RoAnvnLvU_2CP3kL8gjqeP_gcGRZl5TLbWLyUxrjHQ_TFSsI53DONKW49FkhMjYcA0TQtGm09eROfecYtiKVPZIgH63MoFqb45BLoE87DG1-mrDVpGfztbYjQjJHp_UBDuUEXoN7-BwhskyDwUXmRGy3kRKen3Rg3C4X7tWjlGPwI',
                    ),
                    const SizedBox(height: 20), // Espacio extra al final
                  ],
                ),
              ),
            ),

            // Barra de navegación inferior CON ANIMACIONES
            Container(
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
                  _buildNavButton(1, Icons.list, 'Tests'), // Tests activo por defecto
                  _buildNavButton(2, Icons.bar_chart, 'Resultados'),
                  _buildNavButton(3, Icons.work, 'Carreras'),
                  _buildNavButton(4, Icons.person, 'Perfil'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard({
    required String category,
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF637D88),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111618),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF637D88),
                  ),
                ),
                const SizedBox(height: 12),
                // BOTÓN "COMENZAR" - ÚNICO ELEMENTO SELECCIONABLE EN LAS TARJETAS
                Material(
                  color: const Color(0xFFF0F3F4),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      // Acción al presionar el botón "Comenzar"
                      print('Botón Comenzar presionado para: $title');
                      // Aquí puedes agregar la navegación a la pantalla del test
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: const Text(
                        'Comenzar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111618),
                        ),
                      ),
                    ),
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
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Barra de navegación CON ANIMACIONES pero sin funcionalidad de navegación
  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        // Solo cambia la selección visual, no navega
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
              color: isSelected
                  ? const Color(0xFF0052FF)
                  : const Color(0xFF637D88),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF0052FF)
                  : const Color(0xFF637D88),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}