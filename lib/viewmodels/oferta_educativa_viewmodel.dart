import 'package:flutter/foundation.dart';

/// Modelo de datos para una institución educativa
class Institucion {
  final String nombre;
  final String direccion;
  final String imagenUrl;

  const Institucion({
    required this.nombre,
    required this.direccion,
    required this.imagenUrl,
  });
}

/// ViewModel para la pantalla de oferta educativa.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para la oferta educativa y notifica cambios a la vista.
class OfertaEducativaViewModel with ChangeNotifier {
  int _selectedIndex = 3;

  int get selectedIndex => _selectedIndex;

  /// Lista de instituciones educativas
  final List<Institucion> instituciones = const [
    Institucion(
      nombre: 'Universidad Nacional del Centro del Perú',
      direccion: 'Av. Los Incas 123, Huancayo',
      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
    ),
    Institucion(
      nombre: 'Instituto Tecnológico Superior de Tarma',
      direccion: 'Jr. Libertad 456, Tarma',
      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
    ),
    Institucion(
      nombre: 'Instituto Pedagógico de Jauja',
      direccion: 'Calle Real 789, Jauja',
      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC4j-dII-gv7elTzFwt9R7rcz_Ga_AR3X56w3eGs-Fwi5SbfCz4bvZJ2ELfSCt827MTnIGJ_xfsqW7F30kw0JJmciQeoKcmOvDKhzukO-cDWR_ZLR0T7lo8AbqcGy2taYMxAVWrMytq-u8x-1jbhUaYNI5TzWMsVT4awalZU4cYnfnsh_reJsJzlwIdSehn6cpLeNytQDZw920bw5Mssr1aNkURc-zYd4dFUi-fbOItPHa_TheKT5hhL8LOvIYg2jOT-PyGrJpH4owU',
    ),
  ];

  /// Imagen de portada para la sección
  final String portadaUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNk36T7u7lENmD4aoqAFegEamUZZ2-T6r-cjv8PArqrmI3jHz7Mk3rvHFZZVzyrG5knn2A-F-Q0TWYqEfHR9PB6fd68Xg-7EpmmeVaMJxc3KI6-iMri7RSRNg9gEWJ8ZbjpQQiATozleAALpByuNVRhGzrvHpXvivZgWJb9per37GnMsf7JUOKDJ6P6A23PY0K0j6XNQ8KsGgcUuAmRYg59p2x092FXGxOOOEnSBeb7NtJMvuItlUfMC59n93PQgwRUX5r3vU85y8';

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Obtiene el número de instituciones
  int getInstitucionesCount() {
    return instituciones.length;
  }
}
