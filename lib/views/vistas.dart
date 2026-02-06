// ============================================================================
// VISTAS - Widgets de interfaz de usuario
// ============================================================================

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../controllers/controllers.dart';

// ---------- Pantalla de Login ----------
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
  final AuthController _authController = AuthController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (_authController.validateCredentials(email, password)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_authController.getErrorMessage(email, password)),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
                const SizedBox(height: 40),
                _buildTextField(
                  label: 'Correo electrónico',
                  hint: 'usuario@gmail.com',
                  controller: _emailController,
                  isPassword: false,
                  validator: _authController.validateEmail,
                ),
                const SizedBox(height: 20),
                _buildPasswordField(),
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
                  validator: _authController.validatePassword,
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

// ---------- Pantalla Principal ----------
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _selectedIndex = 0;
  bool _isTestHovered = false;
  final ResultManager _resultManager = ResultManager();

  void _navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TestsScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPerfil()),
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
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuA4DO2yOPKDC3cmgRmFZfQSRFTl_aXnrY2YXTK7Kr1I7yy-nmSTFjnhMsvLB3saicwJIt4z8DwMoixOC_Kg5V_I3L1eokXg8Aii7j0VeXyHpwGauh__wCuZdETMGIiknh9aFD9cuJOC6kJhCNkEMBuVFoc-Ysa5o4L2hN20qpqC6ID3zCPEHevyMdhFCUBFKXDH7nh7aGO8towkzUYJeBLaa0l2hv-RC8wlRZGZWcLh0V3P5cQPLE4Tfazb4jMFeL87O9lGkx2HyqlS',
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
                                  ? const Color(0xFF0052FF).withValues(alpha: 0.3)
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildCareerCard(
                              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCcIFpt9OxmhsqKarIdcM7hoFrWzUDCg1xFqSt5E5MpJoivKeT9RBV4HGoH4jmEqGmbL-7r-NUtMEJkvyqfohyofUdBAk0BHntMQ7MwLVrG1f9NbHe_3gFPMsFh94Xw9H1WCVe97098iAS1mOqUnS_mY7rGjacz_dfxK0dHPyHlNUpS-f7ENAAFdd3NOM9BRu-j6-QL9XcaicmkNelkym1zfa3b6WefMgSJavT4WwsgRSOi5LeN6q9f0OyYxui3ZBAHk6Vqsc5zCvnk',
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
                              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBFr1zXdezl1vxFCR7qgHvXVKJJWc6vDf7s_J57A16RMKXIUSq-XD506NmAUhSuVqOwHe1u18Wjc-Atdc599WvvzwLcKt-WEGDS-B3bQUuWf4EsHft0RRS8JBoGEvB9PubKZYQ9_4B3qhj7z16aIhdIBxTauXFcpz4yttdHm3DP-4A7wgaVNcOMyNq4DMswYkJ5lhY_pnzsa66mJ3FyeJQaA9rt0h0nJ3Np2PmRIKinucgmnfajN1-9U8GfIrYFJW1KX1gm58YlNDHh',
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
                              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCJFbJLYCEDTWyD5rsxe5XbxVibQ56a9Sr0d1kWBApS1KEzxwb6Zz2xRI6OFrK8USKu5qF8M-_R1EHd-oC-ddwceYOxuQ3uMy4Mro7zJ_Tjur5dvxZ0CJJFfKRDL9jed5xZK8Zrr8Qvedt6EJp1I1NJd5ONPiSIp-diRdEAhgrJ7aIJql0Xe2XZIhu1ZXXvNbVQA6RhXHJu1jWx2ItqPDp8b9OHpRKv7RhPIMUFaJhq86nX02O2itQnCScU4qWzLjtc8OfcrY37I95n',
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
    return Container(
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
        ],
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

// ---------- Tests Screen ----------
class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  int _selectedIndex = 1;
  final TestsController _testsController = TestsController();

  void _navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaHistorialEvaluaciones()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPerfil()),
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
    final tests = _testsController.getAvailableTests();
    
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
                      color: const Color(0xFF111618),
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
                      'Tests',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111618),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildTestCard(
                      category: tests[0]['category']!,
                      title: tests[0]['title']!,
                      description: tests[0]['description']!,
                      imageUrl: tests[0]['imageUrl']!,
                      onTap: () => _navigateToTest('Intereses Vocacionales', 'Test de Intereses'),
                    ),
                    const SizedBox(height: 16),
                    _buildTestCard(
                      category: tests[1]['category']!,
                      title: tests[1]['title']!,
                      description: tests[1]['description']!,
                      imageUrl: tests[1]['imageUrl']!,
                      onTap: () => _navigateToTest('Aptitudes', 'Test de Aptitudes'),
                    ),
                    const SizedBox(height: 16),
                    _buildTestCard(
                      category: tests[2]['category']!,
                      title: tests[2]['title']!,
                      description: tests[2]['description']!,
                      imageUrl: tests[2]['imageUrl']!,
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

// ---------- Test Questions Screen ----------
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
  int _selectedIndex = 1;
  int _selectedOption = 0;
  int _currentQuestion = 1;
  final int _totalQuestions = 10;
  final ResultManager _resultManager = ResultManager();
  final TestsController _testsController = TestsController();

  void _navigateToTab(int index) {
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
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPerfil()),
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
      _resultManager.addResult(widget.testType, widget.testTitle);
       
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡${widget.testTitle} completado!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
       
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: const Color(0xFF111618),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.testTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111618),
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
                  _testsController.getQuestionForTest(widget.testType, _currentQuestion),
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
                  children: List.generate(_testsController.options.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildOptionCard(
                        text: _testsController.options[index],
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
                                  : const Color(0xFF111618).withValues(alpha: 0.5),
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

// ---------- Pantalla Perfil ----------
class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  int _selectedIndex = 4;

  void _navigateToTab(int index) {
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
    } else if (index == 3) {
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
                        'Perfil',
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
                        child: Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF121617),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
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
                    const Text(
                      'Mateo Vargas',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF121617),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Estudiante',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF657C86),
                      ),
                    ),
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
              _construirItemInformacion(
                icono: Icons.email_outlined,
                titulo: 'Email',
                valor: 'mateo.vargas@email.com',
              ),
              _construirItemInformacion(
                icono: Icons.phone_outlined,
                titulo: 'Teléfono',
                valor: '+51 987 654 321',
              ),
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
              _construirItemInformacion(
                icono: Icons.school_outlined,
                titulo: 'Colegio',
                valor: 'Colegio Nacional San José',
              ),
              _construirItemInformacion(
                icono: Icons.menu_book_outlined,
                titulo: 'Grado',
                valor: '5to año de secundaria',
              ),
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

// ---------- Pantalla Recomendaciones Carreras ----------
class PantallaRecomendacionesCarreras extends StatefulWidget {
  const PantallaRecomendacionesCarreras({super.key});

  @override
  State<PantallaRecomendacionesCarreras> createState() => _PantallaRecomendacionesCarrerasState();
}

class _PantallaRecomendacionesCarrerasState extends State<PantallaRecomendacionesCarreras> {
  int _selectedIndex = 3;
  final CarrerasController _carrerasController = CarrerasController();

  void _navigateToTab(int index) {
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
        MaterialPageRoute(builder: (context) => const PantallaPerfil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final carreras = _carrerasController.getCarreras();
    
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
                      'Recomendaciones',
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
                  children: carreras.map((carrera) {
                    return _construirTarjetaCarrera(carrera: carrera);
                  }).toList(),
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

  Widget _construirTarjetaCarrera({required Carrera carrera}) {
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
                  carrera.compatibilidad,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF657C86),
                  ),
                ),
                const SizedBox(height: 4),
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
                          builder: (context) => PantallaDetallesCarrera(carrera: carrera),
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

// ---------- Pantalla Detalles Carrera ----------
class PantallaDetallesCarrera extends StatelessWidget {
  final Carrera carrera;
   
  const PantallaDetallesCarrera({super.key, required this.carrera});

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
                  children: [
                    _construirTarjetaHabilidad(
                      icono: Icons.code,
                      titulo: 'Programación',
                    ),
                    const SizedBox(height: 12),
                    _construirTarjetaHabilidad(
                      icono: Icons.storage,
                      titulo: 'Gestión de Bases de Datos',
                    ),
                    const SizedBox(height: 12),
                    _construirTarjetaHabilidad(
                      icono: Icons.gite,
                      titulo: 'Control de Versiones',
                    ),
                  ],
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Generalmente requiere una Licenciatura en Ciencias de la Computación o un campo relacionado, que toma aproximadamente 4 años completar.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF121617),
                    height: 1.5,
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'El mercado laboral para ingenieros de software es robusto, con alta demanda en varias industrias. Las oportunidades van desde startups hasta grandes corporaciones, ofreciendo salarios competitivos y potencial de crecimiento.',
                  style: TextStyle(
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
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaOfertaEducativa(carrera: carrera.nombre),
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
                        fontSize: 14,
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

  Widget _construirTarjetaHabilidad({required IconData icono, required String titulo}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFDCE2E5)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            icono,
            color: Color(0xFF121617),
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
}

// ---------- Pantalla Oferta Educativa ----------
class PantallaOfertaEducativa extends StatefulWidget {
  final String carrera;
   
  const PantallaOfertaEducativa({super.key, required this.carrera});

  @override
  State<PantallaOfertaEducativa> createState() => _PantallaOfertaEducativaState();
}

class _PantallaOfertaEducativaState extends State<PantallaOfertaEducativa> {
  int _selectedIndex = 3;
  final CarrerasController _carrerasController = CarrerasController();

  void _navigateToTab(int index) {
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
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPerfil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final instituciones = _carrerasController.getInstituciones();
    
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
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Universidades e Institutos',
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
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNk36T7u7lENmD4aoqAFegEamUZZ2-T6r-cjv8PArqrmI3jHz7Mk3rvHFZZVzyrG5knn2A-F-Q0TWYqEfHR9PB6fd68Xg-7EpmmeVaMJxc3KI6-iMri7RSRNg9gEWJ8ZbjpQQiATozleAALpByuNVRhGzrvHpXvivZgWJb9per37GnMsf7JUOKDJ6P6A23PY0K0j6XNQ8KsGgcUuAmRYg59p2x092FXGxOOOEnSBeb7NtJMvuItlUfMC59n93PQgwRUX5r3vU85y8',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: instituciones.map((institucion) {
                    return _construirItemInstitucion(
                      imagenUrl: institucion['imagenUrl']!,
                      nombre: institucion['nombre']!,
                      direccion: institucion['direccion']!,
                    );
                  }).toList(),
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
    required String imagenUrl,
    required String nombre,
    required String direccion,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 72,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imagenUrl),
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
                Text(
                  nombre,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF121617),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  direccion,
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

// ---------- Pantalla Historial Evaluaciones ----------
class PantallaHistorialEvaluaciones extends StatefulWidget {
  const PantallaHistorialEvaluaciones({super.key});

  @override
  State<PantallaHistorialEvaluaciones> createState() => _PantallaHistorialEvaluacionesState();
}

class _PantallaHistorialEvaluacionesState extends State<PantallaHistorialEvaluaciones> {
  int _selectedIndex = 2;
  final ResultManager _resultManager = ResultManager();

  void _navigateToTab(int index) {
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
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaRecomendacionesCarreras()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaPerfil()),
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
                      'Historial de Evaluaciones',
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
