/// Modelo de autenticación que contiene las credenciales válidas
/// y la lógica de validación de usuarios.
///
/// Según MVVM, los Models contienen datos y lógica de negocio.
/// Este modelo encapsula la información de autenticación.
class AuthModel {
  static final AuthModel _instance = AuthModel._internal();

  factory AuthModel() {
    return _instance;
  }

  AuthModel._internal();

  final List<String> _validEmails = [
    'usuario@gmail.com',
    'correo@hotmail.com',
    'email@outlook.com',
    'test@yahoo.com',
    'admin@example.com'
  ];

  final String _validPassword = 'password123';

  /// Valida si el correo electrónico es válido
  bool isValidEmail(String email) {
    return _validEmails.contains(email.trim().toLowerCase());
  }

  /// Valida si la contraseña es correcta
  bool isValidPassword(String password) {
    return password == _validPassword;
  }

  /// Valida las credenciales del usuario
  /// Retorna un objeto AuthResult con el estado de la autenticación
  AuthResult validateCredentials(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return AuthResult(
        isSuccess: false,
        errorMessage: 'Por favor completa todos los campos',
      );
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return AuthResult(
        isSuccess: false,
        errorMessage: 'Por favor ingresa un correo electrónico válido',
      );
    }

    if (!isValidEmail(email)) {
      return AuthResult(
        isSuccess: false,
        errorMessage: 'Correo electrónico no autorizado',
      );
    }

    if (!isValidPassword(password)) {
      return AuthResult(
        isSuccess: false,
        errorMessage: 'Contraseña incorrecta',
      );
    }

    return AuthResult(
      isSuccess: true,
      errorMessage: null,
    );
  }
}

/// Resultado de la autenticación
class AuthResult {
  final bool isSuccess;
  final String? errorMessage;

  AuthResult({
    required this.isSuccess,
    this.errorMessage,
  });
}
