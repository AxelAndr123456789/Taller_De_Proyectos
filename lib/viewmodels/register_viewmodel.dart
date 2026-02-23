import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/user_manager.dart';
import '../services/firebase_service.dart';

/// ViewModel para la pantalla de registro.
///
/// Según MVVM, los ViewModels contienen lógica de presentación y
/// comunicación entre Models y Views. Este ViewModel maneja la lógica
/// de registro de usuarios.
class RegisterViewModel with ChangeNotifier {
  final UserManager _userManager = UserManager();
  final FirebaseService _firebaseService = FirebaseService();

  // Datos del formulario
  String _nombreCompleto = '';
  String _email = '';
  String _telefono = '';
  String _colegio = '';
  String _grado = '';
  String _ubicacion = '';
  String _password = '';
  
  String _errorMessage = '';

  String get nombreCompleto => _nombreCompleto;
  String get email => _email;
  String get telefono => _telefono;
  String get colegio => _colegio;
  String get grado => _grado;
  String get ubicacion => _ubicacion;
  String get password => _password;
  String get errorMessage => _errorMessage;

  /// Actualiza el nombre completo
  void setNombreCompleto(String value) {
    _nombreCompleto = value;
    _errorMessage = '';
    notifyListeners();
  }

  /// Actualiza el email
  void setEmail(String value) {
    _email = value;
    _errorMessage = '';
    notifyListeners();
  }

  /// Actualiza el teléfono
  void setTelefono(String value) {
    _telefono = value;
    _errorMessage = '';
    notifyListeners();
  }

  /// Actualiza el colegio
  void setColegio(String value) {
    _colegio = value;
    _errorMessage = '';
    notifyListeners();
  }

  /// Actualiza el grado
  void setGrado(String value) {
    _grado = value;
    _errorMessage = '';
    notifyListeners();
  }

  /// Actualiza la ubicación
  void setUbicacion(String value) {
    _ubicacion = value;
    _errorMessage = '';
    notifyListeners();
  }

  /// Actualiza la contraseña
  void setPassword(String value) {
    _password = value;
    _errorMessage = '';
    notifyListeners();
  }

  /// Valida el email
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
      return 'Por favor ingresa una contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  /// Intenta registrar al usuario con los datos actuales en Firestore
  /// Retorna true si el registro fue exitoso
  Future<bool> register() async {
    // Validar que todos los campos estén completos (sin ubicación)
    if (_nombreCompleto.isEmpty ||
        _email.isEmpty ||
        _telefono.isEmpty ||
        _colegio.isEmpty ||
        _grado.isEmpty ||
        _password.isEmpty) {
      _errorMessage = 'Por favor completa todos los campos';
      notifyListeners();
      return false;
    }

    // Validar email
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(_email)) {
      _errorMessage = 'Por favor ingresa un correo electrónico válido';
      notifyListeners();
      return false;
    }

    // Validar contraseña
    if (_password.length < 6) {
      _errorMessage = 'La contraseña debe tener al menos 6 caracteres';
      notifyListeners();
      return false;
    }

    // Crear el modelo de usuario
    final user = UserModel(
      nombreCompleto: _nombreCompleto,
      email: _email,
      telefono: _telefono,
      colegio: _colegio,
      grado: _grado,
      ubicacion: '',
      rol: 'Estudiante',
      password: _password,
    );

    // Registrar el usuario en Firebase (incluye verificación de email duplicado)
    final success = await _firebaseService.registerUser(user);

    if (success) {
      // Registrar el usuario en el manager local
      _userManager.registerUser(user);
      _errorMessage = '';
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Error al registrar el usuario. Verifica tu conexión a internet o que el correo no esté registrado.';
      notifyListeners();
      return false;
    }
  }

  /// Limpia todos los campos del formulario
  void clear() {
    _nombreCompleto = '';
    _email = '';
    _telefono = '';
    _colegio = '';
    _grado = '';
    _ubicacion = '';
    _password = '';
    _errorMessage = '';
    notifyListeners();
  }
}
