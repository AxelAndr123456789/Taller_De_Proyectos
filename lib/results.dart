import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stitch Career',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Epilogue',
        useMaterial3: true,
      ),
      home: const PantallaResultados(),
    );
  }
}

class PantallaResultados extends StatelessWidget {
  const PantallaResultados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Encabezado con botón de regresar
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: const Color(0xFF121716),
                        onPressed: () {
                          // Sin funcionalidad por ahora
                        },
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Resultados',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF121716),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Espacio para centrar
                  ],
                ),
              ),

              // Banner principal con imagen
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBi3by901MHaPUhDeQe8c2l33TPaA4BVQIDtTwrutvdkLzEi3ggkLOdSTpP9UXuluWpF0RassK3F9aJSrNTxiQ5v-wYKy3cNamdUwYU5lKB2mPXnDyadHJUEUTDQFyxkOdqexO5GKq9wXoeP39KTCGRrMa8J_x_8er5sFc2FpdJxMlMomwbax6bXhvsOwrrwbNtxehNC3alPmrlT_ErohxhQb80G99BfVcrrJXL_y0Hh5rZm7kp1iUX8_7eWOBisyeTRZKyiI2Ff7KX',
                      ),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      stops: const [0, 0.25],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '¡Tu Perfil Vocacional está Listo!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Tarjeta de perfil
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuC4Sc1bc4CvdU7mMDBpMbvqpFrv4wHT-mhJWweIiQYS9u99ymMp0phZ1rx_TcDcFPV2GXu3_YiPdYmS1tnPM2AEtX91vO3N25CCnd6SdMWt1VYEDIG7rNVJiAWKOLX2RSvGR_BdumPH9PpmPmN73EgstpnmpqCGUOnDnFLQJcwTiMpYAEVdSYZecqwgbTlGzqwG1ZEg9zecnrYohX94yonOfsTQS0qCwH-Z_lPWVf6Uok75GUIajJYOd57VpzJM_9rsg10dKZrVZGJO',
                      ),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      stops: const [0, 1],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'El Creador Analítico',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Te destacas en roles que requieren una combinación de pensamiento lógico y resolución creativa de problemas...',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Título: Desglose del Perfil
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Desglose del Perfil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121716),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Tarjetas de porcentajes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Intereses
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCE5E3)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Intereses',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF121716),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '85%',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF121716),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Aptitudes
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCE5E3)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aptitudes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF121716),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '92%',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF121716),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Personalidad
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCE5E3)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personalidad',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF121716),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '78%',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF121716),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Título: Top Recomendaciones de Carreras
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Top Recomendaciones de Carreras',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121716),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Lista de carreras recomendadas
              Column(
                children: [
                  _construirItemCarrera(
                    icono: Icons.code,
                    titulo: 'Ingeniería de Software',
                    coincidencia: '95% Coincidencia',
                  ),
                  _construirItemCarrera(
                    icono: Icons.edit,
                    titulo: 'Diseño Digital',
                    coincidencia: '92% Coincidencia',
                  ),
                  _construirItemCarrera(
                    icono: Icons.timeline,
                    titulo: 'Ciencia de Datos',
                    coincidencia: '88% Coincidencia',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Botón Explorar Carreras
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Sin funcionalidad por ahora
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C3A8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Explorar Carreras',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF121716),
                      ),
                    ),
                  ),
                ),
              ),

              // Barra de navegación inferior
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFF0F4F3)),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _construirBotonNavegacion(Icons.home_outlined, 'Inicio', estaSeleccionado: false),
                    _construirBotonNavegacion(Icons.checklist, 'Tests', estaSeleccionado: true),
                    _construirBotonNavegacion(Icons.bar_chart_outlined, 'Resultados', estaSeleccionado: false),
                    _construirBotonNavegacion(Icons.work_outline, 'Carreras', estaSeleccionado: false),
                    _construirBotonNavegacion(Icons.person_outline, 'Perfil', estaSeleccionado: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirItemCarrera({
    required IconData icono,
    required String titulo,
    required String coincidencia,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 72,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF0F4F3),
            ),
            child: Icon(
              icono,
              color: const Color(0xFF121716),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF121716),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  coincidencia,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF658680),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirBotonNavegacion(IconData icono, String etiqueta, {bool estaSeleccionado = false}) {
    return GestureDetector(
      onTap: () {
        // Sin funcionalidad por ahora
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: estaSeleccionado ? const Color(0xFF121716).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icono,
              color: estaSeleccionado ? const Color(0xFF121716) : const Color(0xFF658680),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            etiqueta,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: estaSeleccionado ? const Color(0xFF121716) : const Color(0xFF658680),
            ),
          ),
        ],
      ),
    );
  }
}