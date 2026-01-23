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
      home: const PantallaRecomendacionesCarreras(),
    );
  }
}

class PantallaRecomendacionesCarreras extends StatelessWidget {
  const PantallaRecomendacionesCarreras({super.key});

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
                        'Recomendaciones de Carreras',
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

            // Lista de recomendaciones
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _construirTarjetaCarrera(
                      compatibilidad: '95% Compatibilidad',
                      titulo: 'Ingeniería de Software',
                      descripcion: 'Diseña, desarrolla y prueba aplicaciones de software. Colabora con equipos para crear soluciones innovadoras.',
                      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCmTa2J2w8KiwhBLHYqDM_U-HhJHqs0pWxWmXxAWkJb2XWCKv38ej_TjiGrbG4JD_h6cua8srjt8FWrTXlS4bNl4mWf2qRO39A0hOgTQ7kZA_L_13l0kOWvCAgvFNANY-17Rvfc2f_SPUJsqcHceYpfiIUu5bcHKAWIxUQ_8VkXfXzisPfDw1vcX3ePaiL31Fumd92fLqsydzU4Q5TDSD0QBrKa8iwAkTHR1JUjOABa7Gxj18BogNI3JsHhV--PtJPvIYkCpl0rmDNH',
                    ),
                    _construirTarjetaCarrera(
                      compatibilidad: '92% Compatibilidad',
                      titulo: 'Enfermería',
                      descripcion: 'Proporciona atención directa al paciente, administra medicamentos y educa a pacientes y familias sobre el manejo de la salud.',
                      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLeo_Y0QWdhobDt-DLMRlf7LhRlZDYKViqMaUEFuSCzH22DVKtbvQon3TBkXvbGL4ANyNv39AhRewuZmFaXkG8sHxiUzplwLHoAdmW76T_C57a8TsOLMlsC9p9RQByPp9DyqIjdWO5m2zWTunCh2k7CxV2MRhfQNc8d19KlkRngtWKEQQMdAnWWM2JXiQ-E5WULk3D420bUL15YV-VtPJlBDLZXXkCcyk2d1N3j7y8Pr_aTCWyV4ZO1e3_2oQxoG7Qa_9mRcLC2A71',
                    ),
                    _construirTarjetaCarrera(
                      compatibilidad: '88% Compatibilidad',
                      titulo: 'Ingeniería Mecánica',
                      descripcion: 'Diseña y analiza sistemas mecánicos, incluyendo máquinas, motores y herramientas. Enfoque en eficiencia e innovación.',
                      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBEq1Y3_XIqaIk670m3aspVVLISiCT0mgpf0_99JfK_lOteRrueFqK4ctByh5B07cMO_bMSofJUMjrFQ1e1uOOXKM35doDIE_ktDMNwOqZYd71PZfvlQ2S5hRgsJ8lUyqdFSjthMTQ1c5OOEiNgZXM7CTPND7kHSLicpMOTu1GoZsrqk7hhZWeTwxj6CjNKxfCjMW_H-5T4tbgWTq_cZJIpiFggoqN_M35iGv08O_IvPYrRLkmov7cU-R0r8HJ0BdB18kkUMO2T7SU8',
                    ),
                    _construirTarjetaCarrera(
                      compatibilidad: '85% Compatibilidad',
                      titulo: 'Administración de Empresas',
                      descripcion: 'Gestiona y supervisa operaciones comerciales, incluyendo marketing, finanzas y recursos humanos. Impulsa el éxito organizacional.',
                      imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCXpYQX57cWaW_PH3fhFkZbRDI9yIej2zm13RCR2UF6rdjg83TPokK1_R0tSwkobQiepjuIAU2tpIYJv3lzlZPK-1lx9UrZni1waEKJkzHKtpLSrh8aLRSoe_fRJjzxZaOTbfyV1IKQ1hXCj16gpUKpenzZc9I83KRgMkSKNcSb9Jnkl7dwhrnJQxXtBWtAlQ5NL1IVqQAjxPKvScsnlWmsuNzhe2q1ybIeiRsxpkrjJoeoh8aKCVNQlIlMBgq62PFwmRRV1Un53W7k',
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
                  _construirBotonNavegacion(Icons.bar_chart_outlined, 'Resultados', estaSeleccionado: false),
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

  Widget _construirTarjetaCarrera({
    required String compatibilidad,
    required String titulo,
    required String descripcion,
    required String imagenUrl,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contenido de texto
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  compatibilidad,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF657C86),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121617),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descripcion,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF657C86),
                  ),
                ),
                const SizedBox(height: 12),
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
                      'Ver Detalles',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Imagen
          Expanded(
            flex: 1,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imagenUrl),
                  fit: BoxFit.cover,
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