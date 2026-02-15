import 'package:flutter/material.dart';
import '../viewmodels/viewmodels.dart';
import 'views.dart';

class PantallaOfertaEducativa extends StatefulWidget {
  final String carrera;

  const PantallaOfertaEducativa({
    super.key,
    required this.carrera,
  });

  @override
  State<PantallaOfertaEducativa> createState() =>
      _PantallaOfertaEducativaState();
}

class _PantallaOfertaEducativaState
    extends State<PantallaOfertaEducativa> {
  final OfertaEducativaViewModel _viewModel = OfertaEducativaViewModel();

  @override
  void initState() {
    super.initState();
    // Filtrar instituciones según la carrera seleccionada
    _viewModel.filtrarInstitucionesPorCarrera(widget.carrera);
  }

  void _navigateToTab(int index) {
    if (index == _viewModel.selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaPerfil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: const Color(0xFF121617),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Oferta Educativa',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Instituciones donde estudiar',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF121617),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.carrera,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1B7298),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(_viewModel.portadaUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._viewModel.instituciones.map((institucion) {
                      return _construirItemInstitucion(
                        institucion: institucion,
                      );
                    }),
                  ],
                ),
              ),
            ),
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
                  _buildNavButton(0, Icons.home, 'Inicio'),
                  _buildNavButton(1, Icons.list, 'Tests'),
                  _buildNavButton(2, Icons.bar_chart, 'Resultados'),
                  _buildNavButton(3, Icons.work, 'Carreras'),
                  _buildNavButton(4, Icons.person, 'Perfil'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirItemInstitucion({
    required Institucion institucion,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE2E5)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(institucion.imagenUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getTipoColor(institucion.tipo).withAlpha(25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    institucion.tipo,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _getTipoColor(institucion.tipo),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  institucion.nombre,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF121617),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF657C86),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        institucion.direccion,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF657C86),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTipoColor(String tipo) {
    if (tipo.contains('Pública')) {
      return const Color(0xFF22C55E); // Verde para públicas
    } else if (tipo.contains('Privada')) {
      return const Color(0xFF0052FF); // Azul para privadas
    } else {
      return const Color(0xFFF59E0B); // Amarillo para institutos
    }
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _viewModel.selectedIndex == index;

    return GestureDetector(
      onTap: () => _navigateToTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFF0052FF) : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF637D88),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color:
                  isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
