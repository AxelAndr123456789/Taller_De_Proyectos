import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stitch Career',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Epilogue',
        useMaterial3: true,
      ),
      home: const PantallaHistorialEvaluaciones(),
    );
  }
}

class PantallaHistorialEvaluaciones extends StatelessWidget {
  const PantallaHistorialEvaluaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado centrado sin botón de retroceso
            Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  'Historial de Evaluaciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121617),
                  ),
                ),
              ),
            ),

            // Título: Evaluaciones Completadas
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Evaluaciones Completadas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121617),
                  ),
                ),
              ),
            ),

            // Lista de evaluaciones
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _construirItemEvaluacion(
                      titulo: 'Test Vocacional 1',
                      perfilPrincipal: 'Perfil Principal: Ingeniería',
                    ),
                    _construirItemEvaluacion(
                      titulo: 'Test Vocacional 2',
                      perfilPrincipal: 'Perfil Principal: Medicina',
                    ),
                    _construirItemEvaluacion(
                      titulo: 'Test Vocacional 3',
                      perfilPrincipal: 'Perfil Principal: Artes',
                    ),
                  ],
                ),
              ),
            ),

            // Barra de navegación inferior
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF0F3F4)),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _construirBotonNavegacion(Icons.home_outlined, 'Inicio', estaSeleccionado: false),
                  _construirBotonNavegacion(Icons.checklist, 'Tests', estaSeleccionado: false),
                  _construirBotonNavegacion(Icons.bar_chart_outlined, 'Resultados', estaSeleccionado: true),
                  _construirBotonNavegacion(Icons.work_outline, 'Carreras', estaSeleccionado: false),
                  _construirBotonNavegacion(Icons.person_outline, 'Perfil', estaSeleccionado: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirItemEvaluacion({
    required String titulo,
    required String perfilPrincipal,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Información de la evaluación
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
                    color: Color(0xFF121617),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  perfilPrincipal,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF657C86),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Botón Ver Resultados
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: () {
                // Sin funcionalidad por ahora
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0F3F4),
                foregroundColor: const Color(0xFF121617),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text(
                'Ver Resultados',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
              color: estaSeleccionado ? const Color(0xFF121617).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icono,
              color: estaSeleccionado ? const Color(0xFF121617) : const Color(0xFF657C86),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            etiqueta,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: estaSeleccionado ? const Color(0xFF121617) : const Color(0xFF657C86),
            ),
          ),
        ],
      ),
    );
  }
}