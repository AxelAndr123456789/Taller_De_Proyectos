import 'package:flutter/material.dart';
import '../viewmodels/viewmodels.dart';
import 'views.dart';

class PantallaResultados extends StatefulWidget {
  const PantallaResultados({super.key});

  @override
  State<PantallaResultados> createState() => _PantallaResultadosState();
}

class _PantallaResultadosState extends State<PantallaResultados> {
  final ResultadosViewModel _viewModel = ResultadosViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PantallaHistorialEvaluaciones()),
                          );
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
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFF5F5F5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            _viewModel.tituloMensaje,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12)),
                            image: DecorationImage(
                              image: NetworkImage(_viewModel.portadaUrl),
                              fit: BoxFit.contain,
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Carrera Recomendada Centrada
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        _viewModel.carreraRecomendada,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _viewModel.descripcionCarrera,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Imagen de la Carrera
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(_viewModel.imagenCarrera),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCE5E3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Intereses',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF121716),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_viewModel.getPorcentajeIntereses()}%',
                              style: const TextStyle(
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCE5E3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Aptitudes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF121716),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_viewModel.getPorcentajeAptitudes()}%',
                              style: const TextStyle(
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCE5E3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Personalidad',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF121716),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_viewModel.getPorcentajePersonalidad()}%',
                              style: const TextStyle(
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
              _buildCareerRecommendations(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PantallaRecomendacionesCarreras()),
                      );
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
                    _construirBotonNavegacion(context, Icons.home_outlined, 'Inicio',
                        estaSeleccionado: false),
                    _construirBotonNavegacion(context, Icons.checklist, 'Tests',
                        estaSeleccionado: true),
                    _construirBotonNavegacion(
                        context, Icons.bar_chart_outlined, 'Resultados',
                        estaSeleccionado: false),
                    _construirBotonNavegacion(context, Icons.work_outline, 'Carreras',
                        estaSeleccionado: false),
                    _construirBotonNavegacion(context, Icons.person_outline, 'Perfil',
                        estaSeleccionado: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareerRecommendations() {
    final carreras = _viewModel.getCarrerasAfines();
    
    if (carreras.isEmpty) {
      // Mostrar carreras por defecto si no hay datos
      return Column(
        children: [
          _construirItemCarrera(
            icono: Icons.code,
            titulo: 'Ingeniería de Software',
          ),
          _construirItemCarrera(
            icono: Icons.edit,
            titulo: 'Diseño Digital',
          ),
          _construirItemCarrera(
            icono: Icons.timeline,
            titulo: 'Ciencia de Datos',
          ),
        ],
      );
    }
    
    // Tomar las primeras 3 carreras afines
    final topCarreras = carreras.take(3).toList();
    final iconos = [Icons.code, Icons.edit, Icons.timeline, 
                    Icons.business, Icons.healing, Icons.engineering];
    
    return Column(
      children: topCarreras.asMap().entries.map((entry) {
        final index = entry.key;
        final carrera = entry.value;
        
        return _construirItemCarrera(
          icono: iconos[index % iconos.length],
          titulo: carrera,
        );
      }).toList(),
    );
  }

  Widget _construirItemCarrera({
    required IconData icono,
    required String titulo,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirBotonNavegacion(BuildContext context, IconData icono,
      String etiqueta, {required bool estaSeleccionado}) {
    return GestureDetector(
      onTap: () {
        if (etiqueta == 'Inicio') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PantallaPrincipal()),
          );
        } else if (etiqueta == 'Tests') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TestsScreen()),
          );
        } else if (etiqueta == 'Resultados') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PantallaHistorialEvaluaciones()),
          );
        } else if (etiqueta == 'Carreras') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PantallaRecomendacionesCarreras()),
          );
        } else if (etiqueta == 'Perfil') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PantallaPerfil()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: estaSeleccionado
                  ? const Color(0xFF121716).withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icono,
              color:
                  estaSeleccionado ? const Color(0xFF121716) : const Color(0xFF658680),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            etiqueta,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: estaSeleccionado
                  ? const Color(0xFF121716)
                  : const Color(0xFF658680),
            ),
          ),
        ],
      ),
    );
  }
}
