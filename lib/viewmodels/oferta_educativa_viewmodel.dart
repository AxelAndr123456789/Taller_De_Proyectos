import 'package:flutter/foundation.dart';

/// Modelo de datos para una institución educativa
class Institucion {
  final String nombre;
  final String direccion;
  final String imagenUrl;
  final String tipo;

  const Institucion({
    required this.nombre,
    required this.direccion,
    required this.imagenUrl,
    required this.tipo,
  });
}

/// ViewModel para la pantalla de oferta educativa.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para la oferta educativa y notifica cambios a la vista.
class OfertaEducativaViewModel with ChangeNotifier {
  int _selectedIndex = 3;

  int get selectedIndex => _selectedIndex;

  /// Mapa de todas las instituciones por nombre
  final Map<String, Institucion> _todasInstituciones = {
    'Universidad Nacional del Centro del Perú': const Institucion(
      nombre: 'Universidad Nacional del Centro del Perú',
      direccion: 'Av. Los Incas s/n, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
      tipo: 'Universidad Pública',
    ),
    'Universidad Continental': const Institucion(
      nombre: 'Universidad Continental',
      direccion: 'Jr. Junín 140, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
      tipo: 'Universidad Privada',
    ),
    'Universidad Peruana Los Andes': const Institucion(
      nombre: 'Universidad Peruana Los Andes',
      direccion: 'Av. Ferrocarril 481, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
      tipo: 'Universidad Privada',
    ),
    'Universidad Privada de Huancayo Franklin Roosevelt': const Institucion(
      nombre: 'Universidad Privada de Huancayo Franklin Roosevelt',
      direccion: 'Av. Centenario 865, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
      tipo: 'Universidad Privada',
    ),
    'Universidad Tecnológica del Perú': const Institucion(
      nombre: 'Universidad Tecnológica del Perú',
      direccion: 'Av. Mantaro 1230, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
      tipo: 'Universidad Privada',
    ),
    'Instituto de Educación Superior Privado Continental': const Institucion(
      nombre: 'Instituto de Educación Superior Privado Continental',
      direccion: 'Jr. Junín 140, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
      tipo: 'Instituto',
    ),
    'Tecnológico InterAmericano': const Institucion(
      nombre: 'Tecnológico InterAmericano',
      direccion: 'Av. Ferrocarril 1234, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
      tipo: 'Instituto',
    ),
    'Instituto de Educación Superior Privado Eugenio Paccelly': const Institucion(
      nombre: 'Instituto de Educación Superior Privado Eugenio Paccelly',
      direccion: 'Jr. Amazonas 567, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
      tipo: 'Instituto',
    ),
    'Instituto de Educación Superior Privado San Pedro': const Institucion(
      nombre: 'Instituto de Educación Superior Privado San Pedro',
      direccion: 'Av. Los Incas 890, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
      tipo: 'Instituto',
    ),
    'Instituto de Educación Superior Privado Santa Lucía': const Institucion(
      nombre: 'Instituto de Educación Superior Privado Santa Lucía',
      direccion: 'Calle Real 321, Huancayo',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
      tipo: 'Instituto',
    ),
  };

  /// Mapeo de carreras a instituciones según la información proporcionada
  final Map<String, List<String>> _carrerasInstituciones = {
    // CARRERAS PROFESIONALES (Universitarias) - 5 años

    // Administración
    'Administración de Empresas': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Privada de Huancayo Franklin Roosevelt',
      'Universidad Tecnológica del Perú',
    ],
    'Administración y Finanzas': [
      'Universidad Continental',
    ],
    'Administración y Gestión Pública': [
      'Universidad Continental',
    ],
    'Administración y Marketing': [
      'Universidad Continental',
      'Universidad Tecnológica del Perú',
    ],
    'Administración y Negocios Internacionales': [
      'Universidad Continental',
      'Universidad Privada de Huancayo Franklin Roosevelt',
      'Universidad Tecnológica del Perú',
    ],

    // Agronomía
    'Agronomía': [
      'Universidad Nacional del Centro del Perú',
    ],

    // Antropología
    'Antropología': [
      'Universidad Nacional del Centro del Perú',
    ],

    // Arquitectura
    'Arquitectura': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Tecnológica del Perú',
    ],

    // Ciencias de la Comunicación
    'Ciencias de la Comunicación': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Tecnológica del Perú',
    ],

    // Contabilidad
    'Contabilidad': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Tecnológica del Perú',
    ],
    'Contabilidad y Finanzas': [
      'Universidad Peruana Los Andes',
    ],

    // Derecho
    'Derecho': [
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Tecnológica del Perú',
    ],
    'Derecho y Ciencias Políticas': [
      'Universidad Nacional del Centro del Perú',
    ],

    // Diseño Profesional de Interiores
    'Diseño Profesional de Interiores': [
      'Universidad Tecnológica del Perú',
    ],

    // Economía
    'Economía': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Tecnológica del Perú',
    ],

    // Educación
    'Educación': [
      'Universidad Continental',
    ],
    'Educación Inicial': [
      'Universidad Tecnológica del Perú',
    ],
    'Educación Primaria': [
      'Universidad Peruana Los Andes',
      'Universidad Tecnológica del Perú',
    ],
    'Educación Secundaria': [
      'Universidad Peruana Los Andes',
    ],

    // Enfermería
    'Enfermería': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Privada de Huancayo Franklin Roosevelt',
      'Universidad Tecnológica del Perú',
    ],

    // Estomatología
    'Estomatología': [
      'Universidad Privada de Huancayo Franklin Roosevelt',
    ],

    // Farmacia y Bioquímica
    'Farmacia y Bioquímica': [
      'Universidad Peruana Los Andes',
      'Universidad Privada de Huancayo Franklin Roosevelt',
      'Universidad Tecnológica del Perú',
    ],

    // Ingenierías
    'Ingeniería Ambiental': [
      'Universidad Continental',
      'Universidad Tecnológica del Perú',
    ],
    'Ingeniería Civil': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Tecnológica del Perú',
    ],
    'Ingeniería del Medio Ambiente': [
      'Universidad Peruana Los Andes',
    ],
    'Ingeniería de Minas': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
    ],
    'Ingeniería de Sistemas': [
      'Universidad Nacional del Centro del Perú',
    ],
    'Ingeniería de Sistemas e Informática': [
      'Universidad Continental',
      'Universidad Tecnológica del Perú',
    ],
    'Ingeniería de Sistemas y Computación': [
      'Universidad Peruana Los Andes',
    ],
    'Ingeniería de Software': [
      'Universidad Tecnológica del Perú',
    ],
    'Ingeniería Eléctrica': [
      'Universidad Continental',
    ],
    'Ingeniería Eléctrica y Electrónica': [
      'Universidad Nacional del Centro del Perú',
    ],
    'Ingeniería Industrial': [
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Tecnológica del Perú',
    ],
    'Ingeniería Mecánica': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
    ],
    'Ingeniería Mecatrónica': [
      'Universidad Continental',
    ],
    'Ingeniería Metalúrgica y de Materiales': [
      'Universidad Nacional del Centro del Perú',
    ],
    'Ingeniería Química': [
      'Universidad Nacional del Centro del Perú',
    ],

    // Medicina Humana
    'Medicina Humana': [
      'Universidad Nacional del Centro del Perú',
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Privada de Huancayo Franklin Roosevelt',
    ],

    // Medicina Veterinaria y Zootecnia
    'Medicina Veterinaria y Zootecnia': [
      'Universidad Peruana Los Andes',
    ],

    // Nutrición
    'Nutrición Humana': [
      'Universidad Peruana Los Andes',
    ],
    'Nutrición y Dietética': [
      'Universidad Tecnológica del Perú',
    ],

    // Obstetricia
    'Obstetricia': [
      'Universidad Peruana Los Andes',
      'Universidad Privada de Huancayo Franklin Roosevelt',
      'Universidad Tecnológica del Perú',
    ],

    // Odontología
    'Odontología': [
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Tecnológica del Perú',
    ],

    // Optometría
    'Optometría': [
      'Universidad Peruana Los Andes',
    ],

    // Psicología
    'Psicología': [
      'Universidad Continental',
      'Universidad Peruana Los Andes',
      'Universidad Privada de Huancayo Franklin Roosevelt',
      'Universidad Tecnológica del Perú',
    ],

    // Radiología
    'Radiología': [
      'Universidad Peruana Los Andes',
    ],

    // Sociología
    'Sociología': [
      'Universidad Nacional del Centro del Perú',
    ],

    // Tecnología Médica
    'Tecnología Médica – Laboratorio Clínico y Anatomía Patológica': [
      'Universidad Peruana Los Andes',
    ],
    'Tecnología Médica': [
      'Universidad Continental',
    ],
    'Tecnología Médica – Terapia Física y Rehabilitación': [
      'Universidad Peruana Los Andes',
      'Universidad Tecnológica del Perú',
    ],

    // Terapia Física
    'Terapia Física': [
      'Universidad Tecnológica del Perú',
    ],

    // Trabajo Social
    'Trabajo Social': [
      'Universidad Nacional del Centro del Perú',
    ],

    // Zootecnia
    'Zootecnia': [
      'Universidad Nacional del Centro del Perú',
    ],

    // CARRERAS TÉCNICAS (Institutos) - 3 años

    // Administración Técnica
    'Administración de Empresas (Técnica)': [
      'Instituto de Educación Superior Privado Continental',
    ],
    'Administración de Negocios Bancarios y Financieros': [
      'Instituto de Educación Superior Privado Continental',
      'Tecnológico InterAmericano',
    ],
    'Asistencia Administrativa': [
      'Instituto de Educación Superior Privado Santa Lucía',
    ],
    'Gestión Administrativa': [
      'Tecnológico InterAmericano',
      'Instituto de Educación Superior Privado Eugenio Paccelly',
    ],

    // Construcción
    'Construcción Civil': [
      'Tecnológico InterAmericano',
    ],
    'Gestión de la Construcción': [
      'Instituto de Educación Superior Privado Continental',
    ],

    // Contabilidad Técnica
    'Contabilidad (Técnica)': [
      'Instituto de Educación Superior Privado Continental',
      'Tecnológico InterAmericano',
      'Instituto de Educación Superior Privado Eugenio Paccelly',
      'Instituto de Educación Superior Privado San Pedro',
    ],

    // Diseño Técnico
    'Desarrollo de Sistemas de Información': [
      'Instituto de Educación Superior Privado Continental',
    ],
    'Diseño de Interiores (Técnico)': [
      'Instituto de Educación Superior Privado Continental',
    ],
    'Diseño de Modas': [
      'Instituto de Educación Superior Privado Continental',
    ],
    'Diseño Gráfico Publicitario': [
      'Instituto de Educación Superior Privado Continental',
    ],
    'Diseño y Programación Web': [
      'Tecnológico InterAmericano',
    ],

    // Electricidad
    'Electricidad Industrial': [
      'Tecnológico InterAmericano',
    ],

    // Enfermería Técnica
    'Enfermería Técnica': [
      'Tecnológico InterAmericano',
      'Instituto de Educación Superior Privado Eugenio Paccelly',
      'Instituto de Educación Superior Privado Santa Lucía',
    ],

    // Farmacia Técnica
    'Farmacia Técnica': [
      'Tecnológico InterAmericano',
      'Instituto de Educación Superior Privado Eugenio Paccelly',
      'Instituto de Educación Superior Privado Santa Lucía',
    ],

    // Gastronomía
    'Gastronomía': [
      'Instituto de Educación Superior Privado Continental',
      'Instituto de Educación Superior Privado San Pedro',
    ],

    // Logística
    'Gestión Logística': [
      'Tecnológico InterAmericano',
    ],

    // Maquinaria Pesada
    'Mantenimiento de Maquinaria Pesada': [
      'Tecnológico InterAmericano',
    ],
  };

  /// Imagen de portada para la sección
  final String portadaUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNk36T7u7lENmD4aoqAFegEamUZZ2-T6r-cjv8PArqrmI3jHz7Mk3rvHFZZVzyrG5knn2A-F-Q0TWYqEfHR9PB6fd68Xg-7EpmmeVaMJxc3KI6-iMri7RSRNg9gEWJ8ZbjpQQiATozleAALpByuNVRhGzrvHpXvivZgWJb9per37GnMsf7JUOKDJ6P6A23PY0K0j6XNQ8KsGgcUuAmRYg59p2x092FXGxOOOEnSBeb7NtJMvuItlUfMC59n93PQgwRUX5r3vU85y8';

  /// Lista filtrada de instituciones (se actualiza según la carrera seleccionada)
  List<Institucion> instituciones = [];

  /// Filtra las instituciones según la carrera seleccionada
  void filtrarInstitucionesPorCarrera(String nombreCarrera) {
    final nombresInstituciones = _carrerasInstituciones[nombreCarrera] ?? [];
    instituciones = nombresInstituciones
        .map((nombre) => _todasInstituciones[nombre])
        .where((inst) => inst != null)
        .cast<Institucion>()
        .toList();
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Obtiene el número de instituciones
  int getInstitucionesCount() {
    return instituciones.length;
  }
}
