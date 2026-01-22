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
  
  // Lista de resultados recientes (en una app real, esto se guardaría en una base de datos)
  List<TestResult> _recentResults = [
    TestResult(
      testType: 'Aptitud Profesional',
      testTitle: 'Test de Aptitud Profesional',
      completionDate: DateTime(2024, 1, 15),
    ),
  ];
  
  // Método para agregar un nuevo resultado
  void addResult(String testType, String testTitle) {
    _recentResults.insert(0, TestResult(
      testType: testType,
      testTitle: testTitle,
      completionDate: DateTime.now(),
    ));
    
    // Mantener solo los últimos 5 resultados
    if (_recentResults.length > 5) {
      _recentResults = _recentResults.sublist(0, 5);
    }
  }
  
  // Método para obtener todos los resultados
  List<TestResult> getRecentResults() {
    return List.from(_recentResults);
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TestsScreen(selectedIndex: index)),
      ).then((_) {
        // Cuando volvemos de Tests, restaurar el índice seleccionado
        setState(() {
          _selectedIndex = 0; // Home seleccionado
        });
      });
    } else if (index >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Funcionalidad en desarrollo'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 1),
        ),
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
                              color: Color(0xFF121617),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TestsScreen(selectedIndex: 1)),
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
                            ),
                            const SizedBox(width: 12),
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBFr1zXdezl1vxFCR7qgHvXVKJJWc6vDf7s_J57A16RMKXIUSq-XD506NmAUhSuVqOwHe1u18Wjc-Atdc599WvvzwLcKt-WEGDS-B3bQUuWf4EsHft0RRS8JBoGEvB9PubKZYQ9_4B3qhj7z16aIhdIBxTauXFcpz4yttdHm3DP-4A7wgaVNcOMyNq4DMswYkJ5lhY_pnzsa66mJ3FyeJQaA9rt0h0nJ3Np2PmRIKinucgmnfajN1-9U8GfIrYFJW1KX1gm58YlNDHh',
                              title: 'Ingeniero',
                              description: 'Diseña y construye',
                            ),
                            const SizedBox(width: 12),
                            _buildCareerCard(
                              imageUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCJFbJLYCEDTWyD5rsxe5XbxVibQ56a9Sr0d1kWBApS1KEzxwb6Zz2xRI6OFrK8USKu5qF8M-_R1EHd-oC-ddwceYOxuQ3uMy4Mro7zJ_Tjur5dvxZ0CJJFfKRDL9jed5xZK8Zrr8Qvedt6EJp1I1NJd5ONPiSIp-diRdEAhgrJ7aIJql0Xe2XZIhu1ZXXvNbVQA6RhXHJu1jWx2ItqPDp8b9OHpRKv7RhPIMUFaJhq86nX02O2itQnCScU4qWzLjtc8OfcrY37I95n',
                              title: 'Arquitecto',
                              description: 'Crea diseños de edificios',
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
                          child: Text(
                            'No hay resultados recientes. ¡Completa un test!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF657C86),
                            ),
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
        print('Resultado de ${result.testType} presionado');
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
                  const SizedBox(height: 4),
                  Text(
                    'Tipo: ${result.testType}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF0052FF),
                      fontWeight: FontWeight.w500,
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
  }) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              print('Carrera $title seleccionada');
            },
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
  final int selectedIndex;
  
  const TestsScreen({super.key, required this.selectedIndex});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      
      if (index >= 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Funcionalidad en desarrollo'),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 1),
          ),
        );
      }
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
    
    if (index == 0) {
      Navigator.pop(context);
    } else if (index >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Funcionalidad en desarrollo'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 1),
        ),
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
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡${widget.testTitle} completado!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Ver Resultados',
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
              );
            },
          ),
        ),
      );
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