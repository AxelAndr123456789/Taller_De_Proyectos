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
  int _selectedOption = 0;
  int _currentQuestion = 1;
  final int _totalQuestions = 10;
  bool _isSubmitting = false;
  final ResultManager _resultManager = ResultManager();

  final List<String> _options = [
    'Totalmente en desacuerdo',
    'En desacuerdo',
    'De acuerdo',
    'Totalmente de acuerdo',
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

  void _goToNextQuestion() {
    if (_currentQuestion >= _totalQuestions && _isSubmitting) {
      return;
    }
    
    if (_currentQuestion < _totalQuestions) {
      setState(() {
        _currentQuestion++;
        _selectedOption = 0;
      });
    } else {
      setState(() {
        _isSubmitting = true;
      });
      
      _resultManager.addResult(widget.testType, widget.testTitle);
      
      if (_resultManager.areAllTestsCompleted()) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PantallaResultados()),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡${widget.testTitle} completado!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        
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
      setState(() {
        _currentQuestion--;
        _selectedOption = 0;
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

  String _getInteresVocacionalQuestion(int number) {
    final questions = [
      '¿Disfrutas diseñando gráficos digitales?',
      '¿Te gusta investigar temas científicos?',
      '¿Te interesa ayudar a personas con problemas?',
      '¿Disfrutas trabajando con números y datos?',
      '¿Te gusta crear contenido artístico?',
      '¿Te interesan las máquinas y la tecnología?',
      '¿Disfrutas organizando eventos?',
      '¿Te gusta enseñar a otras personas?',
      '¿Te interesa el mundo de los negocios?',
      '¿Disfrutas analizando problemas complejos?',
    ];
    return questions[number - 1];
  }

  String _getAptitudesQuestion(int number) {
    final questions = [
      '¿Te resulta fácil resolver problemas matemáticos complejos?',
      '¿Tienes buena memoria para recordar detalles?',
      '¿Eres hábil con las herramientas manuales?',
      '¿Tienes facilidad para aprender idiomas?',
      '¿Eres bueno identificando patrones?',
      '¿Tienes buena coordinación mano-ojo?',
      '¿Eres bueno expresándote por escrito?',
      '¿Tienes facilidad para entender mapas?',
      '¿Eres bueno trabajando bajo presión?',
      '¿Tienes habilidad para negociar?',
    ];
    return questions[number - 1];
  }

  String _getPersonalidadQuestion(int number) {
    final questions = [
      '¿Prefieres trabajar en equipo que individualmente?',
      '¿Te consideras una persona extrovertida?',
      '¿Eres meticuloso con los detalles?',
      '¿Te gusta tomar riesgos?',
      '¿Eres paciente con los demás?',
      '¿Prefieres seguir instrucciones que dar órdenes?',
      '¿Te adaptas fácilmente a cambios?',
      '¿Eres bueno manejando el estrés?',
      '¿Prefieres rutinas establecidas?',
      '¿Te gusta tomar decisiones rápidas?',
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
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
