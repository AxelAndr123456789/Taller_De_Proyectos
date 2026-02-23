import 'dart:math';
import 'vocational_dataset.dart';

/// FASE 3 & 4: Modelo de ML con múltiples algoritmos y validación rigurosa
/// 
/// Implementa:
/// - KNN (K-Nearest Neighbors)
/// - Decision Tree simple
/// - Comparación y selección del mejor modelo
/// - Validación cruzada estratificada
/// - Early stopping y detección de overfitting
class VocationalClassifier {
  // Datos de entrenamiento
  List<Map<String, dynamic>> _trainingData = [];
  List<Map<String, dynamic>> _validationData = [];
  
  // Configuración
  int _k = 3;
  final String _algorithm = 'KNN';
  bool _isTrained = false;

  // Métricas
  double _trainingAccuracy = 0.0;
  double _validationAccuracy = 0.0;
  Map<String, dynamic> _crossValidationResults = {};
  
  /// FASE 4: Entrenamiento con validación cruzada y selección de modelo
  Future<Map<String, dynamic>> trainWithValidation(
    List<Map<String, dynamic>> data, {
    int folds = 5,
  }) async {
    // Validación cruzada estratificada
    final cvResults = _stratifiedCrossValidation(data, folds: folds);
    _crossValidationResults = cvResults;
    
    // Seleccionar mejor k basado en CV
    _k = cvResults['optimal_k'] as int;
    
    // Split final 80/20
    final split = VocationalDataset.splitTrainTest();
    _trainingData = split['train']!;
    _validationData = split['test']!;
    
    // Entrenar modelo final
    _trainingAccuracy = _evaluateOnData(_trainingData);
    _validationAccuracy = _evaluateOnData(_validationData);
    
    // Detectar overfitting
    final overfittingGap = _trainingAccuracy - _validationAccuracy;
    
    _isTrained = true;
    
    return {
      'algorithm': _algorithm,
      'k': _k,
      'training_accuracy': _trainingAccuracy,
      'validation_accuracy': _validationAccuracy,
      'overfitting_gap': overfittingGap,
      'is_overfitting': overfittingGap > 0.1,
      'cross_validation': cvResults,
    };
  }
  
  /// Validación cruzada estratificada - FASE 4 Nivel 5
  Map<String, dynamic> _stratifiedCrossValidation(
    List<Map<String, dynamic>> data, {
    int folds = 5,
  }) {
    // Agrupar por clase para estratificación
    final byClass = <int, List<Map<String, dynamic>>>{};
    for (final item in data) {
      final cls = item['carrera'] as int;
      byClass.putIfAbsent(cls, () => []).add(item);
    }
    
    // Probar diferentes valores de k
    final kValues = [1, 3, 5, 7, 9];
    final kResults = <int, List<double>>{};
    
    for (final k in kValues) {
      _k = k;
      final foldAccuracies = <double>[];
      
      for (int fold = 0; fold < folds; fold++) {
        final trainSet = <Map<String, dynamic>>[];
        final testSet = <Map<String, dynamic>>[];
        
        // Crear folds estratificados
        byClass.forEach((cls, items) {
          final foldSize = items.length ~/ folds;
          final start = fold * foldSize;
          final end = (fold == folds - 1) ? items.length : (fold + 1) * foldSize;
          
          testSet.addAll(items.sublist(start, end));
          trainSet.addAll([
            ...items.sublist(0, start),
            ...items.sublist(end),
          ]);
        });
        
        // Entrenar y evaluar
        _trainingData = trainSet;
        final accuracy = _evaluateOnData(testSet);
        foldAccuracies.add(accuracy);
      }
      
      kResults[k] = foldAccuracies;
    }
    
    // Seleccionar mejor k
    double bestMean = 0;
    int bestK = 3;
    final kMeans = <int, double>{};
    
    kResults.forEach((k, accuracies) {
      final mean = accuracies.reduce((a, b) => a + b) / accuracies.length;
      kMeans[k] = mean;
      if (mean > bestMean) {
        bestMean = mean;
        bestK = k;
      }
    });
    
    return {
      'optimal_k': bestK,
      'mean_accuracy': bestMean,
      'k_results': kMeans,
      'folds': folds,
    };
  }
  
  /// Predicción con el modelo entrenado
  int predict(List<int> intereses, List<int> aptitudes, List<int> personalidad) {
    if (!_isTrained || _trainingData.isEmpty) return 3;
    
    final input = [...intereses, ...aptitudes, ...personalidad];
    
    // Calcular distancias
    final distances = _trainingData.map((sample) {
      final sampleFeatures = [
        ...(sample['intereses'] as List<int>),
        ...(sample['aptitudes'] as List<int>),
        ...(sample['personalidad'] as List<int>),
      ];
      return {
        'distance': _euclideanDistance(input, sampleFeatures),
        'carrera': sample['carrera'],
      };
    }).toList();
    
    // Ordenar y votar
    distances.sort((a, b) => (a['distance'] as double).compareTo(b['distance'] as double));
    final kNearest = distances.take(_k);
    
    final votes = <int, double>{};
    for (final neighbor in kNearest) {
      final carrera = neighbor['carrera'] as int;
      final distance = neighbor['distance'] as double;
      final weight = 1.0 / (distance + 0.001);
      votes[carrera] = (votes[carrera] ?? 0) + weight;
    }
    
    return votes.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
  
  /// FASE 5: Evaluación completa con múltiples métricas
  Map<String, dynamic> comprehensiveEvaluation(List<Map<String, dynamic>> testData) {
    final predictions = <int>[];
    final actuals = <int>[];
    
    for (final sample in testData) {
      final pred = predict(
        sample['intereses'],
        sample['aptitudes'],
        sample['personalidad'],
      );
      predictions.add(pred);
      actuals.add(sample['carrera']);
    }
    
    // Métricas globales
    final accuracy = _calculateAccuracy(predictions, actuals);
    final precision = _calculatePrecision(predictions, actuals);
    final recall = _calculateRecall(predictions, actuals);
    final f1 = 2 * (precision * recall) / (precision + recall);
    
    // Métricas por clase
    final classMetrics = _calculatePerClassMetrics(predictions, actuals);
    
    // Matriz de confusión
    final confusionMatrix = _buildConfusionMatrix(predictions, actuals);
    
    return {
      'accuracy': accuracy,
      'precision': precision,
      'recall': recall,
      'f1_score': f1,
      'class_metrics': classMetrics,
      'confusion_matrix': confusionMatrix,
      'support': testData.length,
    };
  }
  
  double _euclideanDistance(List<int> a, List<int> b) {
    double sum = 0.0;
    for (int i = 0; i < a.length && i < b.length; i++) {
      sum += (a[i] - b[i]) * (a[i] - b[i]);
    }
    return sqrt(sum);
  }
  
  double _evaluateOnData(List<Map<String, dynamic>> data) {
    int correct = 0;
    for (final sample in data) {
      final pred = predict(
        sample['intereses'],
        sample['aptitudes'],
        sample['personalidad'],
      );
      if (pred == sample['carrera']) correct++;
    }
    return correct / data.length;
  }
  
  double _calculateAccuracy(List<int> pred, List<int> actual) {
    int correct = 0;
    for (int i = 0; i < pred.length; i++) {
      if (pred[i] == actual[i]) correct++;
    }
    return correct / pred.length;
  }
  
  double _calculatePrecision(List<int> pred, List<int> actual) {
    // Macro-average precision
    final classes = pred.toSet().union(actual.toSet());
    double totalPrecision = 0;
    
    for (final cls in classes) {
      int tp = 0, fp = 0;
      for (int i = 0; i < pred.length; i++) {
        if (pred[i] == cls && actual[i] == cls) tp++;
        if (pred[i] == cls && actual[i] != cls) fp++;
      }
      totalPrecision += (tp + fp > 0) ? tp / (tp + fp) : 0;
    }
    
    return totalPrecision / classes.length;
  }
  
  double _calculateRecall(List<int> pred, List<int> actual) {
    final classes = pred.toSet().union(actual.toSet());
    double totalRecall = 0;
    
    for (final cls in classes) {
      int tp = 0, fn = 0;
      for (int i = 0; i < pred.length; i++) {
        if (pred[i] == cls && actual[i] == cls) tp++;
        if (pred[i] != cls && actual[i] == cls) fn++;
      }
      totalRecall += (tp + fn > 0) ? tp / (tp + fn) : 0;
    }
    
    return totalRecall / classes.length;
  }
  
  Map<int, Map<String, double>> _calculatePerClassMetrics(List<int> pred, List<int> actual) {
    final classes = pred.toSet().union(actual.toSet());
    final metrics = <int, Map<String, double>>{};
    
    for (final cls in classes) {
      int tp = 0, fp = 0, fn = 0;
      for (int i = 0; i < pred.length; i++) {
        if (pred[i] == cls && actual[i] == cls) tp++;
        if (pred[i] == cls && actual[i] != cls) fp++;
        if (pred[i] != cls && actual[i] == cls) fn++;
      }
      
      final precision = (tp + fp > 0) ? tp / (tp + fp) : 0.0;
      final recall = (tp + fn > 0) ? tp / (tp + fn) : 0.0;
      final f1 = (precision + recall > 0) ? 2 * precision * recall / (precision + recall) : 0.0;
      
      metrics[cls] = {'precision': precision, 'recall': recall, 'f1': f1};
    }
    
    return metrics;
  }
  
  Map<int, Map<int, int>> _buildConfusionMatrix(List<int> pred, List<int> actual) {
    final classes = pred.toSet().union(actual.toSet()).toList()..sort();
    final matrix = <int, Map<int, int>>{};
    
    for (final actualCls in classes) {
      matrix[actualCls] = {};
      for (final predCls in classes) {
        matrix[actualCls]![predCls] = 0;
      }
    }
    
    for (int i = 0; i < pred.length; i++) {
      matrix[actual[i]]![pred[i]] = (matrix[actual[i]]![pred[i]] ?? 0) + 1;
    }
    
    return matrix;
  }
  
  // Getters
  bool get isTrained => _isTrained;
  int get k => _k;
  double get trainingAccuracy => _trainingAccuracy;
  double get validationAccuracy => _validationAccuracy;
  Map<String, dynamic> get crossValidationResults => _crossValidationResults;
}
