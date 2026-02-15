/// Modelo para calcular el perfil vocacional basado en las respuestas de los tests
/// Las preguntas están organizadas por áreas profesionales específicas
class VocationalProfileCalculator {
  /// Respuestas del test de Intereses (10 preguntas)
  /// Preguntas 1-2: Administración
  /// Preguntas 3-4: Salud
  /// Preguntas 5-6: Ingeniería/Tecnología
  /// Pregunta 7: Ciencias
  /// Pregunta 8: Arte/Diseño
  /// Pregunta 9: Educación
  /// Pregunta 10: Social/Legal
  final List<int> interesesResponses;
  
  /// Respuestas del test de Aptitudes (10 preguntas)
  /// Preguntas 1-2: Administración
  /// Preguntas 3-4: Salud
  /// Preguntas 5-6: Ingeniería
  /// Preguntas 7-8: Tecnología
  /// Preguntas 9-10: Comunicación/Creatividad
  final List<int> aptitudesResponses;
  
  /// Respuestas del test de Personalidad (10 preguntas)
  /// Preguntas 1-2: Liderazgo/Administración
  /// Preguntas 3-4: Salud
  /// Preguntas 5-6: Ingeniería/Tecnología
  /// Preguntas 7-8: Creatividad/Comunicación
  /// Preguntas 9-10: Ética/Trabajo
  final List<int> personalidadResponses;
  
  /// Carreras ya recomendadas en evaluaciones anteriores
  final List<String> usedCareers;
  
  VocationalProfileCalculator({
    required this.interesesResponses,
    required this.aptitudesResponses,
    required this.personalidadResponses,
    this.usedCareers = const [],
  });
  
  /// Calcula el perfil vocacional completo con carrera principal recomendada
  /// Evita carreras ya recomendadas, pero permite el mismo área
  Map<String, dynamic> calculateProfile() {
    // Calcular puntuaciones por área con pesos específicos
    final areaScores = _calculateAreaScores();
    
    // Determinar el área principal y secundaria
    final sortedAreas = areaScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Mantener el área principal según las respuestas (coherencia)
    String primaryArea = sortedAreas[0].key;
    String secondaryArea = sortedAreas[1].key;
    
    // Calcular nivel de confianza (qué tan clara es la preferencia)
    final confidence = _calculateConfidence(sortedAreas);
    
    // Determinar la carrera específica, evitando las ya recomendadas
    String carreraRecomendada = _determineRecommendedCareer(primaryArea, secondaryArea, areaScores);
    
    // Si la carrera ya fue recomendada, buscar otra del mismo área
    if (usedCareers.contains(carreraRecomendada)) {
      final carrerasDelArea = _getAllCareersForArea(primaryArea);
      for (final carrera in carrerasDelArea) {
        if (!usedCareers.contains(carrera)) {
          carreraRecomendada = carrera;
          break;
        }
      }
    }
    
    // Obtener el área correcta basada en la carrera recomendada
    final areaCarrera = _getAreaForCareer(carreraRecomendada);
    // Usar el área de la carrera si está disponible, sino el área principal calculada
    final areaFinal = areaCarrera ?? primaryArea;
    
    // Obtener carreras afines del mismo área que la carrera recomendada
    final carrerasAfines = _getRelatedCareers(areaFinal, carreraRecomendada);
    
    // Calcular porcentajes por test (Intereses, Aptitudes, Personalidad)
    final porcentajesTest = _calculateTestPercentages();
    
    return {
      'perfilPrincipal': _getProfileTitle(primaryArea, secondaryArea),
      'carreraRecomendada': carreraRecomendada,
      'areaPrincipal': primaryArea,
      'areaSecundaria': secondaryArea,
      'puntuaciones': areaScores,
      'confianza': confidence,
      'descripcionCarrera': _getCareerDescription(carreraRecomendada, primaryArea, confidence),
      'carrerasAfines': carrerasAfines,
      'imagenCarrera': _getCareerImage(carreraRecomendada),
      'porcentajesTest': porcentajesTest,
    };
  }
  
  /// Calcula los porcentajes por tipo de test basado en las respuestas
  /// Intereses, Aptitudes y Personalidad deben sumar 100%
  Map<String, int> _calculateTestPercentages() {
    // Calcular suma de respuestas para cada test (máximo 30 puntos por test)
    final sumaIntereses = interesesResponses.fold<int>(0, (sum, val) => sum + val);
    final sumaAptitudes = aptitudesResponses.fold<int>(0, (sum, val) => sum + val);
    final sumaPersonalidad = personalidadResponses.fold<int>(0, (sum, val) => sum + val);
    
    // Calcular porcentajes raw (respecto al máximo de 30 puntos)
    // Usar 20 como denominador para dar más peso a las respuestas
    final maxPuntos = 20; // 10 preguntas × 2 (promedio esperado)
    
    int porcentajeIntereses = ((sumaIntereses / maxPuntos) * 100).round();
    int porcentajeAptitudes = ((sumaAptitudes / maxPuntos) * 100).round();
    int porcentajePersonalidad = ((sumaPersonalidad / maxPuntos) * 100).round();
    
    // Ajustar para que sumen exactamente 100%
    final suma = porcentajeIntereses + porcentajeAptitudes + porcentajePersonalidad;
    
    if (suma != 100) {
      final diferencia = 100 - suma;
      
      // Distribuir la diferencia proporcionalmente
      if (porcentajeIntereses >= porcentajeAptitudes && porcentajeIntereses >= porcentajePersonalidad) {
        porcentajeIntereses += diferencia;
      } else if (porcentajeAptitudes >= porcentajePersonalidad) {
        porcentajeAptitudes += diferencia;
      } else {
        porcentajePersonalidad += diferencia;
      }
    }
    
    // Asegurar que ninguno sea negativo o excesivo
    porcentajeIntereses = porcentajeIntereses.clamp(10, 60);
    porcentajeAptitudes = porcentajeAptitudes.clamp(10, 60);
    porcentajePersonalidad = porcentajePersonalidad.clamp(10, 60);
    
    // Segundo ajuste si es necesario después del clamp
    final sumaFinal = porcentajeIntereses + porcentajeAptitudes + porcentajePersonalidad;
    if (sumaFinal != 100) {
      final ajuste = 100 - sumaFinal;
      // Aplicar al mayor
      if (porcentajeIntereses >= porcentajeAptitudes && porcentajeIntereses >= porcentajePersonalidad) {
        porcentajeIntereses += ajuste;
      } else if (porcentajeAptitudes >= porcentajePersonalidad) {
        porcentajeAptitudes += ajuste;
      } else {
        porcentajePersonalidad += ajuste;
      }
    }
    
    return {
      'Intereses': porcentajeIntereses,
      'Aptitudes': porcentajeAptitudes,
      'Personalidad': porcentajePersonalidad,
    };
  }
  
  /// Obtiene todas las carreras disponibles para un área específica
  List<String> _getAllCareersForArea(String area) {
    final careerMap = {
      'Administracion': [
        'Administración de Empresas',
        'Administración y Finanzas',
        'Administración y Negocios Internacionales',
        'Administración y Marketing',
        'Administración de Empresas (Técnica)',
        'Administración de Negocios Bancarios y Financieros',
        'Gestión Administrativa',
        'Asistencia Administrativa',
      ],
      'Salud': [
        'Medicina Humana',
        'Enfermería',
        'Psicología',
        'Nutrición Humana',
        'Nutrición y Dietética',
        'Tecnología Médica',
        'Enfermería Técnica',
      ],
      'Ingenieria': [
        'Ingeniería Civil',
        'Ingeniería Industrial',
        'Ingeniería Mecánica',
        'Ingeniería Eléctrica',
        'Ingeniería Ambiental',
        'Electricidad Industrial',
        'Construcción Civil',
        'Gestión de la Construcción',
      ],
      'Tecnologia': [
        'Ingeniería de Software',
        'Ingeniería de Sistemas',
        'Ingeniería de Sistemas e Informática',
        'Desarrollo de Sistemas de Información',
        'Diseño y Programación Web',
      ],
      'Ciencias': [
        'Farmacia y Bioquímica',
        'Ingeniería Química',
        'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica',
        'Farmacia Técnica',
      ],
      'ArteDiseno': [
        'Arquitectura',
        'Diseño Profesional de Interiores',
        'Diseño de Interiores (Técnico)',
        'Diseño Gráfico Publicitario',
        'Diseño de Modas',
      ],
      'Educacion': [
        'Educación Inicial',
        'Educación Primaria',
        'Educación Secundaria',
      ],
      'Social': [
        'Trabajo Social',
        'Ciencias de la Comunicación',
      ],
    };
    
    return careerMap[area] ?? [];
  }
  
  /// Calcula puntuaciones por área profesional con pesos optimizados
  Map<String, double> _calculateAreaScores() {
    final scores = <String, double>{
      'Administracion': 0,
      'Salud': 0,
      'Ingenieria': 0,
      'Tecnologia': 0,
      'Ciencias': 0,
      'ArteDiseno': 0,
      'Educacion': 0,
      'Social': 0,
    };
    
    // === TEST DE INTERESES ===
    // Preguntas 1-2: Administración (peso alto)
    if (interesesResponses.isNotEmpty) {
      scores['Administracion'] = scores['Administracion']! + (interesesResponses[0] * 3.0);
    }
    if (interesesResponses.length > 1) {
      scores['Administracion'] = scores['Administracion']! + (interesesResponses[1] * 2.5);
    }
    
    // Preguntas 3-4: Salud (peso alto)
    if (interesesResponses.length > 2) {
      scores['Salud'] = scores['Salud']! + (interesesResponses[2] * 3.0);
    }
    if (interesesResponses.length > 3) {
      scores['Salud'] = scores['Salud']! + (interesesResponses[3] * 2.5);
    }
    
    // Preguntas 5-6: Ingeniería/Tecnología (distribución)
    if (interesesResponses.length > 4) {
      scores['Ingenieria'] = scores['Ingenieria']! + (interesesResponses[4] * 2.0);
      scores['Tecnologia'] = scores['Tecnologia']! + (interesesResponses[4] * 1.5);
    }
    if (interesesResponses.length > 5) {
      scores['Tecnologia'] = scores['Tecnologia']! + (interesesResponses[5] * 2.5);
      scores['Ingenieria'] = scores['Ingenieria']! + (interesesResponses[5] * 1.5);
    }
    
    // Pregunta 7: Ciencias
    if (interesesResponses.length > 6) {
      scores['Ciencias'] = scores['Ciencias']! + (interesesResponses[6] * 2.5);
    }
    
    // Pregunta 8: Arte/Diseño
    if (interesesResponses.length > 7) {
      scores['ArteDiseno'] = scores['ArteDiseno']! + (interesesResponses[7] * 2.5);
    }
    
    // Pregunta 9: Educación
    if (interesesResponses.length > 8) {
      scores['Educacion'] = scores['Educacion']! + (interesesResponses[8] * 2.5);
    }
    
    // Pregunta 10: Social/Legal
    if (interesesResponses.length > 9) {
      scores['Social'] = scores['Social']! + (interesesResponses[9] * 2.5);
    }
    
    // === TEST DE APTITUDES ===
    // Preguntas 1-2: Administración
    if (aptitudesResponses.isNotEmpty) {
      scores['Administracion'] = scores['Administracion']! + (aptitudesResponses[0] * 2.0);
    }
    if (aptitudesResponses.length > 1) {
      scores['Administracion'] = scores['Administracion']! + (aptitudesResponses[1] * 2.0);
    }
    
    // Preguntas 3-4: Salud
    if (aptitudesResponses.length > 2) {
      scores['Salud'] = scores['Salud']! + (aptitudesResponses[2] * 2.0);
    }
    if (aptitudesResponses.length > 3) {
      scores['Salud'] = scores['Salud']! + (aptitudesResponses[3] * 2.0);
    }
    
    // Preguntas 5-6: Ingeniería
    if (aptitudesResponses.length > 4) {
      scores['Ingenieria'] = scores['Ingenieria']! + (aptitudesResponses[4] * 2.5);
    }
    if (aptitudesResponses.length > 5) {
      scores['Ingenieria'] = scores['Ingenieria']! + (aptitudesResponses[5] * 2.5);
    }
    
    // Preguntas 7-8: Tecnología
    if (aptitudesResponses.length > 6) {
      scores['Tecnologia'] = scores['Tecnologia']! + (aptitudesResponses[6] * 2.0);
    }
    if (aptitudesResponses.length > 7) {
      scores['Tecnologia'] = scores['Tecnologia']! + (aptitudesResponses[7] * 2.0);
    }
    
    // Preguntas 9-10: Comunicación/Creatividad (afecta a Arte, Social y Educación)
    if (aptitudesResponses.length > 8) {
      scores['Social'] = scores['Social']! + (aptitudesResponses[8] * 1.5);
      scores['Educacion'] = scores['Educacion']! + (aptitudesResponses[8] * 1.5);
    }
    if (aptitudesResponses.length > 9) {
      scores['ArteDiseno'] = scores['ArteDiseno']! + (aptitudesResponses[9] * 1.5);
      scores['Social'] = scores['Social']! + (aptitudesResponses[9] * 1.0);
    }
    
    // === TEST DE PERSONALIDAD ===
    // Preguntas 1-2: Liderazgo/Administración
    if (personalidadResponses.isNotEmpty) {
      scores['Administracion'] = scores['Administracion']! + (personalidadResponses[0] * 1.5);
    }
    if (personalidadResponses.length > 1) {
      scores['Administracion'] = scores['Administracion']! + (personalidadResponses[1] * 1.5);
    }
    
    // Preguntas 3-4: Salud
    if (personalidadResponses.length > 2) {
      scores['Salud'] = scores['Salud']! + (personalidadResponses[2] * 1.5);
    }
    if (personalidadResponses.length > 3) {
      scores['Salud'] = scores['Salud']! + (personalidadResponses[3] * 1.5);
    }
    
    // Preguntas 5-6: Ingeniería/Tecnología
    if (personalidadResponses.length > 4) {
      scores['Ingenieria'] = scores['Ingenieria']! + (personalidadResponses[4] * 1.0);
      scores['Tecnologia'] = scores['Tecnologia']! + (personalidadResponses[4] * 1.0);
    }
    if (personalidadResponses.length > 5) {
      scores['Tecnologia'] = scores['Tecnologia']! + (personalidadResponses[5] * 1.5);
    }
    
    // Preguntas 7-8: Creatividad/Comunicación
    if (personalidadResponses.length > 6) {
      scores['ArteDiseno'] = scores['ArteDiseno']! + (personalidadResponses[6] * 1.0);
      scores['Social'] = scores['Social']! + (personalidadResponses[6] * 1.0);
    }
    if (personalidadResponses.length > 7) {
      scores['Social'] = scores['Social']! + (personalidadResponses[7] * 1.5);
      scores['Educacion'] = scores['Educacion']! + (personalidadResponses[7] * 1.0);
    }
    
    // Preguntas 9-10: Ética/Trabajo (afecta a todas las áreas profesionales)
    if (personalidadResponses.length > 8) {
      scores['Ingenieria'] = scores['Ingenieria']! + (personalidadResponses[8] * 0.5);
      scores['Tecnologia'] = scores['Tecnologia']! + (personalidadResponses[8] * 0.5);
    }
    if (personalidadResponses.length > 9) {
      scores['Administracion'] = scores['Administracion']! + (personalidadResponses[9] * 0.5);
      scores['Salud'] = scores['Salud']! + (personalidadResponses[9] * 0.5);
    }
    
    return scores;
  }
  
  /// Calcula el nivel de confianza del resultado (0-100)
  double _calculateConfidence(List<MapEntry<String, double>> sortedAreas) {
    final topScore = sortedAreas[0].value;
    final secondScore = sortedAreas[1].value;
    final totalScore = sortedAreas.fold<double>(0, (sum, entry) => sum + entry.value);
    
    // Confianza basada en la diferencia entre el primero y segundo lugar
    final difference = topScore - secondScore;
    if (totalScore == 0) return 0.0;
    
    final confidence = ((difference / totalScore) * 100);
    if (confidence < 0) return 0.0;
    if (confidence > 100) return 100.0;
    
    return confidence;
  }
  
  /// Determina la carrera recomendada basada en el área principal y secundaria
  /// Incluye tanto carreras profesionales (5 años) como técnicas (3 años)
  String _determineRecommendedCareer(String primaryArea, String secondaryArea, Map<String, double> scores) {
    // Mapa de combinaciones de áreas a carreras específicas
    final careerMap = {
      // Administración como área principal
      'Administracion+Salud': 'Administración de Empresas',
      'Administracion+Ingenieria': 'Ingeniería Industrial',
      'Administracion+Tecnologia': 'Administración de Empresas (Técnica)',
      'Administracion+Ciencias': 'Economía',
      'Administracion+ArteDiseno': 'Administración y Marketing',
      'Administracion+Educacion': 'Administración de Empresas',
      'Administracion+Social': 'Administración de Empresas',
      
      // Salud como área principal
      'Salud+Administracion': 'Enfermería',
      'Salud+Ingenieria': 'Tecnología Médica',
      'Salud+Tecnologia': 'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica',
      'Salud+Ciencias': 'Medicina Humana',
      'Salud+ArteDiseno': 'Psicología',
      'Salud+Educacion': 'Enfermería Técnica',
      'Salud+Social': 'Psicología',
      
      // Ingeniería como área principal
      'Ingenieria+Administracion': 'Ingeniería Civil',
      'Ingenieria+Salud': 'Ingeniería Ambiental',
      'Ingenieria+Tecnologia': 'Ingeniería de Sistemas',
      'Ingenieria+Ciencias': 'Ingeniería Química',
      'Ingenieria+ArteDiseno': 'Arquitectura',
      'Ingenieria+Educacion': 'Ingeniería Industrial',
      'Ingenieria+Social': 'Ingeniería Civil',
      
      // Tecnología como área principal
      'Tecnologia+Administracion': 'Desarrollo de Sistemas de Información',
      'Tecnologia+Salud': 'Tecnología Médica',
      'Tecnologia+Ingenieria': 'Ingeniería de Software',
      'Tecnologia+Ciencias': 'Ingeniería de Sistemas e Informática',
      'Tecnologia+ArteDiseno': 'Diseño y Programación Web',
      'Tecnologia+Educacion': 'Desarrollo de Sistemas de Información',
      'Tecnologia+Social': 'Ingeniería de Sistemas',
      
      // Ciencias como área principal
      'Ciencias+Administracion': 'Farmacia y Bioquímica',
      'Ciencias+Salud': 'Medicina Humana',
      'Ciencias+Ingenieria': 'Ingeniería Química',
      'Ciencias+Tecnologia': 'Farmacia y Bioquímica',
      'Ciencias+ArteDiseno': 'Farmacia Técnica',
      'Ciencias+Educacion': 'Tecnología Médica',
      'Ciencias+Social': 'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica',
      
      // Arte y Diseño como área principal
      'ArteDiseno+Administracion': 'Diseño Profesional de Interiores',
      'ArteDiseno+Salud': 'Diseño de Interiores (Técnico)',
      'ArteDiseno+Ingenieria': 'Arquitectura',
      'ArteDiseno+Tecnologia': 'Diseño y Programación Web',
      'ArteDiseno+Ciencias': 'Diseño Gráfico Publicitario',
      'ArteDiseno+Educacion': 'Diseño de Modas',
      'ArteDiseno+Social': 'Diseño Gráfico Publicitario',
      
      // Educación como área principal
      'Educacion+Administracion': 'Educación Primaria',
      'Educacion+Salud': 'Educación Inicial',
      'Educacion+Ingenieria': 'Educación Secundaria',
      'Educacion+Tecnologia': 'Educación Inicial',
      'Educacion+Ciencias': 'Educación Secundaria',
      'Educacion+ArteDiseno': 'Educación Primaria',
      'Educacion+Social': 'Educación Primaria',
      
      // Social como área principal
      'Social+Administracion': 'Trabajo Social',
      'Social+Salud': 'Psicología',
      'Social+Ingenieria': 'Ciencias de la Comunicación',
      'Social+Tecnologia': 'Gestión Administrativa',
      'Social+Ciencias': 'Psicología',
      'Social+ArteDiseno': 'Diseño Gráfico Publicitario',
      'Social+Educacion': 'Psicología',
    };
    
    final key = '$primaryArea+$secondaryArea';
    return careerMap[key] ?? 'Administración de Empresas';
  }
  
  /// Obtiene el título del perfil basado en las áreas
  String _getProfileTitle(String primaryArea, String secondaryArea) {
    final titles = {
      'Administracion': 'Líder Empresarial',
      'Salud': 'Profesional de la Salud',
      'Ingenieria': 'Ingeniero Innovador',
      'Tecnologia': 'Experto en Tecnología',
      'Ciencias': 'Científico Investigador',
      'ArteDiseno': 'Creativo Artístico',
      'Educacion': 'Educador Dedicado',
      'Social': 'Ciencias Sociales',
    };
    
    return titles[primaryArea] ?? 'Profesional Versátil';
  }
  
  /// Obtiene las carreras afines (excluyendo la carrera principal)
  List<String> _getRelatedCareers(String area, String carreraPrincipal) {
    final careerMap = {
      'Administracion': [
        'Administración de Empresas',
        'Administración y Finanzas',
        'Administración y Negocios Internacionales',
        'Administración de Empresas (Técnica)',
        'Gestión Administrativa',
      ],
      'Salud': [
        'Medicina Humana',
        'Enfermería',
        'Psicología',
        'Tecnología Médica',
        'Enfermería Técnica',
      ],
      'Ingenieria': [
        'Ingeniería Civil',
        'Ingeniería Industrial',
        'Ingeniería Mecánica',
        'Ingeniería Ambiental',
        'Electricidad Industrial',
      ],
      'Tecnologia': [
        'Ingeniería de Software',
        'Ingeniería de Sistemas',
        'Desarrollo de Sistemas de Información',
        'Diseño y Programación Web',
        'Ingeniería de Sistemas e Informática',
      ],
      'Ciencias': [
        'Farmacia y Bioquímica',
        'Ingeniería Química',
        'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica',
        'Farmacia Técnica',
      ],
      'ArteDiseno': [
        'Arquitectura',
        'Diseño Profesional de Interiores',
        'Diseño Gráfico Publicitario',
        'Diseño de Modas',
        'Diseño de Interiores (Técnico)',
      ],
      'Educacion': [
        'Educación Inicial',
        'Educación Primaria',
        'Educación Secundaria',
      ],
      'Social': [
        'Trabajo Social',
        'Ciencias de la Comunicación',
      ],
    };
    
    final carreras = careerMap[area] ?? [];
    return carreras.where((c) => c != carreraPrincipal).take(3).toList();
  }
  
  /// Obtiene el área correspondiente a una carrera específica
  String? _getAreaForCareer(String carrera) {
    final careerToAreaMap = {
      // Administración
      'Administración de Empresas': 'Administracion',
      'Administración de Empresas (Técnica)': 'Administracion',
      'Administración y Finanzas': 'Administracion',
      'Administración y Negocios Internacionales': 'Administracion',
      'Administración y Marketing': 'Administracion',
      'Gestión Administrativa': 'Administracion',
      'Asistencia Administrativa': 'Administracion',
      
      // Salud
      'Medicina Humana': 'Salud',
      'Enfermería': 'Salud',
      'Enfermería Técnica': 'Salud',
      'Psicología': 'Salud',
      'Tecnología Médica': 'Salud',
      'Tecnología Médica – Terapia Física y Rehabilitación': 'Salud',
      'Terapia Física': 'Salud',
      'Radiología': 'Salud',
      'Optometría': 'Salud',
      
      // Ingeniería
      'Ingeniería Civil': 'Ingenieria',
      'Ingeniería Industrial': 'Ingenieria',
      'Ingeniería Mecánica': 'Ingenieria',
      'Ingeniería Eléctrica': 'Ingenieria',
      'Ingeniería Eléctrica y Electrónica': 'Ingenieria',
      'Ingeniería de Minas': 'Ingenieria',
      'Ingeniería Ambiental': 'Ingenieria',
      'Ingeniería Mecatrónica': 'Ingenieria',
      'Ingeniería Metalúrgica y de Materiales': 'Ingenieria',
      'Electricidad Industrial': 'Ingenieria',
      'Mantenimiento de Maquinaria Pesada': 'Ingenieria',
      'Construcción Civil': 'Ingenieria',
      'Gestión de la Construcción': 'Ingenieria',
      
      // Tecnología
      'Ingeniería de Software': 'Tecnologia',
      'Ingeniería de Sistemas': 'Tecnologia',
      'Ingeniería de Sistemas e Informática': 'Tecnologia',
      'Ingeniería de Sistemas y Computación': 'Tecnologia',
      'Desarrollo de Sistemas de Información': 'Tecnologia',
      'Diseño y Programación Web': 'Tecnologia',
      
      // Ciencias
      'Farmacia y Bioquímica': 'Ciencias',
      'Ingeniería Química': 'Ciencias',
      'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica': 'Ciencias',
      'Farmacia Técnica': 'Ciencias',
      
      // Arte y Diseño
      'Arquitectura': 'ArteDiseno',
      'Diseño Profesional de Interiores': 'ArteDiseno',
      'Diseño de Interiores (Técnico)': 'ArteDiseno',
      'Diseño Gráfico Publicitario': 'ArteDiseno',
      'Diseño de Modas': 'ArteDiseno',
      
      // Educación
      'Educación Inicial': 'Educacion',
      'Educación Primaria': 'Educacion',
      'Educación Secundaria': 'Educacion',
      
      // Social
      'Trabajo Social': 'Social',
      'Ciencias de la Comunicación': 'Social',
    };
    
    return careerToAreaMap[carrera];
  }
  
  /// Obtiene la descripción de la carrera con nivel de confianza
  String _getCareerDescription(String carrera, String area, double confidence) {
    String baseDescription;
    
    switch (carrera) {
      // Administración
      case 'Administración de Empresas':
        baseDescription = 'Tienes habilidades de liderazgo, organización y visión estratégica. Puedes desempeñarte gestionando organizaciones, recursos humanos y operaciones empresariales.';
        break;
      case 'Administración de Empresas (Técnica)':
        baseDescription = 'Tienes habilidades prácticas para la gestión administrativa. Puedes desempeñarte en operaciones administrativas, atención al cliente y apoyo ejecutivo.';
        break;
      case 'Administración y Finanzas':
        baseDescription = 'Eres bueno analizando datos numéricos y gestionando recursos financieros. Puedes desempeñarte en áreas contables, financieras y de presupuesto.';
        break;
      case 'Administración y Negocios Internacionales':
        baseDescription = 'Tienes visión global y habilidades de negociación. Puedes desempeñarte en comercio exterior, empresas multinacionales y logística internacional.';
        break;
      case 'Administración y Marketing':
        baseDescription = 'Eres creativo y tienes visión comercial. Puedes desempeñarte en estrategias de mercado, investigación y gestión de marca.';
        break;
      case 'Gestión Administrativa':
        baseDescription = 'Posees habilidades de coordinación y gestión de procesos. Puedes desempeñarte optimizando procesos administrativos empresariales.';
        break;
        
      // Salud
      case 'Medicina Humana':
        baseDescription = 'Tienes vocación de servicio, empatía y capacidad de memorización. Puedes desempeñarte diagnosticando, tratando y previniendo enfermedades.';
        break;
      case 'Enfermería':
        baseDescription = 'Posees empatía, paciencia y habilidades prácticas. Puedes desempeñarte cuidando pacientes, administrando tratamientos y apoyando en procedimientos médicos.';
        break;
      case 'Enfermería Técnica':
        baseDescription = 'Tienes vocación de servicio y habilidades prácticas. Puedes desempeñarte brindando cuidados básicos de salud y apoyo en procedimientos médicos.';
        break;
      case 'Psicología':
        baseDescription = 'Tienes capacidad de escucha, empatía y análisis conductual. Puedes desempeñarte ayudando a personas a mejorar su bienestar emocional y mental.';
        break;
      case 'Tecnología Médica':
        baseDescription = 'Combinas conocimientos técnicos con vocación de servicio. Puedes desempeñarte realizando procedimientos diagnósticos y terapéuticos especializados.';
        break;
      case 'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica':
        baseDescription = 'Tienes precisión y conocimientos científicos. Puedes desempeñarte analizando muestras biológicas y apoyando en diagnósticos médicos.';
        break;
        
      // Ingeniería
      case 'Ingeniería Civil':
        baseDescription = 'Tienes habilidades matemáticas, visión espacial y capacidad de planificación. Puedes desempeñarte diseñando y construyendo infraestructuras.';
        break;
      case 'Ingeniería Industrial':
        baseDescription = 'Posees habilidades de organización, optimización y liderazgo. Puedes desempeñarte mejorando procesos productivos y gestionando operaciones.';
        break;
      case 'Ingeniería Mecánica':
        baseDescription = 'Tienes habilidades técnicas y visión mecánica. Puedes desempeñarte diseñando, construyendo y manteniendo sistemas mecánicos.';
        break;
      case 'Ingeniería Ambiental':
        baseDescription = 'Combinas conocimientos técnicos con conciencia ambiental. Puedes desempeñarte desarrollando soluciones sostenibles para el cuidado del medio ambiente.';
        break;
      case 'Electricidad Industrial':
        baseDescription = 'Posees habilidades técnicas y conocimiento eléctrico. Puedes desempeñarte en instalaciones, mantenimiento y sistemas eléctricos industriales.';
        break;
        
      // Tecnología
      case 'Ingeniería de Software':
        baseDescription = 'Tienes habilidades para el pensamiento lógico, resolución de problemas y creatividad tecnológica. Puedes desempeñarte desarrollando aplicaciones y sistemas informáticos.';
        break;
      case 'Ingeniería de Sistemas':
        baseDescription = 'Tienes capacidad de análisis y visión tecnológica. Puedes desempeñarte gestionando infraestructuras tecnológicas y optimizando procesos.';
        break;
      case 'Ingeniería de Sistemas e Informática':
        baseDescription = 'Posees capacidad de análisis, organización y visión tecnológica. Puedes desempeñarte gestionando infraestructuras tecnológicas empresariales.';
        break;
      case 'Desarrollo de Sistemas de Información':
        baseDescription = 'Tienes habilidades prácticas para la programación. Puedes desempeñarte desarrollando software y aplicaciones empresariales.';
        break;
      case 'Diseño y Programación Web':
        baseDescription = 'Combinas creatividad con habilidades técnicas. Puedes desempeñarte diseñando y desarrollando sitios web y aplicaciones web.';
        break;
        
      // Ciencias
      case 'Farmacia y Bioquímica':
        baseDescription = 'Tienes precisión, conocimiento científico y atención al detalle. Puedes desempeñarte en laboratorios, farmacias y desarrollo de medicamentos.';
        break;
      case 'Ingeniería Química':
        baseDescription = 'Tienes capacidad analítica y comprensión de procesos científicos. Puedes desempeñarte en industrias químicas y farmacéuticas.';
        break;
      case 'Farmacia Técnica':
        baseDescription = 'Posees precisión y conocimientos farmacéuticos. Puedes desempeñarte dispensando medicamentos y brindando información farmacéutica.';
        break;
        
      // Arte y Diseño
      case 'Arquitectura':
        baseDescription = 'Tienes creatividad, visión espacial y sensibilidad estética. Puedes desempeñarte diseñando espacios habitables funcionales y estéticamente agradables.';
        break;
      case 'Diseño Profesional de Interiores':
        baseDescription = 'Posees creatividad, sentido estético y capacidad de transformar espacios. Puedes desempeñarte creando ambientes interiores funcionales y atractivos.';
        break;
      case 'Diseño de Interiores (Técnico)':
        baseDescription = 'Tienes creatividad y sentido estético. Puedes desempeñarte diseñando espacios interiores funcionales y atractivos.';
        break;
      case 'Diseño Gráfico Publicitario':
        baseDescription = 'Tienes talento artístico y habilidades de comunicación visual. Puedes desempeñarte creando piezas gráficas para publicidad y comunicación.';
        break;
      case 'Diseño de Modas':
        baseDescription = 'Posees creatividad y visión de tendencias. Puedes desempeñarte diseñando prendas, accesorios y colecciones de moda.';
        break;
        
      // Educación
      case 'Educación Inicial':
        baseDescription = 'Tienes paciencia, creatividad y pasión por enseñar. Puedes desempeñarte formando a niños en su etapa escolar inicial.';
        break;
      case 'Educación Primaria':
        baseDescription = 'Posees paciencia, creatividad y pasión por enseñar. Puedes desempeñarte formando a niños en su etapa escolar primaria.';
        break;
      case 'Educación Secundaria':
        baseDescription = 'Tienes conocimientos especializados y habilidades pedagógicas. Puedes desempeñarte formando a adolescentes en nivel secundario.';
        break;
        
      // Social
      case 'Trabajo Social':
        baseDescription = 'Tienes vocación de ayuda, empatía y compromiso social. Puedes desempeñarte apoyando a personas y comunidades en situación de vulnerabilidad.';
        break;
      case 'Ciencias de la Comunicación':
        baseDescription = 'Tienes habilidades de comunicación y creatividad. Puedes desempeñarte en medios de comunicación, relaciones públicas y producción audiovisual.';
        break;
      case 'Asistencia Administrativa':
        baseDescription = 'Tienes organización, comunicación y manejo de oficina. Puedes desempeñarte brindando apoyo administrativo en diversas organizaciones.';
        break;
        
      default:
        baseDescription = 'Esta carrera se alinea con tus intereses, aptitudes y personalidad. Tienes las habilidades necesarias para desarrollarte profesionalmente en este campo.';
    }
    
    return baseDescription;
  }
  
  /// Obtiene la imagen de la carrera
  String _getCareerImage(String carrera) {
    // Mapa de imágenes de carreras (usando las mismas de la interfaz Carreras)
    final imageMap = {
      // Administración
      'Administración de Empresas': 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=300&fit=crop',
      'Administración de Empresas (Técnica)': 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=300&fit=crop',
      'Administración y Finanzas': 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=300&fit=crop',
      'Administración y Negocios Internacionales': 'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=400&h=300&fit=crop',
      'Administración y Marketing': 'https://images.unsplash.com/photo-1533750349088-cd871a92f312?w=400&h=300&fit=crop',
      'Gestión Administrativa': 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=400&h=300&fit=crop',
      
      // Salud
      'Medicina Humana': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=300&fit=crop',
      'Enfermería': 'https://images.unsplash.com/photo-1551076805-e1869033e561?w=400&h=300&fit=crop',
      'Enfermería Técnica': 'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400&h=300&fit=crop',
      'Psicología': 'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=400&h=300&fit=crop',
      'Tecnología Médica': 'https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?w=400&h=300&fit=crop',
      'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica': 'https://images.unsplash.com/photo-1582719471384-894fbb16e074?w=400&h=300&fit=crop',
      
      // Ingeniería
      'Ingeniería Civil': 'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=400&h=300&fit=crop',
      'Ingeniería Industrial': 'https://images.unsplash.com/photo-1565043666747-69f6646db940?w=400&h=300&fit=crop',
      'Ingeniería Mecánica': 'https://images.unsplash.com/photo-1537462715879-360eeb61a0ad?w=400&h=300&fit=crop',
      'Ingeniería Ambiental': 'https://images.unsplash.com/photo-1497436072909-60f360e1d4b1?w=400&h=300&fit=crop',
      'Electricidad Industrial': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=400&h=300&fit=crop',
      
      // Tecnología
      'Ingeniería de Software': 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=400&h=300&fit=crop',
      'Ingeniería de Sistemas': 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=400&h=300&fit=crop',
      'Ingeniería de Sistemas e Informática': 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400&h=300&fit=crop',
      'Desarrollo de Sistemas de Información': 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400&h=300&fit=crop',
      'Diseño y Programación Web': 'https://images.unsplash.com/photo-1547658719-da2b51169166?w=400&h=300&fit=crop',
      
      // Ciencias
      'Farmacia y Bioquímica': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=400&h=300&fit=crop',
      'Ingeniería Química': 'https://images.unsplash.com/photo-1579165466949-3180a3d056d5?w=400&h=300&fit=crop',
      'Farmacia Técnica': 'https://images.unsplash.com/photo-1585435557343-3b092031a831?w=400&h=300&fit=crop',
      
      // Arte y Diseño
      'Arquitectura': 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=400&h=300&fit=crop',
      'Diseño Profesional de Interiores': 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=400&h=300&fit=crop',
      'Diseño de Interiores (Técnico)': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
      'Diseño Gráfico Publicitario': 'https://images.unsplash.com/photo-1626785774573-4b799315345d?w=400&h=300&fit=crop',
      'Diseño de Modas': 'https://images.unsplash.com/photo-1558171813-4c088753af8f?w=400&h=300&fit=crop',
      
      // Educación
      'Educación Inicial': 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400&h=300&fit=crop',
      'Educación Primaria': 'https://images.unsplash.com/photo-1509062522246-3755977927d7?w=400&h=300&fit=crop',
      'Educación Secundaria': 'https://images.unsplash.com/photo-1427504740701-44c33e1d62f2?w=400&h=300&fit=crop',
      
      // Social
      'Trabajo Social': 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=400&h=300&fit=crop',
      'Ciencias de la Comunicación': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop',
      'Asistencia Administrativa': 'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=400&h=300&fit=crop',
    };
    
    return imageMap[carrera] ?? 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=300&fit=crop';
  }
  
  /// Método público para obtener carreras recomendadas por área
  List<String> getRecommendedCareers(String area) {
    return _getRelatedCareers(area, '').take(5).toList();
  }
}
