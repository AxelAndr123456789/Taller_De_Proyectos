import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import 'encryption_service.dart';

/// Servicio para manejar las operaciones con Firebase Firestore
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  
  factory FirebaseService() {
    return _instance;
  }
  
  FirebaseService._internal();

  FirebaseFirestore? _firestore;
  final EncryptionService _encryptionService = EncryptionService();
  
  /// Inicializa Firestore
  FirebaseFirestore get firestore {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }
  
  /// Colección de usuarios en Firestore
  CollectionReference get _usuariosCollection => firestore.collection('usuarios');

  /// Verifica si Firestore está conectado
  Future<bool> verificarConexion() async {
    try {
      await _usuariosCollection.limit(1).get();
      debugPrint('Conexión a Firestore exitosa');
      return true;
    } catch (e) {
      debugPrint('Error de conexión a Firestore: $e');
      return false;
    }
  }

  /// Registra un nuevo usuario en Firestore
  /// Retorna true si el registro fue exitoso
  Future<bool> registerUser(UserModel user) async {
    try {
      debugPrint('Intentando registrar usuario: ${user.email}');
      
      // Verificar conexión primero
      final conectado = await verificarConexion();
      if (!conectado) {
        debugPrint('No hay conexión a Firestore');
        return false;
      }
      
      // Verificar si el correo ya existe
      debugPrint('Verificando si el email existe...');
      final querySnapshot = await _usuariosCollection
          .where('correo', isEqualTo: user.email)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint('El correo ya está registrado: ${user.email}');
        return false; // El correo ya está registrado
      }

      debugPrint('Creando documento en Firestore...');
      // Encriptar la contraseña antes de guardar
      final passwordToEncrypt = user.password ?? '';
      final encryptedPassword = _encryptionService.encryptPassword(passwordToEncrypt);
      debugPrint('Contraseña encriptada: $encryptedPassword');
      
      // Crear documento con los datos del usuario (sin fechaRegistro ni rol)
      final docRef = await _usuariosCollection.add({
        'Nombre Completo': user.nombreCompleto,
        'correo': user.email,
        'telefono': user.telefono,
        'colegio': user.colegio,
        'grado': user.grado,
        'contraseña': encryptedPassword,
      });
      
      debugPrint('Usuario registrado con ID: ${docRef.id}');
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error al registrar usuario: $e');
      debugPrint('Stack trace: $stackTrace');
      return false;
    }
  }

  /// Valida las credenciales del usuario contra Firestore
  /// Retorna el UserModel si las credenciales son válidas, null si no
  Future<UserModel?> validateCredentials(String email, String password) async {
    try {
      debugPrint('Intentando login para: $email');
      
      // Verificar conexión primero
      final conectado = await verificarConexion();
      if (!conectado) {
        debugPrint('No hay conexión a Firestore');
        return null;
      }
      
      // Buscar solo por correo (evita índice compuesto)
      debugPrint('Buscando usuario por email...');
      final querySnapshot = await _usuariosCollection
          .where('correo', isEqualTo: email)
          .get();

      debugPrint('Documentos encontrados: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isEmpty) {
        debugPrint('Usuario no encontrado: $email');
        return null; // Usuario no encontrado
      }

      // Obtener el primer documento (debería ser único por correo)
      final doc = querySnapshot.docs.first;
      final data = doc.data() as Map<String, dynamic>;

      debugPrint('Datos del usuario encontrado: $data');

      // Verificar contraseña localmente (encriptar la ingresada para comparar)
      final storedPassword = data['contraseña'] ?? '';
      final encryptedInputPassword = _encryptionService.encryptPassword(password);
      
      debugPrint('Contraseña almacenada (encriptada): $storedPassword');
      debugPrint('Contraseña ingresada (encriptada): $encryptedInputPassword');
      
      if (!_encryptionService.verifyPassword(password, storedPassword)) {
        debugPrint('Contraseña incorrecta para: $email');
        return null;
      }

      debugPrint('Login exitoso para: $email');

      // Crear y retornar el modelo de usuario
      return UserModel(
        nombreCompleto: data['Nombre Completo'] ?? '',
        email: data['correo'] ?? '',
        telefono: data['telefono'] ?? '',
        colegio: data['colegio'] ?? '',
        grado: data['grado'] ?? '',
        rol: data['rol'] ?? 'Estudiante',
        password: data['contraseña'] ?? '',
      );
    } catch (e, stackTrace) {
      debugPrint('Error al validar credenciales: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  /// Verifica si un correo electrónico ya está registrado
  Future<bool> isEmailRegistered(String email) async {
    try {
      final querySnapshot = await _usuariosCollection
          .where('correo', isEqualTo: email)
          .get();
      
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('Error al verificar email: $e');
      return false;
    }
  }

  /// Obtiene todos los usuarios (solo para debugging)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final querySnapshot = await _usuariosCollection.get();
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      debugPrint('Error al obtener usuarios: $e');
      return [];
    }
  }

  /// Colección de resultados en Firestore
  CollectionReference get _resultadosCollection => firestore.collection('resultados');

  /// Guarda el resultado del test vocacional en Firestore
  /// Retorna true si se guardó exitosamente
  Future<bool> guardarResultadoTest({
    required String userEmail,
    required String nombreCompleto,
    required String carreraRecomendada,
    required String areaPrincipal,
    Map<String, dynamic>? porcentajesTest,
    List<String>? carrerasAfines,
  }) async {
    try {
      debugPrint('Guardando resultado para: $nombreCompleto - Carrera: $carreraRecomendada');
      
      // Verificar conexión primero
      final conectado = await verificarConexion();
      if (!conectado) {
        debugPrint('No hay conexión a Firestore');
        return false;
      }

      // Crear documento con los datos del resultado
      final docRef = await _resultadosCollection.add({
        'userEmail': userEmail,
        'nombreCompleto': nombreCompleto,
        'respuesta': carreraRecomendada,
        'areaPrincipal': areaPrincipal,
        'porcentajesTest': porcentajesTest,
        'carrerasAfines': carrerasAfines,
        'fecha': DateTime.now().toIso8601String(),
      });
      
      debugPrint('Resultado guardado con ID: ${docRef.id}');
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error al guardar resultado: $e');
      debugPrint('Stack trace: $stackTrace');
      return false;
    }
  }

  /// Obtiene todos los resultados de un usuario específico
  Future<List<Map<String, dynamic>>> getResultadosByUser(String userEmail) async {
    try {
      final querySnapshot = await _resultadosCollection
          .where('userEmail', isEqualTo: userEmail)
          .orderBy('fecha', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      debugPrint('Error al obtener resultados: $e');
      return [];
    }
  }
}
