// ============================================================================
// CONTROLADORES - Lógica de negocio de la aplicación
// ============================================================================

import '../models/models.dart';

class AuthController {
  final List<String> validEmails = [
    'usuario@gmail.com',
    'correo@hotmail.com',
    'email@outlook.com',
    'test@yahoo.com',
    'admin@example.com'
  ];
  final String validPassword = 'password123';

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    return null;
  }

  bool validateCredentials(String email, String password) {
    final trimmedEmail = email.trim();
    final isValidEmail = validEmails.contains(trimmedEmail);
    final isValidPassword = password == validPassword;
    return isValidEmail && isValidPassword;
  }

  String getErrorMessage(String email, String password) {
    final trimmedEmail = email.trim();
    final isValidEmail = validEmails.contains(trimmedEmail);
    final isValidPassword = password == validPassword;
    
    if (!isValidEmail && !isValidPassword) {
      return 'Credenciales incorrectas. Intenta con: usuario@gmail.com y password123';
    } else if (!isValidEmail) {
      return 'Correo electrónico no válido';
    } else {
      return 'Contraseña incorrecta';
    }
  }
}

class TestsController {
  final List<String> options = [
    'Totalmente en desacuerdo',
    'En desacuerdo',
    'Neutral',
    'De acuerdo',
    'Totalmente de acuerdo',
  ];

  final int totalQuestions = 10;

  String getQuestionForTest(String testType, int questionNumber) {
    switch (testType) {
      case 'Intereses Vocacionales':
        return _getInteresVocacionalQuestion(questionNumber);
      case 'Aptitudes':
        return _getAptitudesQuestion(questionNumber);
      case 'Personalidad':
        return _getPersonalidadQuestion(questionNumber);
      default:
        return '¿Cómo te sientes acerca de esta actividad?';
    }
  }

  String _getInteresVocacionalQuestion(int number) {
    final questions = [
      '¿Disfrutas diseñando gráficos digitales?',
      '¿Te gusta investigar temas científicos?',
      '¿Te interesa ayudar a personas con problemas?',
      '¿Disfrutas trabajando con números y datos?',
      '¿Te gusta crear contenido artístico?',
      '¿Te interesan las máquinas y la tecnología?',
      '¿Disfrutas organizando eventos?',
      '¿Te gusta enseñar a otras personas?',
      '¿Te interesa el mundo de los negocios?',
      '¿Disfrutas analizando problemas complejos?',
    ];
    return questions[number - 1];
  }

  String _getAptitudesQuestion(int number) {
    final questions = [
      '¿Te resulta fácil resolver problemas matemáticos complejos?',
      '¿Tienes buena memoria para recordar detalles?',
      '¿Eres hábil con las herramientas manuales?',
      '¿Tienes facilidad para aprender idiomas?',
      '¿Eres bueno identificando patrones?',
      '¿Tienes buena coordinación mano-ojo?',
      '¿Eres bueno expresándote por escrito?',
      '¿Tienes facilidad para entender mapas?',
      '¿Eres bueno trabajando bajo presión?',
      '¿Tienes habilidad para negociar?',
    ];
    return questions[number - 1];
  }

  String _getPersonalidadQuestion(int number) {
    final questions = [
      '¿Prefieres trabajar en equipo que individualmente?',
      '¿Te consideras una persona extrovertida?',
      '¿Eres meticuloso con los detalles?',
      '¿Te gusta tomar riesgos?',
      '¿Eres paciente con los demás?',
      '¿Prefieres seguir instrucciones que dar órdenes?',
      '¿Te adaptas fácilmente a cambios?',
      '¿Eres bueno manejando el estrés?',
      '¿Prefieres rutinas establecidas?',
      '¿Te gusta tomar decisiones rápidas?',
    ];
    return questions[number - 1];
  }

  List<Map<String, String>> getAvailableTests() {
    return [
      {
        'category': 'Intereses Vocacionales',
        'title': 'Descubre Tu Pasión',
        'description': 'Explora carreras alineadas con tus intereses y pasiones.',
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuB1EDx4Ly3T3eE-pK-GoFg9aqAsDQGarLGTEKfSslbhTk046A7g5ka9FOussvOzLhd-u70PmCaozOR3JGlUmsY0tq7EoR3MaDd8NUmqqyX4eAR030Wg-k8urTeCWVrCF1D3EUwHq1UqOPkwJqjMdepMq3VZ0dnVWKS8Pjw6hVKiccsZgRxAE2AVOjEvHcwZhi06opm7EzyFsxTgL1uDmcVmGspUEUatbi4Pf75-kcX-h7q7d58JTH3a5Nz4LOUv_23BcAFJ-UK64Yl0',
      },
      {
        'category': 'Aptitudes',
        'title': 'Descubre Tus Fortalezas',
        'description': 'Identifica tus talentos naturales y habilidades para encontrar caminos profesionales adecuados.',
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAUnQmCqYGAalEH844C6WJmOI9hOwBm7qLPbZdEOEN1rbIESN-C2DZB6gm7PT5x4hi_9-x9IRq2XldbOpkJToL2Vmltf7f_s_wSBFqNIPSrZL0CMiuK2D1JGaFxhxBOz04jy3nVuGuPDSlKXUnumAYLcutVfhw7BfnrJ64TgU3uvm0RQHbJZhV4Z28eFXtNCVNM7VaQe3ehHCepeQML2DsYJYRmPCuD0-IXNgvnRnG5NnBLbf-WDWSK5UjHZSuMCkj-8fRbtU1dMNXW',
      },
      {
        'category': 'Personalidad',
        'title': 'Conoce Tu Verdadero Yo',
        'description': 'Comprende tus rasgos de personalidad y cómo se adaptan a diferentes profesiones.',
        'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCF_N0UNsQaHoperFMXs7Q2wlfVn-WGy4gefWoL0ztTQ9Eu_nxSfp6rX5gVtiMQU8TIwBySIvlVu7fYTmMQImoeAvIV6yhRhC9RoAnvnLvU_2CP3kL8gjqeP_gcGRZl5TLbWLyUxrjHQ_TFSsI53DONKW49FkhMjYcA0TQtGm09eROfecYtiKVPZIgH63MoFqb45BLoE87DG1-mrDVpGfztbYjQjJHp_UBDuUEXoN7-BwhskyDwUXmRGy3kRKen3Rg3C4X7tWjlGPwI',
      },
    ];
  }
}

class CarrerasController {
  List<Carrera> getCarreras() {
    return [
      Carrera(
        nombre: 'Ingeniería de Software',
        compatibilidad: '95% Compatibilidad',
        descripcion: 'Diseña, desarrolla y prueba aplicaciones de software. Colabora con equipos para crear soluciones innovadoras.',
        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCmTa2J2w8KiwhBLHYqDM_U-HhJHqs0pWxWmXxAWkJb2XWCKv38ej_TjiGrbG4JD_h6cua8srjt8FWrTXlS4bNl4mWf2qRO39A0hOgTQ7kZA_L_13l0kOWvCAgvFNANY-17Rvfc2f_SPUJsqcHceYpfiIUu5bcHKAWIxUQ_8VkXfXzisPfDw1vcX3ePaiL31Fumd92fLqsydzU4Q5TDSD0QBrKa8iwAkTHR1JUjOABa7Gxj18BogNI3JsHhV--PtJPvIYkCpl0rmDNH',
        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
      ),
      Carrera(
        nombre: 'Enfermería',
        compatibilidad: '92% Compatibilidad',
        descripcion: 'Proporciona atención directa al paciente, administra medicamentos y educa a pacientes y familias sobre el manejo de la salud.',
        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLeo_Y0QWdhobDt-DLMRlf7LhRlZDYKViqMaUEFuSCzH22DVKtbvQon3TBkXvbGL4ANyNv39AhRewuZmFaXkG8sHxiUzplwLHoAdmW76T_C57a8TsOLMlsC9p9RQByPp9DyqIjdWO5m2zWTunCh2k7CxV2MRhfQNc8d19KlkRngtWKEQQMdAnWWM2JXiQ-E5WULk3D420bUL15YV-VtPJlBDLZXXkCcyk2d1N3j7y8Pr_aTCWyV4ZO1e3_2oQxoG7Qa_9mRcLC2A71',
        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
      ),
      Carrera(
        nombre: 'Ingeniería Mecánica',
        compatibilidad: '88% Compatibilidad',
        descripcion: 'Diseña y analiza sistemas mecánicos, incluyendo máquinas, motores y herramientas. Enfoque en eficiencia e innovación.',
        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBEq1Y3_XIqaIk670m3aspVVLISiCT0mgpf0_99JfK_lOteRrueFqK4ctByh5B07cMO_bMSofJUMjrFQ1e1uOOXKM35doDIE_ktDMNwOqZYd71PZfvlQ2S5hRgsJ8lUyqdFSjthMTQ1c5OOEiNgZXM7CTPND7kHSLicpMOTu1GoZsrqk7hhZWeTwxj6CjNKxfCjMW_H-5T4tbgWTq_cZJIpiFggoqN_M35iGv08O_IvPYrRLkmov7cU-R0r8HJ0BdB18kkUMO2T7SU8',
        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
      ),
      Carrera(
        nombre: 'Administración de Empresas',
        compatibilidad: '85% Compatibilidad',
        descripcion: 'Gestiona y supervisa operaciones comerciales, incluyendo marketing, finanzas y recursos humanos. Impulsa el éxito organizacional.',
        imagenUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCXpYQX57cWaW_PH3fhFkZbRDI9yIej2zm13RCR2UF6rdjg83TPokK1_R0tSwkobQiepjuIAU2tpIYJv3lzlZPK-1lx9UrZni1waEKJkzHKtpLSrh8aLRSoe_fRJjzxZaOTbfyV1IKQ1hXCj16gpUKpenzZc9I83KRgMkSKNcSb9Jnkl7dwhrnJQxXtBWtAlQ5NL1IVqQAjxPKvScsnlWmsuNzhe2q1ybIeiRsxpkrjJoeoh8aKCVNQlIlMBgq62PFwmRRV1Un53W7k',
        portadaUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCHnJQC5mqO1__8RaePTIFukja-bsjHnFO9ShfCOA6UGw9pmEp95jMSmUwcUFXqH4QUelaIyHG7pc0OPp2iVYvpzdD6fvGAXN_ZD1checjhxWdCKmomaj2bSrKYfYF4EKav9f08tHR0XzcyNpZ_hb1wOls-t2N6Fndwb7TdpV4hhb7XBpqx30ZVTMFEtq06QQpvKPGHm0HsCimmzQjtMqc4RwM1VSD-bqcd4PIIS3MlJU9Br_mv_T4bseyyYHar4FnsyTCNo4b5uLql',
      ),
    ];
  }

  List<Map<String, String>> getInstituciones() {
    return [
      {
        'imagenUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAs6-W-VOGvkJSh-bxQCesM0fzBS9TPDhVRQObV-7hnUi-zmphJY-HuXyKS55kPKhcMF_NWdWAKFzMfZUIbUQEmOwxoRrErcv-h1atrC_zMiyteLbkQPfqRxfxhYegSS0PZTO76kk5VRqFA_IHl7QVrMGaSXdnfH5vU0qh6RsvVKZ-B2IGcc6FgncOhIGy4piX_DxEmKAeV4CIhCqbj_EULRAzZsI6Hz8611BJJOcTgw4EY_kRERpzf7ubluMngqaqK5HpCiy6uXgIX',
        'nombre': 'Universidad Nacional del Centro del Perú',
        'direccion': 'Av. Los Incas 123, Huancayo',
      },
      {
        'imagenUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD6egp3LaQ28dvND0lhsEB5D3GQS1v9TWk3U_6HF4D3WUUUcMoKCVpfWYTxOCcevRaz7bB68j70xGp5fvianqFJjrIbUro2VnD6N901az1PanxughZl7Pet8BrR0jDtx3rzWyJiSdJtodCxL1r8oBESBD886c0ZJQQjkk7-3IVEpDuxD-W-H1p45UsJjcrPuQfIuSMq8XEt5GlEH9pD3H7BrCsgWiDKGi1kdcWRebbxYZc2eEiZ7eyWowxr7f6aF78aocVpQqnxMGI1',
        'nombre': 'Instituto Tecnológico Superior de Tarma',
        'direccion': 'Jr. Libertad 456, Tarma',
      },
      {
        'imagenUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuC4j-dII-gv7elTzFwt9R7rcz_Ga_AR3X56w3eGs-Fwi5SbfCz4bvZJ2ELfSCt827MTnIGJ_xfsqW7F30kw0JJmciQeoKcmOvDKhzukO-cDWR_ZLR0T7lo8AbqcGy2taYMxAVWrMytq-u8x-1jbhUaYNI5TzWMsVT4awalZU4cYnfnsh_reJsJzlwIdSehn6cpLeNytQDZw920bw5Mssr1aNkURc-zYd4dFUi-fbOItPHa_TheKT5hhL8LOvIYg2jOT-PyGrJpH4owU',
        'nombre': 'Instituto Pedagógico de Jauja',
        'direccion': 'Calle Real 789, Jauja',
      },
    ];
  }
}
