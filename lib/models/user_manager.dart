import 'user_model.dart';

/// Manager singleton para manejar los datos del usuario actual
/// Mantiene la información del usuario registrado/logueado en toda la app
class UserManager {
  static final UserManager _instance = UserManager._internal();
  
  factory UserManager() {
    return _instance;
  }
  
  UserManager._internal();

  UserModel? _currentUser;
  bool _isLoggedIn = false;

  /// Usuario actualmente logueado
  UserModel? get currentUser => _currentUser;
  
  /// Indica si hay un usuario logueado
  bool get isLoggedIn => _isLoggedIn;

  /// Registra un nuevo usuario
  void registerUser(UserModel user) {
    _currentUser = user;
    _isLoggedIn = true;
  }

  /// Actualiza los datos del usuario actual
  void updateUser(UserModel user) {
    _currentUser = user;
  }

  /// Cierra la sesión del usuario
  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
  }

  /// Obtiene los datos del perfil para mostrar (sin contraseña)
  Map<String, String> getProfileData() {
    if (_currentUser == null) {
      return {};
    }
    
    return {
      'nombreCompleto': _currentUser!.nombreCompleto,
      'email': _currentUser!.email,
      'telefono': _currentUser!.telefono,
      'colegio': _currentUser!.colegio,
      'grado': _currentUser!.grado,
      'ubicacion': _currentUser!.ubicacion,
      'rol': _currentUser!.rol,
    };
  }
}
