import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stitch Career',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Epilogue',
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ============ MODELO PARA RESULTADOS ============
class TestResult {
  final String testType;
  final String testTitle;
  final DateTime completionDate;
  
  TestResult({
    required this.testType,
    required this.testTitle,
    required this.completionDate,
  });
  
  // Formatear la fecha como "15-01-2024"
  String get formattedDate {
    return "${completionDate.day.toString().padLeft(2, '0')}-${completionDate.month.toString().padLeft(2, '0')}-${completionDate.year}";
  }
}

// ============ GESTOR DE RESULTADOS ============
class ResultManager {
  static final ResultManager _instance = ResultManager._internal();
  
  factory ResultManager() {
    return _instance;
  }
  
  ResultManager._internal();
  
  // Lista de resultados recientes - INICIALMENTE VACÍA
  List<TestResult> _recentResults = [];
  // Lista de evaluaciones completadas
  List<Map<String, String>> _completedEvaluations = [
    {
      'titulo': 'Test Vocacional 1',
      'perfilPrincipal': 'Perfil Principal: Ingeniería',
      'fecha': '15-01-2024',
    },
    {
      'titulo': 'Test Vocacional 2',
      'perfilPrincipal': 'Perfil Principal: Medicina',
      'fecha': '10-01-2024',
    },
    {
      'titulo': 'Test Vocacional 3',
      'perfilPrincipal': 'Perfil Principal: Artes',
      'fecha': '05-01-2024',
    },
  ];
  
  // Método para agregar un nuevo resultado
  void addResult(String testType, String testTitle) {
    _recentResults.insert(0, TestResult(
      testType: testType,
      testTitle: testTitle,
      completionDate: DateTime.now(),
    ));
    
    // También agregar a evaluaciones completadas
    _completedEvaluations.insert(0, {
      'titulo': testTitle,
      'perfilPrincipal': 'Perfil Principal: ${testType.split(' ').first}',
      'fecha': DateTime.now().toString().substring(0, 10),
    });
    
    // Mantener solo los últimos 5 resultados
    if (_recentResults.length > 5) {
      _recentResults = _recentResults.sublist(0, 5);
    }
  }
  
  // Método para obtener todos los resultados
  List<TestResult> getRecentResults() {
    return List.from(_recentResults);
  }
  
  // Método para obtener evaluaciones completadas
  List<Map<String, String>> getCompletedEvaluations() {
    return List.from(_completedEvaluations);
  }
}

// ============ PANTALLA DE LOGIN ============
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Credenciales válidas
  final List<String> _validEmails = [
    'usuario@gmail.com',
    'correo@hotmail.com',
    'email@outlook.com',
    'test@yahoo.com',
    'admin@example.com'
  ];
  final String _validPassword = 'password123';

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Verificar credenciales
      bool isValidEmail = _validEmails.contains(email);
      bool isValidPassword = password == _validPassword;

      if (isValidEmail && isValidPassword) {
        // Navegar a la pantalla principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
        );
      } else {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciales incorrectas. Intenta con: usuario@gmail.com y password123'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Validar formato de email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    
    // Validar formato básico de email
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }
    
    return null;
  }

  // Validar contraseña
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                const SizedBox(height: 20),
                const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ingresa tus credenciales para continuar con tu test.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                // Formulario
                const SizedBox(height: 40),
                _buildTextField(
                  label: 'Correo electrónico',
                  hint: 'usuario@gmail.com',
                  controller: _emailController,
                  isPassword: false,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                _buildPasswordField(),

                // Botón de ingresar
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Enlace para crear cuenta
                const Spacer(),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿No tienes una cuenta?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Funcionalidad de crear cuenta en desarrollo'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                        child: const Text(
                          'Crear cuenta',
                          style: TextStyle(
                            color: Color(0xFF0052FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword && !_showPassword,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Contraseña',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Contraseña de ejemplo: password123'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              child: const Text(
                '¿La olvidaste?',
                style: TextStyle(
                  color: Color(0xFF0052FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  validator: _validatePassword,
                  decoration: const InputDecoration(
                    hintText: 'password123',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============ PANTALLA PRINCIPAL (HOME) ============
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _selectedIndex = 0;
  bool _isTestHovered = false;
  final ResultManager _resultManager = ResultManager();

  // Navegación entre pantallas
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 1) { // Tests
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 2) { // Resultados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) { // Carreras
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) { // Perfil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaPerfil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentResults = _resultManager.getRecentResults();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                // Header con avatar y título
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuA4DO2yOPKDC3cmgRmFZfQSRFTl_aXnrY2YXTK7Kr1I7yy-nmSTFjnhMsvLB3saicwJIt4z8DwMoixOC_Kg5V_I3L1eokXg8Aii7j0VeXyETMGIiHpwGauh__wCuZdknh9aFD9cuJOC6kJhCNkEMBuVFoc-Ysa5o4L2hN20qpqC6ID3zCPEHevyMdhFCUBFKXDH7nh7aGO8towkzUYJeBLaa0l2hv-RC8wlRZGZWcLh0V3P5cQPLE4Tfazb4jMFeL87O9lGkx2HyqlS',
                        ),
                        radius: 20,
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Inicio',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // Saludo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hola, Sofia',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF121617),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Nueva sección de test
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const TestsScreen()),
                          );
                        },
                        onHover: (hovering) {
                          setState(() {
                            _isTestHovered = hovering;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(
                              color: _isTestHovered
                                  ? const Color(0xFF0052FF).withOpacity(0.3)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nuevo',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF657C86),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    AnimatedDefaultTextStyle(
                                      duration: const Duration(milliseconds: 200),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _isTestHovered
                                            ? const Color(0xFF0052FF)
                                            : const Color(0xFF121617),
                                      ),
                                      child: const Text('Tomar Nuevo Test'),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Descubre tu camino profesional ideal con nuestra última evaluación.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF657C86),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBlYrcl6zA9TR987a1cg4VcUP8YP8AWV5TYB0puseqDj5GMQ0Gdpw1upLtWZun55kfr_-pXKSya9bAdZzMFP_AEWFcGGw34o3-uful07LGfjzGw1KXIK6KXFS8AxTGDO7MK2p6gY1yUsN7f1kDWKJiKdlHCtAhXhp4RRi5nPyTndB0vuZWE_CCLd53EZhdUTL88kqEHeHEKA4g3Uoi3cEJ2RrYli586EXWGiBMiOt7xKCDwSyRumqlZn8OIYUxb5s4knQxUZST6U6Cw',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Carreras destacadas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Carreras Destacadas',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF121617),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lista horizontal de carreras
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCcIFpt9OxmhsqKarIdcM7hoFrWzUDCg1xFqSt5E5MpJoivKeT9RBV4HGoH4jmEqGmbL-7r-NUtMEJkvyqfohyofUdBAk0BHntMQ7MwLVrG1f9NbHe_3gFPMsFh94Xw9H1WCVe97098iAS1mOqUnS_mY7rGjacz_dfxK0dHPyHlNUpS-f7ENAAFdd3NOM9BRu-j6-QL9XcaicmkNelkym1zfa3b6WefMgSJavT4WwsgRSOi5LeN6q9f0OyYxui3ZBAHk6Vqsc5zCvnk',
                              title: 'Médico',
                              description: 'Profesional de la salud',
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBFr1zXdezl1vxFCR7qgHvXVKJJWc6vDf7s_J57A16RMKXIUSq-XD506NmAUhSuVqOwHe1u18Wjc-Atdc599WvvzwLcKt-WEGDS-B3bQUuWf4EsHft0RRS8JBoGEvB9PubKZYQ9_4B3qhj7z16aIhdIBxTauXFcpz4yttdHm3DP-4A7wgaVNcOMyNq4DMswYkJ5lhY_pnzsa66mJ3FyeJQaA9rt0h0nJ3Np2PmRIKinucgmnfajN1-9U8GfIrYFJW1KX1gm58YlNDHh',
                              title: 'Ingeniero',
                              description: 'Diseña y construye',
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCJFbJLYCEDTWyD5rsxe5XbxVibQ56a9Sr0d1kWBApS1KEzxwb6Zz2xRI6OFrK8USKu5qF8M-_R1EHd-oC-ddwceYOxuQ3uMy4Mro7zJ_Tjur5dvxZ0CJJFfKRDL9jed5xZK8Zrr8Qvedt6EJp1I1NJd5ONPiSIp-diRdEAhgrJ7aIJql0Xe2XZIhu1ZXXvNbVQA6RhXHJu1jWx2ItqPDp8b9OHpRKv7RhPIMUFaJhq86nX02O2itQnCScU4qWzLjtc8OfcrY37I95n',
                              title: 'Arquitecto',
                              description: 'Crea diseños de edificios',
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Últimos resultados
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resultados Recientes',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF121617),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lista de resultados
                      if (recentResults.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Icon(
                                Icons.assignment_outlined,
                                color: Color(0xFF657C86),
                                size: 60,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No hay resultados recientes',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF121617),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Completa un test para ver tus resultados aquí',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF657C86),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: recentResults.map((result) {
                            return _buildResultCard(result);
                          }).toList(),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),

      // Barra de navegación inferior
      bottomNavigationBar: Container(
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
    );
  }

  Widget _buildResultCard(TestResult result) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF0F3F4),
              ),
              child: const Icon(
                Icons.bar_chart,
                color: Color(0xFF121617),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.testTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF121617),
                    ),
                  ),
                  Text(
                    'Completado el ${result.formattedDate}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF657C86),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF121617),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareerCard({
    required String imageUrl,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 150,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF121617),
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF657C86),
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF0052FF).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

// ============ PANTALLA DE TESTS ============
class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  int _selectedIndex = 1; // Tests está seleccionado por defecto

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) { // Inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 2) { // Resultados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) { // Carreras
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) { // Perfil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaPerfil()),
      );
    }
  }

  void _navigateToTest(String testType, String testTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestQuestionsScreen(
          testType: testType,
          testTitle: testTitle,
        ),
      ),
    );
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
                    color: const Color(0xFF111618),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111618),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildTestCard(
                      category: 'Intereses Vocacionales',
                      title: 'Descubre Tu Pasión',
                      description: 'Explora carreras alineadas con tus intereses y pasiones.',
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB1EDx4Ly3T3eE-pK-GoFg9aqAsDQGarLGTEKfSslbhTk046A7g5ka9FOussvOzLhd-u70PmCaozOR3JGlUmsY0tq7EoR3MaDd8NUmqqyX4eAR030Wg-k8urTeCWVrCF1D3EUwHq1UqOPkwJqjMdepMq3VZ0dnVWKS8Pjw6hVKiccsZgRxAE2AVOjEvHcwZhi06opm7EzyFsxTgL1uDmcVmGspUEUatbi4Pf75-kcX-h7q7d58JTH3a5Nz4LOUv_23BcAFJ-UK64Yl0',
                      onTap: () => _navigateToTest('Intereses Vocacionales', 'Test de Intereses'),
                    ),
                    const SizedBox(height: 16),

                    _buildTestCard(
                      category: 'Aptitudes',
                      title: 'Descubre Tus Fortalezas',
                      description: 'Identifica tus talentos naturales y habilidades para encontrar caminos profesionales adecuados.',
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAUnQmCqYGAalEH844C6WJmOI9hOwBm7qLPbZdEOEN1rbIESN-C2DZB6gm7PT5x4hi_9-x9IRq2XldbOpkJToL2Vmltf7f_s_wSBFqNIPSrZL0CMiuK2D1JGaFxhxBOz04jy3nVuGuPDSlKXUnumAYLcutVfhw7BfnrJ64TgU3uvm0RQHbJZhV4Z28eFXtNCVNM7VaQe3ehHCepeQML2DsYJYRmPCuD0-IXNgvnRnG5NnBLbf-WDWSK5UjHZSuMCkj-8fRbtU1dMNXW',
                      onTap: () => _navigateToTest('Aptitudes', 'Test de Aptitudes'),
                    ),
                    const SizedBox(height: 16),

                    _buildTestCard(
                      category: 'Personalidad',
                      title: 'Conoce Tu Verdadero Yo',
                      description: 'Comprende tus rasgos de personalidad y cómo se adaptan a diferentes profesiones.',
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCF_N0UNsQaHoperFMXs7Q2wlfVn-WGy4gefWoL0ztTQ9Eu_nxSfp6rX5gVtiMQU8TIwBySIvlVu7fYTmMQImoeAvIV6yhRhC9RoAnvnLvU_2CP3kL8gjqeP_gcGRZl5TLbWLyUxrjHQ_TFSsI53DONKW49FkhMjYcA0TQtGm09eROfecYtiKVPZIgH63MoFqb45BLoE87DG1-mrDVpGfztbYjQjJHp_UBDuUEXoN7-BwhskyDwUXmRGy3kRKen3Rg3C4X7tWjlGPwI',
                      onTap: () => _navigateToTest('Personalidad', 'Test de Personalidad'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFF0F3F4))),
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

  Widget _buildTestCard({
    required String category,
    required String title,
    required String description,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF637D88),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111618),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF637D88),
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  color: const Color(0xFFF0F3F4),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Text(
                        'Comenzar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111618),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
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
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0052FF).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

// ============ PANTALLA DE PREGUNTAS DEL TEST ============
class TestQuestionsScreen extends StatefulWidget {
  final String testType;
  final String testTitle;
  
  const TestQuestionsScreen({
    super.key,
    required this.testType,
    required this.testTitle,
  });

  @override
  State<TestQuestionsScreen> createState() => _TestQuestionsScreenState();
}

class _TestQuestionsScreenState extends State<TestQuestionsScreen> {
  int _selectedIndex = 1; // Tests está seleccionado
  int _selectedOption = 0;
  int _currentQuestion = 1;
  final int _totalQuestions = 10;
  final ResultManager _resultManager = ResultManager();

  final List<String> _options = [
    'Totalmente en desacuerdo',
    'En desacuerdo',
    'Neutral',
    'De acuerdo',
    'Totalmente de acuerdo',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) { // Inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 1) { // Tests
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 2) { // Resultados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) { // Carreras
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) { // Perfil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaPerfil()),
      );
    }
  }

  void _selectOption(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  void _goToNextQuestion() {
    if (_currentQuestion < _totalQuestions) {
      setState(() {
        _currentQuestion++;
        _selectedOption = 0;
      });
    } else {
      // TEST COMPLETADO
      _resultManager.addResult(widget.testType, widget.testTitle);
      
      // SOLO mostrar el mensaje sin botón "Ver Resultados"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡${widget.testTitle} completado!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
      
      // Navegar de vuelta a la pantalla principal
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
        );
      });
    }
  }

  void _goToPreviousQuestion() {
    if (_currentQuestion > 1) {
      setState(() {
        _currentQuestion--;
        _selectedOption = 0;
      });
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
                    color: const Color(0xFF111618),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.testTitle, // Usar el título específico del test
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111618),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pregunta $_currentQuestion de $_totalQuestions',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111618),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE2E5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _currentQuestion / _totalQuestions,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF111618),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  // Pregunta dinámica basada en el tipo de test
                  _getQuestionForTest(widget.testType, _currentQuestion),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111618),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(_options.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildOptionCard(
                        text: _options[index],
                        isSelected: _selectedOption == index,
                        onTap: () => _selectOption(index),
                      ),
                    );
                  }),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Material(
                      color: const Color(0xFFF0F3F4),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: _currentQuestion > 1 ? _goToPreviousQuestion : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          child: Text(
                            'Anterior',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _currentQuestion > 1
                                  ? const Color(0xFF111618)
                                  : const Color(0xFF111618).withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Material(
                      color: _currentQuestion < _totalQuestions 
                          ? const Color(0xFF1798CF)
                          : const Color(0xFF28a745),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: _goToNextQuestion,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          child: Text(
                            _currentQuestion < _totalQuestions ? 'Siguiente' : 'Completar Test',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFF0F3F4))),
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

  String _getQuestionForTest(String testType, int questionNumber) {
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

  Widget _buildOptionCard({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF111618) : const Color(0xFFDCE2E5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111618),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF111618) : const Color(0xFFDCE2E5),
                    width: 2,
                  ),
                  color: Colors.white,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF111618),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0052FF).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

// ============ PANTALLA DE PERFIL ============
class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  int _selectedIndex = 4; // Perfil está seleccionado

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) { // Inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 1) { // Tests
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 2) { // Resultados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) { // Carreras
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    }
  }

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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Configuración en desarrollo'),
                            backgroundColor: Colors.blue,
                          ),
                        );
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Barra de navegación inferior CONSISTENTE
      bottomNavigationBar: Container(
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

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0052FF).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

// ============ PANTALLA DE RECOMENDACIONES DE CARRERAS ============
class PantallaRecomendacionesCarreras extends StatefulWidget {
  const PantallaRecomendacionesCarreras({super.key});

  @override
  State<PantallaRecomendacionesCarreras> createState() => _PantallaRecomendacionesCarrerasState();
}

class _PantallaRecomendacionesCarrerasState extends State<PantallaRecomendacionesCarreras> {
  int _selectedIndex = 3; // Carreras está seleccionado

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) { // Inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 1) { // Tests
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 2) { // Resultados
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 4) { // Perfil
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
            // Encabezado con botón de retroceso
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

            // Barra de navegación inferior CONSISTENTE
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Detalles de $titulo en desarrollo'),
                          backgroundColor: Colors.blue,
                          duration: const Duration(seconds: 1),
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

  Widget _buildNavButton(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0052FF).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

// ============ PANTALLA DE HISTORIAL DE EVALUACIONES ============
class PantallaHistorialEvaluaciones extends StatefulWidget {
  const PantallaHistorialEvaluaciones({super.key});

  @override
  State<PantallaHistorialEvaluaciones> createState() => _PantallaHistorialEvaluacionesState();
}

class _PantallaHistorialEvaluacionesState extends State<PantallaHistorialEvaluaciones> {
  int _selectedIndex = 2; // Resultados está seleccionado
  final ResultManager _resultManager = ResultManager();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) { // Inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 1) { // Tests
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 3) { // Carreras
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) { // Perfil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PantallaPerfil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedEvaluations = _resultManager.getCompletedEvaluations();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado centrado sin botón de retroceso
            Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  'Historial de Evaluaciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121617),
                  ),
                ),
              ),
            ),

            // Título: Evaluaciones Completadas
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Evaluaciones Completadas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF121617),
                  ),
                ),
              ),
            ),

            // Lista de evaluaciones
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: completedEvaluations.map((evaluacion) {
                    return _construirItemEvaluacion(
                      titulo: evaluacion['titulo']!,
                      perfilPrincipal: evaluacion['perfilPrincipal']!,
                    );
                  }).toList(),
                ),
              ),
            ),

            // Barra de navegación inferior CONSISTENTE
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

  Widget _construirItemEvaluacion({
    required String titulo,
    required String perfilPrincipal,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Información de la evaluación
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
                const SizedBox(height: 4),
                Text(
                  perfilPrincipal,
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

          // Botón Ver Resultados
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Resultados de $titulo en desarrollo'),
                    backgroundColor: Colors.blue,
                    duration: const Duration(seconds: 1),
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
                'Ver Resultados',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 50 : 40,
            height: isSelected ? 50 : 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0052FF).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
              size: isSelected ? 26 : 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF0052FF) : const Color(0xFF637D88),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}