// ============================================================================
// MODELOS - Modelos de datos de la aplicación
// ============================================================================

class TestResult {
  final String testType;
  final String testTitle;
  final DateTime completionDate;
   
  TestResult({
    required this.testType,
    required this.testTitle,
    required this.completionDate,
  });
   
  String get formattedDate {
    return "${completionDate.day.toString().padLeft(2, '0')}-${completionDate.month.toString().padLeft(2, '0')}-${completionDate.year}";
  }
}

class ResultManager {
  static final ResultManager _instance = ResultManager._internal();
   
  factory ResultManager() {
    return _instance;
  }
   
  ResultManager._internal();
   
  List<TestResult> _recentResults = [];
  final List<Map<String, String>> _completedEvaluations = [
    {
      'titulo': 'Test Vocacional 1',
      'perfilPrincipal': 'Perfil Principal: Ingeniería',
      'fecha': '15-01-2024',
    },
    {
      'titulo': 'Test Vocacional 2',
      'perfilPrincipal': 'Perfil Principal: Medicina',
      'fecha': '10-01-2024',
    },
    {
      'titulo': 'Test Vocacional 3',
      'perfilPrincipal': 'Perfil Principal: Artes',
      'fecha': '05-01-2024',
    },
  ];
   
  void addResult(String testType, String testTitle) {
    _recentResults.insert(0, TestResult(
      testType: testType,
      testTitle: testTitle,
      completionDate: DateTime.now(),
    ));
    if (_recentResults.length > 5) {
      _recentResults = _recentResults.sublist(0, 5);
    }
  }
   
  List<TestResult> getRecentResults() {
    return List.from(_recentResults);
  }
   
  List<Map<String, String>> getCompletedEvaluations() {
    return List.from(_completedEvaluations);
  }
}

class Carrera {
  final String nombre;
  final String compatibilidad;
  final String descripcion;
  final String imagenUrl;
  final String portadaUrl;

  const Carrera({
    required this.nombre,
    required this.compatibilidad,
    required this.descripcion,
    required this.imagenUrl,
    required this.portadaUrl,
  });
}
