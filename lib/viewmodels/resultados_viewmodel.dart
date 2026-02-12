import 'package:flutter/foundation.dart';

/// ViewModel para la pantalla de resultados vocacionales.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para los resultados de los tests y notifica cambios a la vista.
class ResultadosViewModel with ChangeNotifier {
  /// Perfil vocacional del usuario
  final String perfilVocacional = 'El Creador Analítico';

  /// Descripción del perfil
  final String descripcionPerfil =
      'Te destacas en roles que requieren una combinación de pensamiento lógico y resolución creativa de problemas.';

  /// Imagen de portada del resultado
  final String portadaUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBi3by901MHaPUhDeQe8c2l33TPaA4BVQIDtTwrutvdkLzEi3ggkLOdSTpP9UXuluWpF0RassK3F9aJSrNTxiQ5v-wYKy3cNamdUwYU5lKB2mPXnDyadHJUEUTDQFyxkOdqexO5GKq9wXoeP39KTCGRrMa8J_x_8er5sFc2FpdJxMlMomwbax6bXhvsOwrrwbNtxehNC3alPmrlT_ErohxhQb80G99BfVcrrJXL_y0Hh5rZm7kp1iUX8_7eWOBisyeTRZKyiI2Ff7KX';

  /// Imagen del personaje/ilustración
  final String imagenPersonaje =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuC4Sc1bc4CvdU7mMDBpMbvqpFrv4wHT-mhJWweIiQYS9u99ymMp0phZ1rx_TcDcFPV2GXu3_YiPdYmS1tnPM2AEtX91vO3N25CCnd6SdMWt1VYEDIG7rNVJiAWKOLX2RSvGR_BdumPH9PpmPmN73EgstpnmpqCGUOnDnFLQJcwTiMpYAEVdSYZecqwgbTlGzqwG1ZEg9zecnrYohX94yonOfsTQS0qCwH-Z_lPWVf6Uok75GUIajJYOd57VpzJM_9rsg10dKZrVZGJO';

  /// Título del mensaje de éxito
  final String tituloMensaje = '¡Tu Perfil Vocacional está Listo!';

  /// Obtiene el título del perfil
  String getTituloPerfil() {
    return perfilVocacional;
  }

  /// Obtiene la descripción del perfil
  String getDescripcionPerfil() {
    return descripcionPerfil;
  }
}
