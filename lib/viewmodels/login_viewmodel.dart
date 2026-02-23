import 'package:flutter/foundation.dart';
import '../services/firebase_service.dart';
import '../models/user_manager.dart';

/// ViewModel para la pantalla de login.
///
/// Según MVVM, los ViewModels contienen lógica de presentación y
/// comunicación entre Models y Views. Este ViewModel maneja la lógica
/// de autenticación y notifica a la vista sobre cambios de estado.
class LoginViewModel with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final UserManager _userManager = UserManager();

  String _email = '';
  String _password = '';
  String _errorMessage = '';
  bool _isLoading = false;
  bool _showPassword = false;

  String get email => _email;
  String get password => _password;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get showPassword => _showPassword;

  /// Actualiza el correo electrónico
  void setEmail(String value) {
    _email = value;
    _errorMessage = ''; // Limpiar error cuando el usuario escribe
    notifyListeners();
  }

  /// Actualiza la contraseña
  void setPassword(String value) {
    _password = value;
    _errorMessage = ''; // Limpiar error cuando el usuario escribe
    notifyListeners();
  }

  /// Alterna la visibilidad de la contraseña
  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  /// Valida el correo electrónico
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }

    return null;
  }

  /// Valida la contraseña
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    return null;
  }

  /// Intenta iniciar sesión con las credenciales actuales desde Firestore
  /// Retorna true si la autenticación fue exitosa
  Future<bool> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      _errorMessage = 'Por favor completa todos los campos';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final user = await _firebaseService.validateCredentials(_email, _password);

      _isLoading = false;

      if (user != null) {
        // Guardar el usuario en el UserManager
        _userManager.registerUser(user);
        _errorMessage = '';
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Correo o contraseña incorrectos';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Error al iniciar sesión: $e';
      notifyListeners();
      return false;
    }
  }

  /// Obtiene el mensaje de ayuda para credenciales de demo
  String getDemoCredentialsMessage() {
    return 'Credenciales de demo: usuario@gmail.com y password123';
  }

  /// Limpia los campos del formulario
  void clear() {
    _email = '';
    _password = '';
    _errorMessage = '';
    _showPassword = false;
    notifyListeners();
  }
}
