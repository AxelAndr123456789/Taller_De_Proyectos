import 'package:flutter/material.dart';
import '../models/carrera.dart';
import 'views.dart';

class PantallaDetallesCarrera extends StatelessWidget {
  final Carrera carrera;
   
  const PantallaDetallesCarrera({
    super.key,
    required this.carrera,
  });

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 218,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(carrera.portadaUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    carrera.nombre,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121617),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  carrera.descripcion,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF121617),
                    height: 1.5,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: carrera.habilidades.map((habilidad) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _construirTarjetaHabilidad(
                        icono: _getIconForSkill(habilidad),
                        titulo: habilidad,
                      ),
                    );
                  }).toList(),
                ),
              ),

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFDCE2E5)),
                    color: const Color(0xFFF5F5F5),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color(0xFF1B7298),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        carrera.duracion,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF121617),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  carrera.mercadoLaboral,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF121617),
                    height: 1.5,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaOfertaEducativa(
                            carrera: carrera.nombre,
                          ),
                        ),
                      );
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
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

  IconData _getIconForSkill(String skill) {
    final skillLower = skill.toLowerCase();
    if (skillLower.contains('program') || skillLower.contains('código')) {
      return Icons.code;
    } else if (skillLower.contains('comunica')) {
      return Icons.chat;
    } else if (skillLower.contains('análisis') || skillLower.contains('diagnóstico')) {
      return Icons.analytics;
    } else if (skillLower.contains('empatía') || skillLower.contains('humano')) {
      return Icons.favorite;
    } else if (skillLower.contains('gestión') || skillLower.contains('admin')) {
      return Icons.business;
    } else if (skillLower.contains('diseño') || skillLower.contains('creativ')) {
      return Icons.palette;
    } else if (skillLower.contains('trabajo') || skillLower.contains('equipo')) {
      return Icons.groups;
    } else if (skillLower.contains('liderazgo')) {
      return Icons.leaderboard;
    } else if (skillLower.contains('atención') || skillLower.contains('cuidado')) {
      return Icons.healing;
    } else if (skillLower.contains('precisión') || skillLower.contains('manual')) {
      return Icons.precision_manufacturing;
    }
    return Icons.star;
  }
}
