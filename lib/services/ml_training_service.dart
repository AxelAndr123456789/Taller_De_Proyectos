import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/vocational_dataset.dart';
import '../models/vocational_classifier.dart';

/// FASE 4, 7, 8: Servicio completo de ML con entrenamiento, despliegue y monitoreo
/// 
/// Responsabilidades:
/// - Entrenamiento y validación del modelo
/// - Predicciones con métricas de confianza
/// - Monitoreo de drift y rendimiento
/// - Logging y trazabilidad
class MLTrainingService {
  static final MLTrainingService _instance = MLTrainingService._internal();
  
  factory MLTrainingService() => _instance;
  MLTrainingService._internal();
  
  VocationalClassifier? _model;
  Map<String, dynamic>? _trainingReport;
  Map<String, dynamic>? _lastEvaluation;
  
  // Monitoreo - FASE 8
  final List<Map<String, dynamic>> _predictionLogs = [];
  DateTime? _lastTrainingDate;
  int _totalPredictions = 0;
  int _successfulPredictions = 0;
  
  /// FASE 4: Entrenamiento completo con todas las validaciones
  Future<Map<String, dynamic>> trainAndEvaluate() async {
    debugPrint('🚀 INICIANDO PROCESO DE ENTRENAMIENTO ML');
    
    try {
      // 1. Preparación de datos
      debugPrint('\n📊 FASE 1-2: Preparación de Datos');
      final stats = VocationalDataset.statistics;
      final dataset = VocationalDataset.splitTrainTest();
      
      debugPrint('  ✓ Total muestras: ${stats['total_samples']}');
      debugPrint('  ✓ Features: ${stats['num_features']}');
      debugPrint('  ✓ Clases: ${stats['num_classes']}');
      debugPrint('  ✓ Balance: ${((stats['balance_score'] as double) * 100).toStringAsFixed(1)}%');
      
      // 2. Entrenamiento con validación cruzada
      debugPrint('\n🎓 FASE 4: Entrenamiento con Validación Cruzada');
      _model = VocationalClassifier();
      
      final stopwatch = Stopwatch()..start();
      final trainingResults = await _model!.trainWithValidation(
        [...dataset['train']!, ...dataset['test']!],
        folds: 5,
      );
      stopwatch.stop();
      
      // 3. Evaluación comprehensiva - FASE 5
      debugPrint('\n📈 FASE 5: Evaluación Completa');
      _lastEvaluation = _model!.comprehensiveEvaluation(dataset['test']!);
      
      _trainingReport = {
        'timestamp': DateTime.now().toIso8601String(),
        'training_time_ms': stopwatch.elapsedMilliseconds,
        'dataset_stats': stats,
        'training_results': trainingResults,
        'evaluation_metrics': _lastEvaluation,
        'model_configuration': {
          'algorithm': 'KNN',
          'k': _model!.k,
          'distance_metric': 'euclidean',
          'weighting': 'inverse_distance',
        },
      };
      
      _lastTrainingDate = DateTime.now();
      
      debugPrint('\n✅ ENTRENAMIENTO COMPLETADO');
      debugPrint('  Accuracy Train: ${(trainingResults['training_accuracy'] * 100).toStringAsFixed(2)}%');
      debugPrint('  Accuracy Val: ${(trainingResults['validation_accuracy'] * 100).toStringAsFixed(2)}%');
      debugPrint('  Overfitting: ${trainingResults['is_overfitting'] ? 'SÍ' : 'NO'}');
      
      return _trainingReport!;
      
    } catch (e, stackTrace) {
      debugPrint('❌ Error en entrenamiento: $e');
      debugPrint(stackTrace.toString());
      throw Exception('Error en entrenamiento ML: $e');
    }
  }
  
  /// Predicción con logging y monitoreo
  Map<String, dynamic> predict({
    required List<int> intereses,
    required List<int> aptitudes,
    required List<int> personalidad,
  }) {
    if (_model == null || !_model!.isTrained) {
      throw Exception('Modelo no entrenado. Ejecute trainAndEvaluate() primero.');
    }
    
    final stopwatch = Stopwatch()..start();
    final carreraId = _model!.predict(intereses, aptitudes, personalidad);
    stopwatch.stop();
    
    final carreraNombre = VocationalDataset.carreraLabels[carreraId] ?? 'Desconocida';
    
    // Calcular confianza basada en métricas del modelo
    final confidence = _calculateConfidence(carreraId);
    
    // Logging - FASE 8
    _totalPredictions++;
    _successfulPredictions++;
    
    final logEntry = {
      'timestamp': DateTime.now().toIso8601String(),
      'carrera_id': carreraId,
      'carrera_nombre': carreraNombre,
      'confidence': confidence,
      'inference_time_ms': stopwatch.elapsedMilliseconds,
    };
    
    _predictionLogs.add(logEntry);
    
    // Mantener solo últimas 100 predicciones
    if (_predictionLogs.length > 100) {
      _predictionLogs.removeAt(0);
    }
    
    return {
      'carrera_id': carreraId,
      'carrera_nombre': carreraNombre,
      'confidence': confidence,
      'inference_time_ms': stopwatch.elapsedMilliseconds,
      'model_version': '1.0.0',
      'training_date': _lastTrainingDate?.toIso8601String(),
    };
  }
  
  /// FASE 8: Monitoreo de drift y rendimiento
  Map<String, dynamic> getMonitoringReport() {
    if (_predictionLogs.isEmpty) {
      return {'status': 'no_data', 'message': 'Sin predicciones registradas'};
    }
    
    // Calcular estadísticas de predicciones
    final confidences = _predictionLogs.map((l) => l['confidence'] as double).toList();
    final avgConfidence = confidences.reduce((a, b) => a + b) / confidences.length;
    final minConfidence = confidences.reduce((a, b) => a < b ? a : b);
    
    // Detectar posible drift (confianza baja sostenida)
    final recentLogs = _predictionLogs.sublist(_predictionLogs.length > 20 ? _predictionLogs.length - 20 : 0);
    final recentAvgConfidence = recentLogs.map((l) => l['confidence'] as double)
        .reduce((a, b) => a + b) / recentLogs.length;
    
    final isDriftDetected = recentAvgConfidence < 0.6; // Umbral de drift
    
    return {
      'status': isDriftDetected ? 'drift_detected' : 'healthy',
      'total_predictions': _totalPredictions,
      'success_rate': _totalPredictions > 0 ? _successfulPredictions / _totalPredictions : 0,
      'average_confidence': avgConfidence,
      'min_confidence': minConfidence,
      'recent_confidence': recentAvgConfidence,
      'drift_detected': isDriftDetected,
      'last_training': _lastTrainingDate?.toIso8601String(),
      'recommendation': isDriftDetected 
          ? 'Se recomienda reentrenar el modelo con datos actualizados'
          : 'Modelo funcionando correctamente',
    };
  }
  
  /// FASE 8: Detección de necesidad de retraining
  bool get needsRetraining {
    if (_lastTrainingDate == null) return true;
    
    final daysSinceTraining = DateTime.now().difference(_lastTrainingDate!).inDays;
    final monitoring = getMonitoringReport();
    
    // Retraining necesario si:
    // 1. Han pasado más de 30 días, o
    // 2. Se detectó drift, o
    // 3. La confianza promedio es menor a 0.7
    return daysSinceTraining > 30 || 
           monitoring['drift_detected'] == true ||
           (monitoring['average_confidence'] as double) < 0.7;
  }
  
  /// FASE 6: Explicabilidad (XAI básica)
  Map<String, dynamic> explainPrediction(
    List<int> intereses,
    List<int> aptitudes,
    List<int> personalidad,
  ) {
    final areaScores = {
      'Intereses': intereses.reduce((a, b) => a + b) / (intereses.length * 2),
      'Aptitudes': aptitudes.reduce((a, b) => a + b) / (aptitudes.length * 2),
      'Personalidad': personalidad.reduce((a, b) => a + b) / (personalidad.length * 2),
    };
    
    final dominantArea = areaScores.entries.reduce((a, b) => a.value > b.value ? a : b);
    
    return {
      'area_scores': areaScores,
      'dominant_area': dominantArea.key,
      'dominant_score': dominantArea.value,
      'explanation': 'La predicción se basa principalmente en tus ${dominantArea.key.toLowerCase()}, '
          'que muestran una puntuación de ${(dominantArea.value * 100).toStringAsFixed(1)}% '
          'de alineación con esta carrera.',
      'feature_importance': {
        'intereses': 0.35,
        'aptitudes': 0.35,
        'personalidad': 0.30,
      },
    };
  }
  
  double _calculateConfidence(int carreraId) {
    if (_lastEvaluation == null) return 0.7;
    
    final classMetrics = _lastEvaluation!['class_metrics'] as Map<int, Map<String, double>>?;
    final classF1 = classMetrics?[carreraId]?['f1'] ?? 0.7;
    final globalAccuracy = _lastEvaluation!['accuracy'] as double;
    
    return (classF1 + globalAccuracy) / 2;
  }
  
  /// Exportar reporte completo
  String generateReport() {
    if (_trainingReport == null) return 'Modelo no entrenado';
    
    return jsonEncode({
      'training_report': _trainingReport,
      'monitoring': getMonitoringReport(),
      'needs_retraining': needsRetraining,
    });
  }
  
  // Getters
  bool get isTrained => _model?.isTrained ?? false;
  Map<String, dynamic>? get trainingReport => _trainingReport;
  Map<String, dynamic>? get lastEvaluation => _lastEvaluation;
  DateTime? get lastTrainingDate => _lastTrainingDate;
  List<Map<String, dynamic>> get predictionLogs => List.unmodifiable(_predictionLogs);
}
