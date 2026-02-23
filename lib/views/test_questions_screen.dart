import 'package:flutter/material.dart';
import '../models/result_manager.dart';
import 'views.dart';

class TestQuestionsScreen extends StatefulWidget {
  final String testType;
  final String testTitle;
   
  const TestQuestionsScreen({
    super.key,
    required this.testType,
    required this.testTitle,
  });

  @override
  State<TestQuestionsScreen> createState() => _TestQuestionsScreenState();
}

class _TestQuestionsScreenState extends State<TestQuestionsScreen> {
  int _selectedIndex = 1;
  int _selectedOption = -1;
  int _currentQuestion = 1;
  final int _totalQuestions = 10;
  bool _isSubmitting = false;
  final ResultManager _resultManager = ResultManager();
  
  // Almacenar respuestas de todas las preguntas
  final List<int> _allResponses = [];

  final List<String> _options = [
    'Totalmente de acuerdo',
    'De acuerdo',
    'En desacuerdo',
    'Totalmente en desacuerdo',
  ];

  void _navigateToTab(int index) {
    if (index == _selectedIndex) return;
    
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 1) {
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

  void _selectOption(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  Future<void> _goToNextQuestion() async {
    if (_currentQuestion >= _totalQuestions && _isSubmitting) {
      return;
    }
    
    // Validar que se haya seleccionado una opción
    if (_selectedOption == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una respuesta'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    
    // Guardar la respuesta actual
    if (_allResponses.length >= _currentQuestion) {
      _allResponses[_currentQuestion - 1] = _selectedOption;
    } else {
      _allResponses.add(_selectedOption);
    }
    
    if (_currentQuestion < _totalQuestions) {
      setState(() {
        _currentQuestion++;
        // Restaurar respuesta si ya existe
        if (_allResponses.length >= _currentQuestion) {
          _selectedOption = _allResponses[_currentQuestion - 1];
        } else {
          _selectedOption = -1;
        }
      });
    } else {
      setState(() {
        _isSubmitting = true;
      });

      // Guardar todas las respuestas del test y calcular resultado
      _resultManager.saveTestResponses(widget.testType, List.from(_allResponses));
      await _resultManager.addResult(widget.testType, widget.testTitle);

      if (_resultManager.areAllTestsCompleted()) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PantallaResultados()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('¡${widget.testTitle} completado!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TestsScreen()),
            );
          }
        });
      }
    }
  }

  void _goToPreviousQuestion() {
    if (_currentQuestion > 1) {
      // Guardar respuesta actual antes de retroceder
      if (_selectedOption != -1) {
        if (_allResponses.length >= _currentQuestion) {
          _allResponses[_currentQuestion - 1] = _selectedOption;
        } else {
          _allResponses.add(_selectedOption);
        }
      }
      
      setState(() {
        _currentQuestion--;
        // Restaurar respuesta anterior
        if (_allResponses.length >= _currentQuestion) {
          _selectedOption = _allResponses[_currentQuestion - 1];
        } else {
          _selectedOption = -1;
        }
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
            Container(
              padding: const EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: const Color(0xFF111618),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
                        );
                      },
                    ),
                  ),
                  
                  Center(
                    child: Text(
                      widget.testTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111618),
                      ),
                    ),
                  ),
                  
                  const Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                children: [
                  Text(
                    'Pregunta $_currentQuestion de $_totalQuestions',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111618),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE2E5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _currentQuestion / _totalQuestions,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF111618),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                _getQuestionForTest(widget.testType, _currentQuestion),
                style: TextStyle(
                  fontSize: _getQuestionForTest(widget.testType, _currentQuestion).length > 40 ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111618),
                ),
              ),
            ),

            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(_options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _buildMinimalOptionCard(
                      text: _options[index],
                      isSelected: _selectedOption == index,
                      onTap: () => _selectOption(index),
                    ),
                  );
                }),
              ),
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Material(
                      color: const Color(0xFFF0F3F4),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: _currentQuestion > 1 ? _goToPreviousQuestion : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Anterior',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _currentQuestion > 1
                                  ? const Color(0xFF111618)
                                  : const Color(0xFF111618).withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Material(
                      color: _currentQuestion < _totalQuestions 
                          ? const Color(0xFF1798CF)
                          : const Color(0xFF28a745),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: _goToNextQuestion,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Text(
                            _currentQuestion < _totalQuestions ? 'Siguiente' : 'Finalizar',
                            style: const TextStyle(
                              fontSize: 12,
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

            Container(
              padding: const EdgeInsets.only(top: 2, bottom: 6),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFF0F3F4))),
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

  String _getQuestionForTest(String testType, int questionNumber) {
    switch (testType) {
      case 'Intereses Vocacionales':
        return _getInteresVocacionalQuestion(questionNumber);
      case 'Aptitudes':
        return _getAptitudesQuestion(questionNumber);
      case 'Personalidad':
        return _getPersonalidadQuestion(questionNumber);
      default:
        return '¿Cómo te sientes acerca de esta actividad?';
    }
  }

  // Test de Intereses Vocacionales - 10 preguntas organizadas por áreas
  // Cada área tiene 1-2 preguntas específicas
  String _getInteresVocacionalQuestion(int number) {
    final questions = [
      // Administración y Negocios (2 preguntas)
      '¿Te interesa liderar equipos y tomar decisiones estratégicas en una empresa?',
      '¿Te gustaría gestionar recursos financieros y administrativos?',
      
      // Salud (2 preguntas)
      '¿Te apasiona ayudar a personas a mejorar su salud y bienestar?',
      '¿Te interesa conocer cómo funciona el cuerpo humano y tratar enfermedades?',
      
      // Ingeniería y Tecnología (2 preguntas)
      '¿Te fascina diseñar, construir o mejorar estructuras y máquinas?',
      '¿Te gustaría desarrollar software o trabajar con tecnología de vanguardia?',
      
      // Ciencias (1 pregunta)
      '¿Te interesa investigar fenómenos naturales y realizar experimentos científicos?',
      
      // Arte y Diseño (1 pregunta)
      '¿Disfrutas creando diseños, ilustraciones o espacios estéticamente atractivos?',
      
      // Educación (1 pregunta)
      '¿Te gustaría enseñar y formar a niños, jóvenes o adultos?',
      
      // Ciencias Sociales y Legal (1 pregunta)
      '¿Te interesa comprender el comportamiento humano o defender derechos y justicia?',
    ];
    return questions[number - 1];
  }

  // Test de Aptitudes - 10 preguntas organizadas por habilidades específicas de áreas
  String _getAptitudesQuestion(int number) {
    final questions = [
      // Administración (2 preguntas)
      '¿Eres bueno organizando información y gestionando múltiples tareas?',
      '¿Tienes facilidad para analizar datos numéricos y financieros?',
      
      // Salud (2 preguntas)
      '¿Tienes empatía y capacidad de escucha para atender a personas enfermas?',
      '¿Puedes mantener la calma y tomar decisiones rápidas en situaciones de emergencia?',
      
      // Ingeniería (2 preguntas)
      '¿Eres bueno resolviendo problemas matemáticos y lógicos?',
      '¿Tienes habilidad para visualizar objetos en 3D y entender cómo funcionan las cosas?',
      
      // Tecnología (2 preguntas)
      '¿Aprendes rápidamente a usar nuevos programas y aplicaciones?',
      '¿Eres bueno detectando errores y mejorando procesos sistemáticos?',
      
      // Comunicación y Creatividad (2 preguntas)
      '¿Eres bueno expresándote y comunicándote con diferentes tipos de personas?',
      '¿Tienes creatividad para proponer soluciones innovadoras?',
    ];
    return questions[number - 1];
  }

  // Test de Personalidad - 10 preguntas sobre rasgos de personalidad por área
  String _getPersonalidadQuestion(int number) {
    final questions = [
      // Administración y Liderazgo (2 preguntas)
      '¿Te consideras una persona organizada y responsable con los detalles?',
      '¿Disfrutas liderando equipos y coordinando actividades grupales?',
      
      // Salud (2 preguntas)
      '¿Eres paciente y comprensivo con las necesidades de otras personas?',
      '¿Puedes trabajar bajo presión sin perder la calma?',
      
      // Ingeniería y Tecnología (2 preguntas)
      '¿Prefieres trabajar con precisión y exactitud en tus tareas?',
      '¿Eres curioso y te gusta investigar cómo funcionan las cosas?',
      
      // Creatividad y Comunicación (2 preguntas)
      '¿Te adaptas fácilmente a nuevos ambientes y situaciones?',
      '¿Te consideras extrovertido y te gusta interactuar socialmente?',
      
      // Trabajo y Ética (2 preguntas)
      '¿Eres perseverante y no te rindes fácilmente ante los desafíos?',
      '¿Valoras el trabajo bien hecho y cumples con tus compromisos?',
    ];
    return questions[number - 1];
  }

  Widget _buildMinimalOptionCard({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF111618) : const Color(0xFFDCE2E5),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111618),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF111618) : const Color(0xFFDCE2E5),
                    width: 2,
                  ),
                  color: Colors.white,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
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
      )
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
