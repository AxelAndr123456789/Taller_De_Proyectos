import 'package:flutter/foundation.dart';

/// Modelo de datos del usuario
class UserProfile {
  final String name;
  final String role;
  final String location;
  final String avatarUrl;

  const UserProfile({
    required this.name,
    required this.role,
    required this.location,
    required this.avatarUrl,
  });
}

/// ViewModel para la pantalla de perfil de usuario.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para el perfil del usuario y notifica cambios a la vista.
class ProfileViewModel with ChangeNotifier {
  final UserProfile _userProfile = const UserProfile(
    name: 'Mateo Vargas',
    role: 'Estudiante',
    location: 'Junín, Perú',
    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBPTBIJNdkM_FxeGD-d_WZYusmK3wl0Xt3O5E5xlXMdvaZSZk_5guG-S6x3skyebN_lMGcdm6SFS-N6IEOkdVfwW9EgXfj4yvMyI8KSi9pBYpKpFWIGLSh8X04577DXHQeo-MCWvgdiy3EcQutd3-LPhHzZFFEFTB4VrOv6weEkVb9fcjkEKzN1lsxRowTEx8F1iaQlntYjVoufyOyOf2gXFGkpWfd1gfAsmDt_sKWR0DPptTOfj76jAZ-VF5UC7DDTEh0Yds_Fujct',
  );

  int _selectedIndex = 4;

  UserProfile get userProfile => _userProfile;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Obtiene la información personal del usuario
  List<PersonalInfoItem> getPersonalInfo() {
    return [
      PersonalInfoItem(
        title: 'Información de Contacto',
        items: [
          InfoItem(label: 'Correo electrónico', value: 'mateo.vargas@email.com'),
          InfoItem(label: 'Teléfono', value: '+51 987 654 321'),
        ],
      ),
      PersonalInfoItem(
        title: 'Información Académica',
        items: [
          InfoItem(label: 'Nivel educativo', value: 'Secundaria completa'),
          InfoItem(label: 'Institución', value: 'I.E. San José'),
        ],
      ),
    ];
  }
}

/// Elemento de información personal
class PersonalInfoItem {
  final String title;
  final List<InfoItem> items;

  PersonalInfoItem({
    required this.title,
    required this.items,
  });
}

/// Elemento de información individual
class InfoItem {
  final String label;
  final String value;

  InfoItem({
    required this.label,
    required this.value,
  });
}
