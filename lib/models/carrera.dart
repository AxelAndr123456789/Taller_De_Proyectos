class Carrera {
  final String nombre;
  final String descripcion;
  final String imagenUrl;
  final String portadaUrl;
  final List<String> habilidades;
  final String duracion;
  final String mercadoLaboral;

  const Carrera({
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.portadaUrl,
    required this.habilidades,
    required this.duracion,
    required this.mercadoLaboral,
  });
}
