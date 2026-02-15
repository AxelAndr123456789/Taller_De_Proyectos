import 'package:flutter/foundation.dart';
import '../models/result_manager.dart';
import '../models/test_result.dart';

/// ViewModel para la pantalla de historial de evaluaciones.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para el historial de evaluaciones y notifica cambios a la vista.
class HistorialEvaluacionesViewModel with ChangeNotifier {
  final ResultManager _resultManager = ResultManager();

  int _selectedIndex = 2;

  int get selectedIndex => _selectedIndex;

  List<TestResult> get recentResults => _resultManager.getRecentResults();

  List<Map<String, String>> get completedEvaluations =>
      _resultManager.getCompletedEvaluations();

  Set<String> get completedTests => _resultManager.getCompletedTests();

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Verifica si hay evaluaciones completadas
  bool hasEvaluations() {
    return completedEvaluations.isNotEmpty;
  }

  /// Obtiene el número de tests completados
  int getCompletedTestsCount() {
    return completedTests.length;
  }

  /// Obtiene el total de tests disponibles
  int getTotalTestsCount() {
    return 3; // Intereses, Aptitudes, Personalidad
  }

  /// Inicia un nuevo ciclo de evaluación manteniendo el historial
  void startNewEvaluationCycle() {
    _resultManager.startNewTestCycle();
    notifyListeners();
  }
}
