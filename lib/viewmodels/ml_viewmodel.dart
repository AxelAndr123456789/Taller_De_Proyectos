import 'package:flutter/foundation.dart';
import '../services/ml_training_service.dart';
import '../models/vocational_dataset.dart';

/// ViewModel para la gestión del modelo de ML en la UI
/// 
/// FASE 7: Presentación de resultados del modelo ML
class MLViewModel with ChangeNotifier {
  final MLTrainingService _mlService = MLTrainingService();
  
  bool _isTraining = false;
  bool _isPredicting = false;
  String _status = '';
  Map<String, dynamic>? _trainingResults;
  Map<String, dynamic>? _lastPrediction;
  Map<String, dynamic>? _monitoringData;
  
  // Getters
  bool get isTraining => _isTraining;
  bool get isPredicting => _isPredicting;
  String get status => _status;
  Map<String, dynamic>? get trainingResults => _trainingResults;
  Map<String, dynamic>? get lastPrediction => _lastPrediction;
  Map<String, dynamic>? get monitoringData => _monitoringData;
  bool get isModelTrained => _mlService.isTrained;
  bool get needsRetraining => _mlService.needsRetraining;
  
  /// Iniciar entrenamiento del modelo
  Future<void> trainModel() async {
    _isTraining = true;
    _status = 'Entrenando modelo...';
    notifyListeners();
    
    try {
      _trainingResults = await _mlService.trainAndEvaluate();
      _status = '✅ Modelo entrenado exitosamente';
      
      // Actualizar monitoreo
      _monitoringData = _mlService.getMonitoringReport();
      
    } catch (e) {
      _status = '❌ Error: $e';
    } finally {
      _isTraining = false;
      notifyListeners();
    }
  }
  
  /// Realizar predicción
  Future<void> predict({
    required List<int> intereses,
    required List<int> aptitudes,
    required List<int> personalidad,
  }) async {
    if (!_mlService.isTrained) {
      _status = '⚠️ El modelo debe ser entrenado primero';
      notifyListeners();
      return;
    }
    
    _isPredicting = true;
    notifyListeners();
    
    try {
      _lastPrediction = _mlService.predict(
        intereses: intereses,
        aptitudes: aptitudes,
        personalidad: personalidad,
      );
      
      // Actualizar monitoreo después de predicción
      _monitoringData = _mlService.getMonitoringReport();
      
    } catch (e) {
      _status = '❌ Error en predicción: $e';
    } finally {
      _isPredicting = false;
      notifyListeners();
    }
  }
  
  /// Obtener explicación de última predicción
  Map<String, dynamic>? explainLastPrediction(
    List<int> intereses,
    List<int> aptitudes,
    List<int> personalidad,
  ) {
    return _mlService.explainPrediction(intereses, aptitudes, personalidad);
  }
  
  /// Actualizar datos de monitoreo
  void refreshMonitoring() {
    _monitoringData = _mlService.getMonitoringReport();
    notifyListeners();
  }
  
  /// Obtener estadísticas del dataset
  Map<String, dynamic> getDatasetStats() {
    return VocationalDataset.statistics;
  }
  
  /// Generar reporte completo
  String generateFullReport() {
    return _mlService.generateReport();
  }
}
