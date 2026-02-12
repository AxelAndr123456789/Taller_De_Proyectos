import 'test_result.dart';

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
  
  void addResult(String testType, String testTitle) {
    _recentResults.insert(0, TestResult(
      testType: testType,
      testTitle: testTitle,
      completionDate: DateTime.now(),
    ));
    
    _completedTests.add(testType);
    
    if (_completedTests.length >= 3 && !_cycleCompleted) {
      _cycleCompleted = true;
      
      _completedEvaluations.add({
        'titulo': 'Perfil Vocacional Completo',
        'perfilPrincipal': 'El Creador Analítico',
        'fecha': '${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}',
      });
    }
    
    if (_recentResults.length > 5) {
      _recentResults = _recentResults.sublist(0, 5);
    }
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
  
  List<TestResult> getRecentResults() {
    return List.from(_recentResults);
  }
  
  List<Map<String, String>> getCompletedEvaluations() {
    return List.from(_completedEvaluations);
  }
  
  void resetAllTests() {
    _completedTests.clear();
    _recentResults.clear();
    _cycleCompleted = false;
  }
  
  void resetTest(String testType) {
    _completedTests.remove(testType);
    _recentResults.removeWhere((result) => result.testType == testType);
  }
}
