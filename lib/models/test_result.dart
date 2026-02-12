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
