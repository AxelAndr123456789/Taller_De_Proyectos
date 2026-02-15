/// Modelo para representar una carrera con sus universidades asociadas
class CarreraConInstituciones {
  final String nombre;
  final String descripcion;
  final String imagenUrl;
  final String portadaUrl;
  final List<String> instituciones;

  const CarreraConInstituciones({
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.portadaUrl,
    required this.instituciones,
  });
}

/// Datos de todas las universidades y sus carreras
class DatosUniversidades {
  /// Universidad Nacional del Centro del Perú
  static const List<String> uncCarreras = [
    'Enfermería',
    'Medicina Humana',
    'Arquitectura',
    'Ingeniería Civil',
    'Ingeniería de Minas',
    'Ingeniería de Sistemas',
    'Ingeniería Eléctrica y Electrónica',
    'Ingeniería Mecánica',
    'Ingeniería Metalúrgica y de Materiales',
    'Ingeniería Química',
    'Administración de Empresas',
    'Contabilidad',
    'Economía',
    'Antropología',
    'Ciencias de la Comunicación',
    'Derecho y Ciencias Políticas',
    'Sociología',
    'Trabajo Social',
    'Agronomía',
    'Zootecnia',
  ];

  /// Universidad Continental
  static const List<String> continentalCarreras = [
    'Arquitectura',
    'Ingeniería Ambiental',
    'Ingeniería Civil',
    'Ingeniería Eléctrica',
    'Ingeniería Industrial',
    'Ingeniería Mecánica',
    'Ingeniería Mecatrónica',
    'Ingeniería de Minas',
    'Ingeniería de Sistemas e Informática',
    'Administración',
    'Administración y Finanzas',
    'Administración y Gestión Pública',
    'Administración y Marketing',
    'Administración y Negocios Internacionales',
    'Contabilidad',
    'Economía',
    'Derecho',
    'Medicina Humana',
    'Enfermería',
    'Odontología',
    'Tecnología Médica',
    'Psicología',
    'Ciencias y Tecnología de la Comunicación',
    'Educación',
  ];

  /// Universidad Peruana Los Andes
  static const List<String> uplaCarreras = [
    'Administración y Sistemas',
    'Contabilidad y Finanzas',
    'Arquitectura',
    'Ingeniería Civil',
    'Ingeniería Industrial',
    'Ingeniería del Medio Ambiente',
    'Ingeniería de Sistemas y Computación',
    'Enfermería',
    'Farmacia y Bioquímica',
    'Obstetricia',
    'Odontología',
    'Medicina Veterinaria y Zootecnia',
    'Nutrición Humana',
    'Psicología',
    'Radiología',
    'Laboratorio Clínico y Anatomía Patológica',
    'Terapia Física y Rehabilitación',
    'Optometría',
    'Medicina',
    'Educación Primaria',
    'Educación Secundaria',
    'Derecho',
  ];

  /// Universidad Privada de Huancayo Franklin Roosevelt
  static const List<String> franklinRooseveltCarreras = [
    'Derecho',
    'Medicina Humana',
    'Enfermería',
    'Obstetricia',
    'Psicología',
    'Farmacia y Bioquímica',
    'Estomatología',
    'Administración de Empresas',
    'Administración y Negocios Internacionales',
  ];

  /// Universidad Tecnológica del Perú
  static const List<String> utpCarreras = [
    'Ingeniería Civil',
    'Ingeniería Industrial',
    'Ingeniería Ambiental',
    'Ingeniería de Sistemas e Informática',
    'Ingeniería de Software',
    'Administración de Empresas',
    'Administración de Negocios Internacionales',
    'Administración y Marketing',
    'Contabilidad',
    'Economía',
    'Psicología',
    'Ciencias de la Comunicación',
    'Educación Inicial',
    'Educación Primaria',
    'Enfermería',
    'Nutrición y Dietética',
    'Obstetricia',
    'Terapia Física',
    'Odontología',
    'Farmacia y Bioquímica',
    'Arquitectura',
    'Diseño Profesional de Interiores',
    'Derecho',
  ];

  /// Instituto de Educación Superior Privado Continental
  static const List<String> iepContinentalCarreras = [
    'Administración de Empresas',
    'Administración de Negocios Bancarios y Financieros',
    'Contabilidad',
    'Desarrollo de Sistemas de Información',
    'Diseño de Interiores',
    'Diseño de Modas',
    'Diseño Gráfico Publicitario',
    'Gastronomía',
    'Gestión de la Construcción',
  ];

  /// Tecnológico InterAmericano
  static const List<String> tecnoInterCarreras = [
    'Mantenimiento de Maquinaria Pesada',
    'Electricidad Industrial',
    'Construcción Civil',
    'Administración de Negocios Bancarios y Financieros',
    'Contabilidad',
    'Gestión Administrativa',
    'Gestión Logística',
    'Enfermería Técnica',
    'Farmacia Técnica',
    'Diseño y Programación Web',
  ];

  /// Instituto de Educación Superior Privado Eugenio Paccelly
  static const List<String> eugenioPaccellyCarreras = [
    'Gestión Administrativa',
    'Contabilidad',
    'Enfermería Técnica',
    'Farmacia Técnica',
  ];

  /// Instituto de Educación Superior Privado San Pedro
  static const List<String> sanPedroCarreras = [
    'Gastronomía',
    'Contabilidad',
  ];

  /// Instituto de Educación Superior Privado Santa Lucía
  static const List<String> santaLuciaCarreras = [
    'Asistencia Administrativa',
    'Enfermería Técnica',
    'Farmacia Técnica',
  ];
}

/// Mapeo de instituciones por nombre
class InstitucionesMap {
  static const String unc = 'Universidad Nacional del Centro del Perú';
  static const String continental = 'Universidad Continental';
  static const String upla = 'Universidad Peruana Los Andes';
  static const String franklinRoosevelt = 'Universidad Privada de Huancayo Franklin Roosevelt';
  static const String utp = 'Universidad Tecnológica del Perú';
  static const String iepContinental = 'Instituto de Educación Superior Privado Continental';
  static const String tecnoInter = 'Tecnológico InterAmericano';
  static const String eugenioPaccelly = 'Instituto de Educación Superior Privado Eugenio Paccelly';
  static const String sanPedro = 'Instituto de Educación Superior Privado San Pedro';
  static const String santaLucia = 'Instituto de Educación Superior Privado Santa Lucía';
}
