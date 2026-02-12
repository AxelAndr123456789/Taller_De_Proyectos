import 'package:flutter/foundation.dart';
import '../models/carrera.dart';

/// ViewModel para la pantalla de recomendaciones de carreras.
///
/// Según MVVM, este ViewModel contiene la lógica de presentación
/// para las recomendaciones de carreras y notifica cambios a la vista.
class RecomendacionesViewModel with ChangeNotifier {
  int _selectedIndex = 3;

  int get selectedIndex => _selectedIndex;

  /// Lista de carreras recomendadas
  final List<Carrera> carreras = const [
    Carrera(
      nombre: 'Ingeniería de Software',
      descripcion:
          'Diseña, desarrolla y prueba aplicaciones de software. Colabora con equipos para crear soluciones innovadoras.',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCmTa2J2w8KiwhBLHYqDM_U-HhJHqs0pWxWmXxAWkJb2XWCKv38ej_TjiGrbG4JD_h6cua8srjt8FWrTXlS4bNl4mWf2qRO39A0hOgTQ7kZA_L_13l0kOWvCAgvFNANY-17Rvfc2f_SPUJsqcHceYpfiIUu5bcHKAWIxUQ_8VkXfXzisPfDw1vcX3ePaiL31Fumd92fLqsydzU4Q5TDSD0QBrKa8iwAkTHR1JUjOABa7Gxj18BogNI3JsHhV--PtJPvIYkCpl0rmDNH',
      portadaUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
    ),
    Carrera(
      nombre: 'Enfermería',
      descripcion:
          'Proporciona atención directa al paciente, administra medicamentos y educa a pacientes y familias sobre el manejo de la salud.',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBLeo_Y0QWdhobDt-DLMRlf7LhRlZDYKViqMaUEFuSCzH22DVKtbvQon3TBkXvbGL4ANyNv39AhRewuZmFaXkG8sHxiUzplwLHoAdmW76T_C57a8TsOLMlsC9p9RQByPp9DyqIjdWO5m2zWTunCh2k7CxV2MRhfQNc8d19KlkRngtWKEQQMdAnWWM2JXiQ-E5WULk3D420bUL15YV-VtPJlBDLZXXkCcyk2d1N3j7y8Pr_aTCWyV4ZO1e3_2oQxoG7Qa_9mRcLC2A71',
      portadaUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
    ),
    Carrera(
      nombre: 'Ingeniería Mecánica',
      descripcion:
          'Diseña y analiza sistemas mecánicos, incluyendo máquinas, motores y herramientas. Enfoque en eficiencia e innovación.',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBEq1Y3_XIqaIk670m3aspVVLISiCT0mgpf0_99JfK_lOteRrueFqK4ctByh5B07cMO_bMSofJUMjrFQ1e1uOOXKM35doDIE_ktDMNwOqZYd71PZfvlQ2S5hRgsJ8lUyqdFSjthMTQ1c5OOEiNgZXM7CTPND7kHSLicpMOTu1GoZsrqk7hhZWeTwxj6CjNKxfCjMW_H-5T4tbgWTq_cZJIpiFggoqN_M35iGv08O_IvPYrRLkmov7cU-R0r8HJ0BdB18kkUMO2T7SU8',
      portadaUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
    ),
    Carrera(
      nombre: 'Administración de Empresas',
      descripcion:
          'Gestiona y supervisa operaciones comerciales, incluyendo marketing, finanzas y recursos humanos. Impulsa el éxito organizacional.',
      imagenUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCXpYQX57cWaW_PH3fhFkZbRDI9yIej2zm13RCR2UF6rdjg83TPokK1_R0tSwkobQiepjuIAU2tpIYJv3lzlZPK-1lx9UrZni1waEKJkzHKtpLSrh8aLRSoe_fRJjzxZaOTbfyV1IKQ1hXCj16gpUKpenzZc9I83KRgMkSKNcSb9Jnkl7dwhrnJQxXtBWtAlQ5NL1IVqQAjxPKvScsnlWmsuNzhe2q1ybIeiRsxpkrjJoeoh8aKCVNQlIlMBgq62PFwmRRV1Un53W7k',
      portadaUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
    ),
  ];

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Obtiene el número de carreras recomendadas
  int getCarrerasCount() {
    return carreras.length;
  }
}
