/// Modelo que representa los datos de un usuario
/// Contiene toda la información del perfil del usuario
class UserModel {
  String nombreCompleto;
  String email;
  String telefono;
  String colegio;
  String grado;
  String ubicacion;
  String rol;
  String? password; // Solo para registro, no se muestra en perfil

  UserModel({
    required this.nombreCompleto,
    required this.email,
    required this.telefono,
    required this.colegio,
    required this.grado,
    this.ubicacion = '',
    this.rol = 'Estudiante',
    this.password,
  });

  /// Crea un UserModel desde un mapa (para persistencia)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nombreCompleto: map['nombreCompleto'] ?? '',
      email: map['email'] ?? '',
      telefono: map['telefono'] ?? '',
      colegio: map['colegio'] ?? '',
      grado: map['grado'] ?? '',
      ubicacion: map['ubicacion'] ?? '',
      rol: map['rol'] ?? 'Estudiante',
      password: map['password'],
    );
  }

  /// Convierte el UserModel a un mapa (para persistencia)
  Map<String, dynamic> toMap() {
    return {
      'nombreCompleto': nombreCompleto,
      'email': email,
      'telefono': telefono,
      'colegio': colegio,
      'grado': grado,
      'ubicacion': ubicacion,
      'rol': rol,
      'password': password,
    };
  }

  /// Crea una copia del usuario con valores actualizados
  UserModel copyWith({
    String? nombreCompleto,
    String? email,
    String? telefono,
    String? colegio,
    String? grado,
    String? ubicacion,
    String? rol,
    String? password,
  }) {
    return UserModel(
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      colegio: colegio ?? this.colegio,
      grado: grado ?? this.grado,
      ubicacion: ubicacion ?? this.ubicacion,
      rol: rol ?? this.rol,
      password: password ?? this.password,
    );
  }
}
