import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:crypto/crypto.dart';

/// Servicio para encriptar contraseñas usando SHA-256
class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();

  factory EncryptionService() {
    return _instance;
  }

  EncryptionService._internal();

  /// Obtiene la clave secreta desde variables de entorno
  String get _secretKey =>
      dotenv.env['ENCRYPTION_SECRET_KEY'] ?? 'StitchCareer2025SecureKey';

  /// Encripta una contraseña usando SHA-256 con sal
  String encryptPassword(String password) {
    // Combinar la contraseña con la clave secreta (sal)
    final saltedPassword = password + _secretKey;
    
    // Crear el hash SHA-256
    final bytes = utf8.encode(saltedPassword);
    final digest = sha256.convert(bytes);
    
    // Retornar el hash como string hexadecimal
    return digest.toString();
  }

  /// Verifica si una contraseña coincide con el hash almacenado
  bool verifyPassword(String password, String hashedPassword) {
    final encryptedInput = encryptPassword(password);
    return encryptedInput == hashedPassword;
  }
}
