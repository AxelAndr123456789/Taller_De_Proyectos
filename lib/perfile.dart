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
      home: const PantallaPerfil(),
    );
  }
}

class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Encabezado con botón de configuración
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Perfil',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF121617),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      color: const Color(0xFF121617),
                      onPressed: () {
                        // Sin funcionalidad por ahora
                      },
                    ),
                  ],
                ),
              ),

              // Información del usuario
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Foto de perfil
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBPTBIJNdkM_FxeGD-d_WZYusmK3wl0Xt3O5E5xlXMdvaZSZk_5guG-S6x3skyebN_lMGcdm6SFS-N6IEOkdVfwW9EgXfj4yvMyI8KSi9pBYpKpFWIGLSh8X04577DXHQeo-MCWvgdiy3EcQutd3-LPhHzZFFEFTB4VrOv6weEkVb9fcjkEKzN1lsxRowTEx8F1iaQlntYjVoufyOyOf2gXFGkpWfd1gfAsmDt_sKWR0DPptTOfj76jAZ-VF5UC7DDTEh0Yds_Fujct',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Nombre
                    const Text(
                      'Mateo Vargas',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF121617),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Ocupación
                    const Text(
                      'Estudiante',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF657C86),
                      ),
                    ),
                    // Ubicación
                    const Text(
                      'Junín, Perú',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF657C86),
                      ),
                    ),
                  ],
                ),
              ),

              // Título: Información Personal
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Información Personal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121617),
                    ),
                  ),
                ),
              ),

              // Email
              _construirItemInformacion(
                icono: Icons.email_outlined,
                titulo: 'Email',
                valor: 'mateo.vargas@email.com',
              ),

              // Teléfono
              _construirItemInformacion(
                icono: Icons.phone_outlined,
                titulo: 'Teléfono',
                valor: '+51 987 654 321',
              ),

              // Título: Información Académica
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Información Académica',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121617),
                    ),
                  ),
                ),
              ),

              // Colegio
              _construirItemInformacion(
                icono: Icons.school_outlined,
                titulo: 'Colegio',
                valor: 'Colegio Nacional San José',
              ),

              // Grado
              _construirItemInformacion(
                icono: Icons.menu_book_outlined,
                titulo: 'Grado',
                valor: '5to año de secundaria',
              ),

              // Botón Cerrar Sesión
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
                      backgroundColor: const Color(0xFFF0F3F4),
                      foregroundColor: const Color(0xFF121617),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                    _construirBotonNavegacion(Icons.work_outline, 'Carreras', estaSeleccionado: false),
                    _construirBotonNavegacion(Icons.person_outline, 'Perfil', estaSeleccionado: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirItemInformacion({
    required IconData icono,
    required String titulo,
    required String valor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 72,
      child: Row(
        children: [
          // Icono
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF0F3F4),
            ),
            child: Icon(
              icono,
              color: const Color(0xFF121617),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Información
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
                Text(
                  valor,
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