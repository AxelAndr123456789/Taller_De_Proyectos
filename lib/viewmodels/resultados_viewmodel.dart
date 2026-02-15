import 'package:flutter/foundation.dart';
import '../models/result_manager.dart';

/// ViewModel para la pantalla de resultados vocacionales.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para los resultados de los tests y notifica cambios a la vista.
class ResultadosViewModel with ChangeNotifier {
  final ResultManager _resultManager = ResultManager();
  
  /// Perfil vocacional del usuario (dinámico)
  String get perfilVocacional {
    final profile = _resultManager.getVocationalProfile();
    return profile?['perfilPrincipal'] ?? 'El Profesional Versátil';
  }

  /// Descripción del perfil (dinámica)
  String get descripcionPerfil {
    final profile = _resultManager.getVocationalProfile();
    return profile?['descripcion'] ?? 
      'Tienes un perfil profesional único con múltiples habilidades y aptitudes que te permiten desempeñarte en diversas áreas.';
  }
  
  /// Área principal del perfil
  String get areaPrincipal {
    final profile = _resultManager.getVocationalProfile();
    return profile?['areaPrincipal'] ?? 'Negocios';
  }
  
  /// Área secundaria del perfil
  String get areaSecundaria {
    final profile = _resultManager.getVocationalProfile();
    return profile?['areaSecundaria'] ?? 'Social';
  }

  /// Imagen de portada del resultado
  final String portadaUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBi3by901MHaPUhDeQe8c2l33TPaA4BVQIDtTwrutvdkLzEi3ggkLOdSTpP9UXuluWpF0RassK3F9aJSrNTxiQ5v-wYKy3cNamdUwYU5lKB2mPXnDyadHJUEUTDQFyxkOdqexO5GKq9wXoeP39KTCGRrMa8J_x_8er5sFc2FpdJxMlMomwbax6bXhvsOwrrwbNtxehNC3alPmrlT_ErohxhQb80G99BfVcrrJXL_y0Hh5rZm7kp1iUX8_7eWOBisyeTRZKyiI2Ff7KX';

  /// Imagen del personaje/ilustración
  final String imagenPersonaje =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuC4Sc1bc4CvdU7mMDBpMbvqpFrv4wHT-mhJWweIiQYSu99ymMp0phZ1rx_TcDcFPV2GXu3_YiPdYmS1tnPM2AEtX91vO3N25CCnd6SdMWt1VYEDIG7rNVJiAWKOLX2RSvGR_BdumPH9PpmPmN73EgstpnmpqCGUOnDnFLQJcwTiMpYAEVdSYZecqwgbTlGzqwG1ZEg9zecnrYohX94yonOfsTQS0qCwH-Z_lPWVf6Uok75GUIajJYOd57VpzJM_9rsg10dKZrVZGJO';

  /// Título del mensaje de éxito
  final String tituloMensaje = '¡Tu Perfil Vocacional está Listo!';

  /// Obtiene el título del perfil
  String getTituloPerfil() {
    return perfilVocacional;
  }

  /// Obtiene la descripción del perfil
  String getDescripcionPerfil() {
    return descripcionPerfil;
  }
  
  /// Obtiene las carreras recomendadas basadas en el perfil
  List<String> getCarrerasRecomendadas() {
    return _resultManager.getRecommendedCareers();
  }
  
  /// Obtiene el puntaje para un área específica
  double getPuntuacionArea(String area) {
    final profile = _resultManager.getVocationalProfile();
    final puntuaciones = profile?['puntuaciones'] as Map<String, double>?;
    return puntuaciones?[area] ?? 0.0;
  }
  
  /// Obtiene los porcentajes de Intereses, Aptitudes y Personalidad
  /// basados en el análisis de respuestas de cada test
  Map<String, int> getPorcentajesDesglose() {
    final profile = _resultManager.getVocationalProfile();
    
    // Usar los porcentajes calculados por test
    final porcentajesTest = profile?['porcentajesTest'] as Map<String, dynamic>?;
    
    if (porcentajesTest != null) {
      return {
        'Intereses': porcentajesTest['Intereses'] ?? 35,
        'Aptitudes': porcentajesTest['Aptitudes'] ?? 35,
        'Personalidad': porcentajesTest['Personalidad'] ?? 30,
      };
    }
    
    // Valores por defecto si no hay perfil
    return {
      'Intereses': 35,
      'Aptitudes': 35,
      'Personalidad': 30,
    };
  }
  
  /// Obtiene el porcentaje de Intereses
  int getPorcentajeIntereses() {
    return getPorcentajesDesglose()['Intereses'] ?? 35;
  }
  
  /// Obtiene el porcentaje de Aptitudes
  int getPorcentajeAptitudes() {
    return getPorcentajesDesglose()['Aptitudes'] ?? 35;
  }
  
  /// Obtiene el porcentaje de Personalidad
  int getPorcentajePersonalidad() {
    return getPorcentajesDesglose()['Personalidad'] ?? 30;
  }
  
  /// Calcula el porcentaje general de coincidencia
  int getPorcentajeGeneral() {
    final porcentajes = getPorcentajesDesglose();
    return ((porcentajes['Intereses']! + porcentajes['Aptitudes']! + porcentajes['Personalidad']!) / 3).round();
  }
  
  /// Obtiene la carrera recomendada
  String get carreraRecomendada {
    return _resultManager.getRecommendedCareer();
  }
  
  /// Obtiene la descripción de la carrera recomendada
  String get descripcionCarrera {
    return _resultManager.getCareerDescription();
  }
  
  /// Obtiene la imagen de la carrera recomendada
  String get imagenCarrera {
    return _resultManager.getCareerImage();
  }
  
  /// Obtiene las carreras afines
  List<String> getCarrerasAfines() {
    return _resultManager.getRelatedCareers();
  }
}
