import 'package:flutter/material.dart';
import '../models/carrera.dart';
import 'views.dart';

class PantallaRecomendacionesCarreras extends StatefulWidget {
  const PantallaRecomendacionesCarreras({super.key});

  @override
  State<PantallaRecomendacionesCarreras> createState() => _PantallaRecomendacionesCarrerasState();
}

class _PantallaRecomendacionesCarrerasState extends State<PantallaRecomendacionesCarreras> {
  int _selectedIndex = 3;

  void _navigateToTab(int index) {
    if (index == _selectedIndex) return;
    
    setState(() {
      _selectedIndex = index;
    });
    
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
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: const Color(0xFF121617),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
                        );
                      },
                    ),
                  ),
                  
                  const Center(
                    child: Text(
                      'Carreras',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF121617),
                      ),
                    ),
                  ),
                  
                  const Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _construirTarjetaCarrera(
                      carrera: Carrera(
                        nombre: 'Ingeniería de Software',
                        descripcion: 'Diseña, desarrolla y prueba aplicaciones de software. Colabora con equipos para crear soluciones innovadoras.',
                        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCmTa2J2w8KiwhBLHYqDM_U-HhJHqs0pWxWmXxAWkJb2XWCKv38ej_TjiGrbG4JD_h6cua8srjt8FWrTXlS4bNl4mWf2qRO39A0hOgTQ7kZA_L_13l0kOWvCAgvFNANY-17Rvfc2f_SPUJsqcHceYpfiIUu5bcHKAWIxUQ_8VkXfXzisPfDw1vcX3ePaiL31Fumd92fLqsydzU4Q5TDSD0QBrKa8iwAkTHR1JUjOABa7Gxj18BogNI3JsHhV--PtJPvIYkCpl0rmDNH',
                        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
                      ),
                    ),
                    _construirTarjetaCarrera(
                      carrera: Carrera(
                        nombre: 'Enfermería',
                        descripcion: 'Proporciona atención directa al paciente, administra medicamentos y educa a pacientes y familias sobre el manejo de la salud.',
                        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLeo_Y0QWdhobDt-DLMRlf7LhRlZDYKViqMaUEFuSCzH22DVKtbvQon3TBkXvbGL4ANyNv39AhRewuZmFaXkG8sHxiUzplwLHoAdmW76T_C57a8TsOLMlsC9p9RQByPp9DyqIjdWO5m2zWTunCh2k7CxV2MRhfQNc8d19KlkRngtWKEQQMdAnWWM2JXiQ-E5WULk3D420bUL15YV-VtPJlBDLZXXkCcyk2d1N3j7y8Pr_aTCWyV4ZO1e3_2oQxoG7Qa_9mRcLC2A71',
                        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
                      ),
                    ),
                    _construirTarjetaCarrera(
                      carrera: Carrera(
                        nombre: 'Ingeniería Mecánica',
                        descripcion: 'Diseña y analiza sistemas mecánicos, incluyendo máquinas, motores y herramientas. Enfoque en eficiencia e innovación.',
                        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBEq1Y3_XIqaIk670m3aspVVLISiCT0mgpf0_99JfK_lOteRrueFqK4ctByh5B07cMO_bMSofJUMjrFQ1e1uOOXKM35doDIE_ktDMNwOqZYd71PZfvlQ2S5hRgsJ8lUyqdFSjthMTQ1c5OOEiNgZXM7CTPND7kHSLicpMOTu1GoZsrqk7hhZWeTwxj6CjNKxfCjMW_H-5T4tbgWTq_cZJIpiFggoqN_M35iGv08O_IvPYrRLkmov7cU-R0r8HJ0BdB18kkUMO2T7SU8',
                        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
                      ),
                    ),
                    _construirTarjetaCarrera(
                      carrera: Carrera(
                        nombre: 'Administración de Empresas',
                        descripcion: 'Gestiona y supervisa operaciones comerciales, incluyendo marketing, finanzas y recursos humanos. Impulsa el éxito organizacional.',
                        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCXpYQX57cWaW_PH3fhFkZbRDI9yIej2zm13RCR2UF6rdjg83TPokK1_R0tSwkobQiepjuIAU2tpIYJv3lzlZPK-1lx9UrZni1waEKJkzHKtpLSrh8aLRSoe_fRJjzxZaOTbfyV1IKQ1hXCj16gpUKpenzZc9I83KRgMkSKNcSb9Jnkl7dwhrnJQxXtBWtAlQ5NL1IVqQAjxPKvScsnlWmsuNzhe2q1ybIeiRsxpkrjJoeoh8aKCVNQlIlMBgq62PFwmRRV1Un53W7k',
                        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
                      ),
                    ),
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

  Widget _construirTarjetaCarrera({
    required Carrera carrera,
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
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carrera.nombre,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121617),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  carrera.descripcion,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaDetallesCarrera(
                            carrera: carrera,
                          ),
                        ),
                      );
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

          Expanded(
            flex: 1,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(carrera.imagenUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

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
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
