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
      home: const PantallaDetallesCarrera(),
    );
  }
}

class PantallaDetallesCarrera extends StatelessWidget {
  const PantallaDetallesCarrera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Encabezado con botón de retroceso
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: const Color(0xFF121617),
                      onPressed: () {
                        // Sin funcionalidad por ahora
                      },
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Detalles de Carrera',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF121617),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Imagen de portada
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 218,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Título de la carrera
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ingeniero de Software',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121617),
                    ),
                  ),
                ),
              ),

              // Descripción
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Los ingenieros de software diseñan, desarrollan, prueban y mantienen aplicaciones y sistemas de software. Aplican principios de ingeniería para crear soluciones de software eficientes y confiables.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF121617),
                    height: 1.5,
                  ),
                ),
              ),

              // Título: Habilidades Requeridas
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Habilidades Requeridas',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121617),
                    ),
                  ),
                ),
              ),

              // Tarjetas de habilidades
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _construirTarjetaHabilidad(
                      icono: Icons.code,
                      titulo: 'Programación',
                    ),
                    const SizedBox(height: 12),
                    _construirTarjetaHabilidad(
                      icono: Icons.storage,
                      titulo: 'Gestión de Bases de Datos',
                    ),
                    const SizedBox(height: 12),
                    _construirTarjetaHabilidad(
                      icono: Icons.gite,
                      titulo: 'Control de Versiones',
                    ),
                  ],
                ),
              ),

              // Título: Duración
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Duración',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121617),
                    ),
                  ),
                ),
              ),

              // Descripción de duración
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Generalmente requiere una Licenciatura en Ciencias de la Computación o un campo relacionado, que toma aproximadamente 4 años completar.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF121617),
                    height: 1.5,
                  ),
                ),
              ),

              // Título: Mercado Laboral
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mercado Laboral',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121617),
                    ),
                  ),
                ),
              ),

              // Descripción del mercado laboral
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'El mercado laboral para ingenieros de software es robusto, con alta demanda en varias industrias. Las oportunidades van desde startups hasta grandes corporaciones, ofreciendo salarios competitivos y potencial de crecimiento.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF121617),
                    height: 1.5,
                  ),
                ),
              ),

              // Botón "Dónde estudiar"
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // Sin funcionalidad por ahora
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B7298),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Dónde estudiar',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Espacio para la barra de navegación
              const SizedBox(height: 20),

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
                    _construirBotonNavegacion(Icons.bar_chart_outlined, 'Resultados', estaSeleccionado: false),
                    _construirBotonNavegacion(Icons.work_outline, 'Carreras', estaSeleccionado: true),
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

  Widget _construirTarjetaHabilidad({
    required IconData icono,
    required String titulo,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE2E5)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            icono,
            color: const Color(0xFF121617),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF121617),
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