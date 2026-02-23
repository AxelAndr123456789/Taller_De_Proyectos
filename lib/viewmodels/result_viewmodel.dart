import 'package:flutter/foundation.dart';
import '../models/result_manager.dart';
import '../models/test_result.dart';

class ResultViewModel with ChangeNotifier {
  final ResultManager _resultManager = ResultManager();
  
  List<TestResult> get recentResults => _resultManager.getRecentResults();
  List<Map<String, String>> get completedEvaluations => _resultManager.getCompletedEvaluations();
  Set<String> get completedTests => _resultManager.getCompletedTests();
  bool get cycleCompleted => _resultManager.shouldResetForNewCycle();
  bool get allTestsCompleted => _resultManager.areAllTestsCompleted();
  
  Future<void> addResult(String testType, String testTitle) async {
    await _resultManager.addResult(testType, testTitle);
    notifyListeners();
  }
  
  bool isTestCompleted(String testType) {
    return _resultManager.isTestCompleted(testType);
  }
  
  void resetAllTests() {
    _resultManager.resetAllTests();
    notifyListeners();
  }
  
  void resetTest(String testType) {
    _resultManager.resetTest(testType);
    notifyListeners();
  }
}
