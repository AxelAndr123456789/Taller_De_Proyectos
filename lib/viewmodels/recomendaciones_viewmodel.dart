import 'package:flutter/foundation.dart';
import '../models/carrera.dart';
import '../models/carrera_con_instituciones.dart';
import 'recomendaciones_carreras_data.dart';

/// ViewModel para la pantalla de recomendaciones de carreras.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para las recomendaciones de carreras y notifica cambios a la vista.
class RecomendacionesViewModel with ChangeNotifier {
  int _selectedIndex = 3;

  int get selectedIndex => _selectedIndex;

  /// Lista de todas las carreras
  final List<Carrera> carreras = CarrerasData.carreras;

  /// Mapa de carreras y sus instituciones asociadas
  static final Map<String, List<String>> _carrerasInstituciones = {
    // Carreras de salud - Universitarias (5 años)
    'Enfermería': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
      InstitucionesMap.upla,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.utp,
    ],
    'Medicina General': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.upla,
    ],
    'Obstetricia': [
      InstitucionesMap.upla,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.utp,
    ],
    'Odontología': [
      InstitucionesMap.continental,
      InstitucionesMap.upla,
      InstitucionesMap.utp,
    ],
    'Farmacia y Bioquímica': [
      InstitucionesMap.upla,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.utp,
    ],
    'Estomatología': [
      InstitucionesMap.franklinRoosevelt,
    ],
    'Nutrición Humana': [
      InstitucionesMap.upla,
    ],
    'Nutrición y Dietética': [
      InstitucionesMap.utp,
    ],
    'Psicología': [
      InstitucionesMap.continental,
      InstitucionesMap.upla,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.utp,
    ],
    'Tecnología Médica': [
      InstitucionesMap.continental,
    ],
    'Radiología': [
      InstitucionesMap.upla,
    ],
    'Laboratorio Clínico y Anatomía Patológica': [
      InstitucionesMap.upla,
    ],
    'Terapia Física y Rehabilitación': [
      InstitucionesMap.upla,
    ],
    'Terapia Física': [
      InstitucionesMap.utp,
    ],
    'Optometría': [
      InstitucionesMap.upla,
    ],
    'Medicina Veterinaria y Zootecnia': [
      InstitucionesMap.upla,
    ],
    'Enfermería Técnica': [
      InstitucionesMap.tecnoInter,
      InstitucionesMap.eugenioPaccelly,
      InstitucionesMap.santaLucia,
    ],
    'Farmacia Técnica': [
      InstitucionesMap.tecnoInter,
      InstitucionesMap.eugenioPaccelly,
      InstitucionesMap.santaLucia,
    ],

    // Carreras de ingeniería
    'Ingeniería de Software': [
      InstitucionesMap.utp,
    ],
    'Ingeniería de Sistemas': [
      InstitucionesMap.unc,
    ],
    'Ingeniería de Sistemas e Informática': [
      InstitucionesMap.continental,
      InstitucionesMap.utp,
    ],
    'Ingeniería de Sistemas y Computación': [
      InstitucionesMap.upla,
    ],
    'Ingeniería Civil': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
      InstitucionesMap.upla,
      InstitucionesMap.utp,
    ],
    'Ingeniería de Minas': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
    ],
    'Ingeniería Mecánica': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
    ],
    'Ingeniería Eléctrica y Electrónica': [
      InstitucionesMap.unc,
    ],
    'Ingeniería Eléctrica': [
      InstitucionesMap.continental,
    ],
    'Ingeniería Industrial': [
      InstitucionesMap.continental,
      InstitucionesMap.upla,
      InstitucionesMap.utp,
    ],
    'Ingeniería Mecatrónica': [
      InstitucionesMap.continental,
    ],
    'Ingeniería Ambiental': [
      InstitucionesMap.continental,
      InstitucionesMap.utp,
    ],
    'Ingeniería del Medio Ambiente': [
      InstitucionesMap.upla,
    ],
    'Ingeniería Metalúrgica y de Materiales': [
      InstitucionesMap.unc,
    ],
    'Ingeniería Química': [
      InstitucionesMap.unc,
    ],
    'Desarrollo de Sistemas de Información': [
      InstitucionesMap.iepContinental,
    ],
    'Electricidad Industrial': [
      InstitucionesMap.tecnoInter,
    ],
    'Mantenimiento de Maquinaria Pesada': [
      InstitucionesMap.tecnoInter,
    ],
    'Construcción Civil': [
      InstitucionesMap.tecnoInter,
    ],
    'Gestión de la Construcción': [
      InstitucionesMap.iepContinental,
    ],

    // Carreras de arquitectura y diseño
    'Arquitectura': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
      InstitucionesMap.upla,
      InstitucionesMap.utp,
    ],
    'Diseño Profesional de Interiores': [
      InstitucionesMap.utp,
    ],
    'Diseño de Interiores': [
      InstitucionesMap.iepContinental,
    ],
    'Diseño de Modas': [
      InstitucionesMap.iepContinental,
    ],
    'Diseño Gráfico Publicitario': [
      InstitucionesMap.iepContinental,
    ],
    'Diseño y Programación Web': [
      InstitucionesMap.tecnoInter,
    ],
    'Gastronomía': [
      InstitucionesMap.iepContinental,
      InstitucionesMap.sanPedro,
    ],

    // Carreras administrativas y económicas
    'Administración de Empresas': [
      InstitucionesMap.unc,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.utp,
    ],
    'Administración': [
      InstitucionesMap.continental,
    ],
    'Administración y Sistemas': [
      InstitucionesMap.upla,
    ],
    'Administración y Finanzas': [
      InstitucionesMap.continental,
      InstitucionesMap.upla,
    ],
    'Administración y Gestión Pública': [
      InstitucionesMap.continental,
    ],
    'Administración y Marketing': [
      InstitucionesMap.continental,
      InstitucionesMap.utp,
    ],
    'Administración y Negocios Internacionales': [
      InstitucionesMap.continental,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.utp,
    ],
    'Administración de Negocios Internacionales': [
      InstitucionesMap.utp,
    ],
    'Administración de Negocios Bancarios y Financieros': [
      InstitucionesMap.tecnoInter,
    ],
    'Gestión Administrativa': [
      InstitucionesMap.eugenioPaccelly,
    ],
    'Gestión Logística': [
      InstitucionesMap.tecnoInter,
    ],
    'Asistencia Administrativa': [
      InstitucionesMap.santaLucia,
    ],
    'Contabilidad': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
    ],
    'Contabilidad y Finanzas': [
      InstitucionesMap.upla,
    ],
    'Economía': [
      InstitucionesMap.unc,
      InstitucionesMap.continental,
      InstitucionesMap.utp,
    ],

    // Carreras de derecho y ciencias sociales
    'Derecho': [
      InstitucionesMap.upla,
      InstitucionesMap.continental,
      InstitucionesMap.franklinRoosevelt,
      InstitucionesMap.utp,
    ],
    'Derecho y Ciencias Políticas': [
      InstitucionesMap.unc,
    ],
    'Antropología': [
      InstitucionesMap.unc,
    ],
    'Sociología': [
      InstitucionesMap.unc,
    ],
    'Trabajo Social': [
      InstitucionesMap.unc,
    ],

    // Carreras de comunicación y educación
    'Ciencias de la Comunicación': [
      InstitucionesMap.unc,
      InstitucionesMap.utp,
    ],
    'Ciencias y Tecnología de la Comunicación': [
      InstitucionesMap.continental,
    ],
    'Educación Inicial': [
      InstitucionesMap.utp,
    ],
    'Educación Primaria': [
      InstitucionesMap.upla,
      InstitucionesMap.utp,
    ],
    'Educación Secundaria': [
      InstitucionesMap.upla,
    ],

    // Carreras agropecuarias
    'Agronomía': [
      InstitucionesMap.unc,
    ],
    'Zootecnia': [
      InstitucionesMap.unc,
    ],
  };

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Obtiene el número de carreras recomendadas
  int getCarrerasCount() {
    return carreras.length;
  }

  /// Obtiene las instituciones donde se puede estudiar una carrera específica
  List<String> getInstitucionesPorCarrera(String nombreCarrera) {
    return _carrerasInstituciones[nombreCarrera] ?? [];
  }
}
