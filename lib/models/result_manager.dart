import 'test_result.dart';
import 'vocational_profile_calculator.dart';
import '../services/services.dart';
import 'package:flutter/foundation.dart';

class ResultManager {
  static final ResultManager _instance = ResultManager._internal();
  
  factory ResultManager() {
    return _instance;
  }
  
  ResultManager._internal();
  
  final AIService _aiService = AIService();
  final MLTrainingService _mlService = MLTrainingService();
  bool _mlModelTrained = false;
  
  List<TestResult> _recentResults = [];
  final List<Map<String, String>> _completedEvaluations = [];
  final Set<String> _completedTests = {};
  bool _cycleCompleted = false;
  
  // Almacenar respuestas de cada test
  final Map<String, List<int>> _testResponses = {};
  
  // Perfil vocacional calculado
  Map<String, dynamic>? _calculatedProfile;
  
  // Perfil vocacional mejorado por IA
  Map<String, dynamic>? _aiEnhancedProfile;
  
  // Historial de carreras recomendadas para evitar repetir la misma carrera
  final List<String> _usedCareers = [];
  
  Future<void> addResult(String testType, String testTitle) async {
    debugPrint('📝 addResult: $testType - $testTitle');
    
    _recentResults.insert(0, TestResult(
      testType: testType,
      testTitle: testTitle,
      completionDate: DateTime.now(),
    ));
    
    _completedTests.add(testType);
    debugPrint('   Tests completados: ${_completedTests.length}/3');
    
    // Cuando se completan los 3 tests, guardar la evaluación y reiniciar para permitir nuevos tests
    if (_completedTests.length >= 3) {
      debugPrint('🎯 ¡3 tests completados! Calculando perfil...');
      
      // Calcular el perfil vocacional (método tradicional + IA async)
      await _calculateVocationalProfile();
      
      // Verificar que el perfil se calculó correctamente
      if (_calculatedProfile == null) {
        debugPrint('❌ ERROR: _calculatedProfile es null después del cálculo');
        // Crear perfil de emergencia
        _calculatedProfile = {
          'perfilPrincipal': 'El Profesional Versátil',
          'carreraRecomendada': 'Administración de Empresas',
          'areaPrincipal': 'Negocios',
          'areaSecundaria': 'Social',
          'descripcionCarrera': 'Basándonos en tus respuestas, esta carrera podría ser una buena opción.',
          'carrerasAfines': ['Administración de Empresas'],
          'imagenCarrera': 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=400&fit=crop',
          'porcentajesTest': {'Intereses': 35, 'Aptitudes': 35, 'Personalidad': 30},
        };
      }
      
      debugPrint('✅ Perfil calculado: ${_calculatedProfile!['carreraRecomendada']}');
      
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
      
      // Intentar mejorar con IA (async, no bloquea)
      _enhanceWithAI();
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
  
  /// Calcula el perfil vocacional usando Lógica tradicional + ML opcional + IA
  Future<void> _calculateVocationalProfile() async {
    try {
      final intereses = _testResponses['Intereses Vocacionales'] ?? [];
      final aptitudes = _testResponses['Aptitudes'] ?? [];
      final personalidad = _testResponses['Personalidad'] ?? [];
      
      debugPrint('Calculando perfil vocacional...');
      debugPrint('Intereses: $intereses');
      debugPrint('Aptitudes: $aptitudes');
      debugPrint('Personalidad: $personalidad');
      
      // 1. Calcular con lógica tradicional (siempre funciona)
      final calculator = VocationalProfileCalculator(
        interesesResponses: intereses,
        aptitudesResponses: aptitudes,
        personalidadResponses: personalidad,
        usedCareers: _usedCareers,
      );
      
      _calculatedProfile = calculator.calculateProfile();
      _calculatedProfile!['modelo_usado'] = 'Lógica Tradicional';
      
      debugPrint('✅ Perfil calculado: ${_calculatedProfile!['carreraRecomendada']}');
      
      // 2. Intentar ML opcionalmente (no bloqueante)
      if (!_mlModelTrained) {
        try {
          debugPrint('Entrenando modelo ML (opcional)...');
          await _mlService.trainAndEvaluate().timeout(const Duration(seconds: 5));
          _mlModelTrained = true;
          debugPrint('✅ Modelo ML entrenado');
        } catch (e) {
          debugPrint('⚠️ ML no disponible, usando lógica tradicional: $e');
        }
      }
      
      // 3. Intentar predicción ML (opcional)
      if (_mlModelTrained && _mlService.isTrained) {
        try {
          final mlPrediction = _mlService.predict(
            intereses: intereses,
            aptitudes: aptitudes,
            personalidad: personalidad,
          );
          
          if ((mlPrediction['confianza'] as double) > 0.7) {
            _calculatedProfile!['carreraRecomendada'] = mlPrediction['carrera_nombre'];
            _calculatedProfile!['modelo_usado'] = 'ML + Lógica Tradicional';
            debugPrint('🤖 Usando predicción ML: ${mlPrediction['carrera_nombre']}');
          }
        } catch (e) {
          debugPrint('⚠️ Predicción ML falló: $e');
        }
      }
      
      // Guardar carrera
      final carreraRecomendada = _calculatedProfile!['carreraRecomendada'] as String?;
      if (carreraRecomendada != null && !_usedCareers.contains(carreraRecomendada)) {
        _usedCareers.add(carreraRecomendada);
      }
      
    } catch (e, stackTrace) {
      debugPrint('❌ Error calculando perfil: $e');
      debugPrint(stackTrace.toString());
      
      // Fallback: crear perfil básico
      _calculatedProfile = {
        'perfilPrincipal': 'El Profesional Versátil',
        'carreraRecomendada': 'Administración de Empresas',
        'areaPrincipal': 'Negocios',
        'areaSecundaria': 'Social',
        'descripcionCarrera': 'Basándonos en tus respuestas, esta carrera podría ser una buena opción.',
        'carrerasAfines': ['Administración de Empresas', 'Gestión Administrativa'],
        'imagenCarrera': 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=400&fit=crop',
        'porcentajesTest': {'Intereses': 35, 'Aptitudes': 35, 'Personalidad': 30},
        'modelo_usado': 'Fallback (Error)',
      };
    }
  }
  
  /// Mejora el perfil vocacional usando Inteligencia Artificial (Gemini)
  Future<void> _enhanceWithAI() async {
    try {
      if (_calculatedProfile == null) return;
      
      final intereses = _testResponses['Intereses Vocacionales'] ?? [];
      final aptitudes = _testResponses['Aptitudes'] ?? [];
      
      debugPrint('Iniciando mejora con IA...');
      
      // Obtener descripción mejorada de la carrera
      final descripcionMejorada = await _aiService.generarDescripcionCarrera(
        carrera: _calculatedProfile!['carreraRecomendada'] ?? '',
        area: _calculatedProfile!['areaPrincipal'] ?? '',
        interesesResponses: intereses,
        aptitudesResponses: aptitudes,
      );
      
      if (descripcionMejorada != null) {
        _aiEnhancedProfile = Map<String, dynamic>.from(_calculatedProfile!);
        _aiEnhancedProfile!['descripcionCarrera'] = descripcionMejorada;
        _aiEnhancedProfile!['perfilPrincipal'] = '${_calculatedProfile!['perfilPrincipal']} (Análisis IA)';
        
        debugPrint('Perfil mejorado con IA exitosamente');
      }
    } catch (e) {
      debugPrint('Error al mejorar con IA: $e');
      // Si falla la IA, mantener el perfil tradicional
    }
  }
  
  /// Obtiene el perfil vocacional calculado
  Map<String, dynamic>? getVocationalProfile() {
    debugPrint('Obteniendo perfil vocacional...');
    debugPrint('  - _calculatedProfile: ${_calculatedProfile != null ? 'EXiste' : 'NULL'}');
    debugPrint('  - _aiEnhancedProfile: ${_aiEnhancedProfile != null ? 'EXiste' : 'NULL'}');
    debugPrint('  - Tests completados: ${areAllTestsCompleted()}');
    
    // Retornar el perfil mejorado por IA si está disponible, sino el tradicional
    final profile = _aiEnhancedProfile ?? _calculatedProfile;
    
    if (profile != null) {
      debugPrint('  - Perfil encontrado: ${profile['carreraRecomendada']}');
    } else {
      debugPrint('  - ⚠️ No hay perfil disponible');
    }
    
    return profile;
  }
  
  /// Obtiene la carrera recomendada
  String getRecommendedCareer() {
    final profile = getVocationalProfile();
    return profile?['carreraRecomendada'] ?? 'Administración de Empresas';
  }
  
  /// Obtiene la descripción de la carrera recomendada
  /// Puede ser la mejorada por IA o la tradicional
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
  
  /// Indica si el perfil ha sido mejorado por IA
  bool get isAIEnhanced => _aiEnhancedProfile != null;
  
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
    _aiEnhancedProfile = null;
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
    _aiEnhancedProfile = null;
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
      _aiEnhancedProfile = null;
    }
  }
}
