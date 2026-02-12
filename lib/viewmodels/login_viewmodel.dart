import 'package:flutter/foundation.dart';
import '../models/auth_model.dart';

/// ViewModel para la pantalla de login.
///
/// Según MVVM, los ViewModels contienen lógica de presentación y
/// comunicación entre Models y Views. Este ViewModel maneja la lógica
/// de autenticación y notifica a la vista sobre cambios de estado.
class LoginViewModel with ChangeNotifier {
  final AuthModel _authModel = AuthModel();

  String _email = '';
  String _password = '';
  String _errorMessage = '';
  final bool _isLoading = false;
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

  /// Intenta iniciar sesión con las credenciales actuales
  /// Retorna true si la autenticación fue exitosa
  bool login() {
    if (_email.isEmpty || _password.isEmpty) {
      _errorMessage = 'Por favor completa todos los campos';
      notifyListeners();
      return false;
    }

    final result = _authModel.validateCredentials(_email, _password);

    if (result.isSuccess) {
      _errorMessage = '';
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.errorMessage ?? 'Error desconocido';
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
