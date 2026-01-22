import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test de Intereses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Epilogue',
        useMaterial3: true,
      ),
      home: const InterestsTestScreen(),
    );
  }
}

class InterestsTestScreen extends StatefulWidget {
  const InterestsTestScreen({super.key});

  @override
  State<InterestsTestScreen> createState() => _InterestsTestScreenState();
}

class _InterestsTestScreenState extends State<InterestsTestScreen> {
  int _selectedIndex = 1; // Tests está seleccionado
  int _selectedOption = 0; // Opción seleccionada (0 = Strongly Disagree)
  int _currentQuestion = 1;
  final int _totalQuestions = 10;

  // Lista de opciones de respuesta
  final List<String> _options = [
    'Totalmente en desacuerdo',
    'En desacuerdo',
    'Neutral',
    'De acuerdo',
    'Totalmente de acuerdo',
  ];

  // Navegación entre pantallas
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) { // Home
      Navigator.pop(context);
    } else if (index >= 2) { // Otras pantallas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Funcionalidad en desarrollo'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _selectOption(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  void _goToNextQuestion() {
    if (_currentQuestion < _totalQuestions) {
      setState(() {
        _currentQuestion++;
        _selectedOption = 0; // Reiniciar selección
      });
    } else {
      // Si es la última pregunta, mostrar mensaje de completado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Test completado!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _goToPreviousQuestion() {
    if (_currentQuestion > 1) {
      setState(() {
        _currentQuestion--;
        _selectedOption = 0; // Reiniciar selección
      });
    }
  }

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
                        'Test de Intereses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111618),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Barra de progreso
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pregunta $_currentQuestion de $_totalQuestions',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111618),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Barra de progreso
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE2E5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _currentQuestion / _totalQuestions,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF111618),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Pregunta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '¿Disfrutas diseñando gráficos digitales?',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111618),
                  ),
                ),
              ),
            ),

            // Opciones de respuesta
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(_options.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildOptionCard(
                        text: _options[index],
                        isSelected: _selectedOption == index,
                        onTap: () => _selectOption(index),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Botones de navegación
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón Anterior
                  Expanded(
                    child: Material(
                      color: const Color(0xFFF0F3F4),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: _currentQuestion > 1 ? _goToPreviousQuestion : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          child: Text(
                            'Anterior',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _currentQuestion > 1
                                  ? const Color(0xFF111618)
                                  : const Color(0xFF111618).withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Botón Siguiente
                  Expanded(
                    child: Material(
                      color: const Color(0xFF1798CF),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: _goToNextQuestion,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            'Siguiente',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Barra de navegación inferior
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
                  _buildNavButton(1, Icons.list, 'Tests'),
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

  Widget _buildOptionCard({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF111618)
                  : const Color(0xFFDCE2E5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111618),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Radio button personalizado
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF111618)
                        : const Color(0xFFDCE2E5),
                    width: 2,
                  ),
                  color: Colors.white,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF111618),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
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