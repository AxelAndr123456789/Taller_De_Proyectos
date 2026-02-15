import 'test_result.dart';
import 'vocational_profile_calculator.dart';

class ResultManager {
  static final ResultManager _instance = ResultManager._internal();
  
  factory ResultManager() {
    return _instance;
  }
  
  ResultManager._internal();
  
  List<TestResult> _recentResults = [];
  final List<Map<String, String>> _completedEvaluations = [];
  final Set<String> _completedTests = {};
  bool _cycleCompleted = false;
  
  // Almacenar respuestas de cada test
  final Map<String, List<int>> _testResponses = {};
  
  // Perfil vocacional calculado
  Map<String, dynamic>? _calculatedProfile;
  
  // Historial de carreras recomendadas para evitar repetir la misma carrera
  final List<String> _usedCareers = [];
  
  void addResult(String testType, String testTitle) {
    _recentResults.insert(0, TestResult(
      testType: testType,
      testTitle: testTitle,
      completionDate: DateTime.now(),
    ));
    
    _completedTests.add(testType);
    
    // Cuando se completan los 3 tests, guardar la evaluación y reiniciar para permitir nuevos tests
    if (_completedTests.length >= 3) {
      // Calcular el perfil vocacional
      _calculateVocationalProfile();
      
      final profile = _calculatedProfile!;
      final timestamp = DateTime.now();
      
      // Agregar al historial de evaluaciones completadas
      _completedEvaluations.insert(0, {
        'titulo': 'Perfil Vocacional Completo',
        'perfilPrincipal': profile['perfilPrincipal'] ?? 'El Profesional Versátil',
        'carreraRecomendada': profile['carreraRecomendada'] ?? 'Administración de Empresas',
        'areaPrincipal': profile['areaPrincipal'] ?? 'Negocios',
        'areaSecundaria': profile['areaSecundaria'] ?? 'Social',
        'fecha': '${timestamp.day.toString().padLeft(2, '0')}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.year}',
        'hora': '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}',
      });
      
      // Reiniciar el ciclo para permitir nuevos tests
      // Pero mantener las respuestas actuales hasta que se inicien nuevos tests
      _cycleCompleted = true;
    }
    
    if (_recentResults.length > 5) {
      _recentResults = _recentResults.sublist(0, 5);
    }
  }
  
  /// Guarda las respuestas de un test
  void saveTestResponses(String testType, List<int> responses) {
    _testResponses[testType] = responses;
  }
  
  /// Obtiene las respuestas de un test
  List<int>? getTestResponses(String testType) {
    return _testResponses[testType];
  }
  
  /// Calcula el perfil vocacional basado en todas las respuestas
  void _calculateVocationalProfile() {
    final intereses = _testResponses['Intereses Vocacionales'] ?? [];
    final aptitudes = _testResponses['Aptitudes'] ?? [];
    final personalidad = _testResponses['Personalidad'] ?? [];
    
    final calculator = VocationalProfileCalculator(
      interesesResponses: intereses,
      aptitudesResponses: aptitudes,
      personalidadResponses: personalidad,
      usedCareers: _usedCareers,
    );
    
    _calculatedProfile = calculator.calculateProfile();
    
    // Guardar la carrera recomendada para evitar repetirla en futuras evaluaciones
    if (_calculatedProfile != null) {
      final carreraRecomendada = _calculatedProfile!['carreraRecomendada'] as String?;
      if (carreraRecomendada != null && !_usedCareers.contains(carreraRecomendada)) {
        _usedCareers.add(carreraRecomendada);
      }
    }
  }
  
  /// Obtiene el perfil vocacional calculado
  Map<String, dynamic>? getVocationalProfile() {
    if (_calculatedProfile == null && areAllTestsCompleted()) {
      _calculateVocationalProfile();
    }
    return _calculatedProfile;
  }
  
  /// Obtiene la carrera recomendada
  String getRecommendedCareer() {
    final profile = getVocationalProfile();
    return profile?['carreraRecomendada'] ?? 'Administración de Empresas';
  }
  
  /// Obtiene la descripción de la carrera recomendada
  String getCareerDescription() {
    final profile = getVocationalProfile();
    return profile?['descripcionCarrera'] ?? 
      'Esta carrera se alinea con tus intereses, aptitudes y personalidad.';
  }
  
  /// Obtiene la imagen de la carrera recomendada
  String getCareerImage() {
    final profile = getVocationalProfile();
    return profile?['imagenCarrera'] ?? 
      'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=400&fit=crop';
  }
  
  /// Obtiene las carreras afines
  List<String> getRelatedCareers() {
    final profile = getVocationalProfile();
    return (profile?['carrerasAfines'] as List<dynamic>?)?.cast<String>() ?? [];
  }
  
  /// Obtiene las carreras recomendadas basadas en el perfil
  List<String> getRecommendedCareers() {
    final profile = getVocationalProfile();
    if (profile == null) return [];
    
    final areaPrincipal = profile['areaPrincipal'] as String? ?? 'Negocios';
    
    final calculator = VocationalProfileCalculator(
      interesesResponses: [],
      aptitudesResponses: [],
      personalidadResponses: [],
    );
    
    return calculator.getRecommendedCareers(areaPrincipal);
  }
  
  /// Obtiene el área principal del perfil
  String getPrimaryArea() {
    final profile = getVocationalProfile();
    return profile?['areaPrincipal'] ?? 'Negocios';
  }
  
  bool isTestCompleted(String testType) {
    return _completedTests.contains(testType);
  }
  
  Set<String> getCompletedTests() {
    return Set.from(_completedTests);
  }
  
  bool areAllTestsCompleted() {
    return _completedTests.length >= 3;
  }
  
  bool shouldResetForNewCycle() {
    return _cycleCompleted;
  }
  
  /// Reinicia el ciclo actual para permitir hacer nuevos tests
  /// pero mantiene el historial de evaluaciones completadas
  void startNewTestCycle() {
    _completedTests.clear();
    _testResponses.clear();
    _calculatedProfile = null;
    _cycleCompleted = false;
    // NO limpiar _completedEvaluations ni _recentResults
  }
  
  List<TestResult> getRecentResults() {
    return List.from(_recentResults);
  }
  
  List<Map<String, String>> getCompletedEvaluations() {
    return List.from(_completedEvaluations);
  }
  
  void resetAllTests() {
    _completedTests.clear();
    _recentResults.clear();
    _testResponses.clear();
    _calculatedProfile = null;
    _cycleCompleted = false;
    _completedEvaluations.clear();
    _usedCareers.clear();
  }
  
  void resetTest(String testType) {
    _completedTests.remove(testType);
    _testResponses.remove(testType);
    _recentResults.removeWhere((result) => result.testType == testType);
    // Recalcular perfil si es necesario
    if (_completedTests.length >= 3) {
      _calculateVocationalProfile();
    } else {
      _calculatedProfile = null;
    }
  }
}
