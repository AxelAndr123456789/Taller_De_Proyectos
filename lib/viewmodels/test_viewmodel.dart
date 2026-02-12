import 'package:flutter/foundation.dart';
import '../models/result_manager.dart';
import '../models/test_result.dart';

/// ViewModel para la gestión de tests vocacionales.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// y comunicación entre los Models (ResultManager, TestResult) y las Views.
/// Maneja el estado de los tests completados y la navegación.
class TestViewModel with ChangeNotifier {
  final ResultManager _resultManager = ResultManager();

  // Estado de la navegación de tabs
  int _selectedIndex = 1;

  // Estado del test actual
  int _currentQuestion = 1;
  int _selectedOption = 0;
  bool _isSubmitting = false;

  int get selectedIndex => _selectedIndex;
  int get currentQuestion => _currentQuestion;
  int get selectedOption => _selectedOption;
  bool get isSubmitting => _isSubmitting;
  int get totalQuestions => 10;

  // Opciones de respuesta
  final List<String> options = [
    'Totalmente en desacuerdo',
    'En desacuerdo',
    'De acuerdo',
    'Totalmente de acuerdo',
  ];

  // Tests disponibles
  final List<TestInfo> availableTests = [
    TestInfo(
      testType: 'Intereses Vocacionales',
      category: 'Intereses Vocacionales',
      title: 'Descubre Tu Pasión',
      description: 'Explora carreras alineadas con tus intereses y pasiones.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB1EDx4Ly3T3eE-pK-GoFg9aqAsDQGarLGTEKfSslbhTk046A7g5ka9FOussvOzLhd-u70PmCaozOR3JGlUmsY0tq7EoR3MaDd8NUmqqyX4eAR030Wg-k8urTeCWVrCF1D3EUwHq1UqOPkwJqjMdepMq3VZ0dnVWKS8Pjw6hVKiccsZgRxAE2AVOjEvHcwZhi06opm7EzyFsxTgL1uDmcVmGspUEUatbi4Pf75-kcX-h7q7d58JTH3a5Nz4LOUv_23BcAFJ-UK64Yl0',
    ),
    TestInfo(
      testType: 'Aptitudes',
      category: 'Aptitudes',
      title: 'Descubre Tus Fortalezas',
      description: 'Identifica tus talentos naturales y habilidades para encontrar caminos profesionales adecuados.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAUnQmCqYGAalEH844C6WJmOI9hOwBm7qLPbZdEOEN1rbIESN-C2DZB6gm7PT5x4hi_9-x9IRq2XldbOpkJToL2Vmltf7f_s_wSBFqNIPSrZL0CMiuK2D1JGaFxhxBOz04jy3nVuGuPDSlKXUnumAYLcutVfhw7BfnrJ64TgU3uvm0RQHbJZhV4Z28eFXtNCVNM7VaQe3ehHCepeQML2DsYJYRmPCuD0-IXNgvnRnG5NnBLbf-WDWSK5UjHZSuMCkj-8fRbtU1dMNXW',
    ),
    TestInfo(
      testType: 'Personalidad',
      category: 'Personalidad',
      title: 'Conoce Tu Verdadero Yo',
      description: 'Comprende tus rasgos de personalidad y cómo se adaptan a diferentes profesiones.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCF_N0UNsQaHoperFMXs7Q2wlfVn-WGy4gefWoL0ztTQ9Eu_nxSfp6rX5gVtiMQU8TIwBySIvlVu7fYTmMQImoeAvIV6yhRhC9RoAnvnLvU_2CP3kL8gjqeP_gcGRZl5TLbWLyUxrjHQ_TFSsI53DONKW49FkhMjYcA0TQtGm09eROfecYtiKVPZIgH63MoFqb45BLoE87DG1-mrDVpGfztbYjQjJHp_UBDuUEXoN7-BwhskyDwUXmRGy3kRKen3Rg3C4X7tWjlGPwI',
    ),
  ];

  // Métodos de navegación
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Métodos de gestión del test
  void selectOption(int index) {
    _selectedOption = index;
    notifyListeners();
  }

  void goToNextQuestion() {
    if (_currentQuestion < totalQuestions) {
      _currentQuestion++;
      _selectedOption = 0;
      notifyListeners();
    }
  }

  void goToPreviousQuestion() {
    if (_currentQuestion > 1) {
      _currentQuestion--;
      _selectedOption = 0;
      notifyListeners();
    }
  }

  // Métodos de ResultManager a través del ViewModel
  bool isTestCompleted(String testType) {
    return _resultManager.isTestCompleted(testType);
  }

  Set<String> getCompletedTests() {
    return _resultManager.getCompletedTests();
  }

  bool areAllTestsCompleted() {
    return _resultManager.areAllTestsCompleted();
  }

  bool shouldResetForNewCycle() {
    return _resultManager.shouldResetForNewCycle();
  }

  void resetForNewCycle() {
    if (shouldResetForNewCycle()) {
      _resultManager.resetAllTests();
      notifyListeners();
    }
  }

  void addTestResult(String testType, String testTitle) {
    _resultManager.addResult(testType, testTitle);
    notifyListeners();
  }

  void submitTest(String testType, String testTitle) {
    _isSubmitting = true;
    notifyListeners();

    _resultManager.addResult(testType, testTitle);

    if (_resultManager.areAllTestsCompleted()) {
      _isSubmitting = false;
      notifyListeners();
    } else {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  List<TestResult> getRecentResults() {
    return _resultManager.getRecentResults();
  }

  List<Map<String, String>> getCompletedEvaluations() {
    return _resultManager.getCompletedEvaluations();
  }

  void resetState() {
    _currentQuestion = 1;
    _selectedOption = 0;
    _isSubmitting = false;
    notifyListeners();
  }
}

/// Información de un test disponible
class TestInfo {
  final String testType;
  final String category;
  final String title;
  final String description;
  final String imageUrl;

  TestInfo({
    required this.testType,
    required this.category,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
