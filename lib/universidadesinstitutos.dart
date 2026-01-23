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
      home: const PantallaOfertaEducativa(),
    );
  }
}

class PantallaOfertaEducativa extends StatelessWidget {
  const PantallaOfertaEducativa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                        'Oferta Educativa Regional',
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

            // Título: Universidades e Institutos
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Universidades e Institutos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121617),
                  ),
                ),
              ),
            ),

            // Imagen principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNk36T7u7lENmD4aoqAFegEamUZZ2-T6r-cjv8PArqrmI3jHz7Mk3rvHFZZVzyrG5knn2A-F-Q0TWYqEfHR9PB6fd68Xg-7EpmmeVaMJxc3KI6-iMri7RSRNg9gEWJ8ZbjpQQiATozleAALpByuNVRhGzrvHpXvivZgWJb9per37GnMsf7JUOKDJ6P6A23PY0K0j6XNQ8KsGgcUuAmRYg59p2x092FXGxOOOEnSBeb7NtJMvuItlUfMC59n93PQgwRUX5r3vU85y8',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Lista de instituciones
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _construirItemInstitucion(
                      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
                      nombre: 'Universidad Nacional del Centro del Perú',
                      direccion: 'Av. Los Incas 123, Huancayo',
                    ),
                    _construirItemInstitucion(
                      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
                      nombre: 'Instituto Tecnológico Superior de Tarma',
                      direccion: 'Jr. Libertad 456, Tarma',
                    ),
                    _construirItemInstitucion(
                      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC4j-dII-gv7elTzFwt9R7rcz_Ga_AR3X56w3eGs-Fwi5SbfCz4bvZJ2ELfSCt827MTnIGJ_xfsqW7F30kw0JJmciQeoKcmOvDKhzukO-cDWR_ZLR0T7lo8AbqcGy2taYMxAVWrMytq-u8x-1jbhUaYNI5TzWMsVT4awalZU4cYnfnsh_reJsJzlwIdSehn6cpLeNytQDZw920bw5Mssr1aNkURc-zYd4dFUi-fbOItPHa_TheKT5hhL8LOvIYg2jOT-PyGrJpH4owU',
                      nombre: 'Instituto Pedagógico de Jauja',
                      direccion: 'Calle Real 789, Jauja',
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
                  _construirBotonNavegacion(Icons.emoji_events_outlined, 'Resultados', estaSeleccionado: false),
                  _construirBotonNavegacion(Icons.work_outline, 'Carreras', estaSeleccionado: true),
                  _construirBotonNavegacion(Icons.person_outline, 'Perfil', estaSeleccionado: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirItemInstitucion({
    required String imagenUrl,
    required String nombre,
    required String direccion,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 72,
      child: Row(
        children: [
          // Logo de la institución
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imagenUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Información de la institución
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF121617),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  direccion,
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