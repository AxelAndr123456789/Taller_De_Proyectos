import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Servicio de Inteligencia Artificial para análisis vocacional
/// Utiliza Google Gemini API para mejorar el perfil vocacional basado en las respuestas de los tests
class AIService {
  static final AIService _instance = AIService._internal();
  
  factory AIService() {
    return _instance;
  }
  
  AIService._internal();

  GenerativeModel? _model;
  bool _initialized = false;

  /// Obtiene la API Key de Gemini desde variables de entorno
  String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  /// Inicializa el modelo de Gemini
  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      _model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: _apiKey,
      );
      _initialized = true;
      debugPrint('AI Service inicializado correctamente');
    } catch (e) {
      debugPrint('Error al inicializar AI Service: $e');
    }
  }

  /// Analiza las respuestas de los tests y genera una descripción mejorada con IA
  /// 
  /// [carreraRecomendada] - Carrera calculada por la lógica tradicional
  /// [areaPrincipal] - Área principal calculada por la lógica tradicional
  /// 
  /// Retorna una descripción mejorada por IA
  Future<String?> generarDescripcionCarrera({
    required String carrera,
    required String area,
    required List<int> interesesResponses,
    required List<int> aptitudesResponses,
  }) async {
    try {
      await initialize();
      
      if (_model == null) {
        debugPrint('Modelo de IA no disponible');
        return null;
      }

      // Construir el prompt para Gemini
      final prompt = _construirPrompt(
        carrera: carrera,
        area: area,
        interesesResponses: interesesResponses,
        aptitudesResponses: aptitudesResponses,
      );

      debugPrint('Enviando solicitud a Gemini...');
      
      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);
      
      if (response.text == null || response.text!.isEmpty) {
        debugPrint('Respuesta vacía de Gemini');
        return null;
      }

      debugPrint('Respuesta recibida de Gemini exitosamente');
      return response.text!.trim();
      
    } catch (e) {
      debugPrint('Error al generar descripción con IA: $e');
      return null;
    }
  }

  /// Construye el prompt para Gemini
  String _construirPrompt({
    required String carrera,
    required String area,
    required List<int> interesesResponses,
    required List<int> aptitudesResponses,
  }) {
    // Calcular promedios para dar contexto
    final promedioIntereses = interesesResponses.isNotEmpty 
        ? interesesResponses.reduce((a, b) => a + b) / interesesResponses.length 
        : 0.0;
    final promedioAptitudes = aptitudesResponses.isNotEmpty 
        ? aptitudesResponses.reduce((a, b) => a + b) / aptitudesResponses.length 
        : 0.0;
    
    return '''
Eres un experto orientador vocacional con años de experiencia ayudando a estudiantes a encontrar su camino profesional ideal.

Genera una descripción motivadora y personalizada para la carrera "$carrera" del área de $area.

CONTEXTO DEL ESTUDIANTE:
- Promedio en test de Intereses: ${promedioIntereses.toStringAsFixed(1)}/3.0
- Promedio en test de Aptitudes: ${promedioAptitudes.toStringAsFixed(1)}/3.0

INSTRUCCIONES:
Escribe una descripción de 2-3 oraciones que:
1. Sea cálida, motivadora y personalizada
2. Mencione por qué esta carrera es ideal para alguien con su perfil
3. Destaque las fortalezas que necesita para esta carrera
4. Sea específica y personalizada, no genérica
5. Use un tono profesional pero cercano, como un orientador vocacional experto

Responde solo con el texto de la descripción, sin formato adicional ni markdown.''';  }

  /// Verifica si el servicio de IA está disponible
  bool get isAvailable => _initialized && _model != null;
}
