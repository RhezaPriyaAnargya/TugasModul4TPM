import 'package:flutter/material.dart';
import 'package:tugasmodul4/model/user.dart';
import 'home_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isLoginFailed = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _login() async {
    String inputUsername = _usernameController.text.trim(); 
    String inputPassword = _passwordController.text.trim();

    if (inputUsername.isEmpty || inputPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password tidak boleh kosong!'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _isLoginFailed = false;
    });

    await Future.delayed(const Duration(seconds: 2));

   
    User? matchedUser;
    for (var user in allowedUsers) {
      if (user.username.toLowerCase() == inputUsername.toLowerCase() && user.password == inputPassword) {
        matchedUser = user;
        break;
      }
    }

    bool isValidUser = matchedUser != null;

    if (!mounted) return;

    if (isValidUser) {
      setState(() {
        _isLoading = false; 
      });
      
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => HomeScreen(username: matchedUser!.username, nim: matchedUser.NIM)),
      );
    } else {
      setState(() {
        _isLoading = false; 
        _isLoginFailed = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal: Username atau Password salah!'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _navigateToRegister() async {
    final newUser = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );

    if (newUser != null) {
      print('\n=== PARSING DATA BERHASIL DITERIMA ===');
      print('Username : ${newUser.username}');
      print('NIM      : ${newUser.NIM}');
      print('Password : ${newUser.password}');
      print('======================================\n');

      setState(() {
        allowedUsers.add(newUser); 
        
        _usernameController.text = newUser.username;
        _passwordController.text = newUser.password;
        _isLoginFailed = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi berhasil! Silakan klik MASUK.'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade900, Colors.lightBlue.shade400],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/upnLogo.png',
                          width: 100, 
                          height: 100, 
                          fit: BoxFit.contain, 
                        ),
                      ),
                      const SizedBox(height: 32),

                      Container(
                        padding: const EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Selamat Datang',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Silakan masuk untuk melanjutkan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 32),

                           
                            TextField(
                              controller: _usernameController,
                              onChanged: (value) {
                                if (_isLoginFailed) setState(() => _isLoginFailed = false);
                              },
                              decoration: InputDecoration(
                                labelText: 'Username',
                                filled: true,
                                fillColor: _isLoginFailed ? Colors.red.shade50 : Colors.grey.shade100,
                                prefixIcon: Icon(Icons.person, color: _isLoginFailed ? Colors.red : Colors.blue.shade700),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              onChanged: (value) {
                                if (_isLoginFailed) setState(() => _isLoginFailed = false);
                              },
                              decoration: InputDecoration(
                                labelText: 'Password', 
                                filled: true,
                                fillColor: _isLoginFailed ? Colors.red.shade50 : Colors.grey.shade100,
                                prefixIcon: Icon(Icons.lock, color: _isLoginFailed ? Colors.red : Colors.blue.shade700),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey.shade600,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                       
                            ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                'MASUK',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      TextButton(
                        onPressed: _isLoading ? null : _navigateToRegister,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Belum punya akun? Daftar di sini',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              color: Colors.blue.shade800,
                              strokeWidth: 4.0,
                            ),
                          ),
                          Image.asset(
                            'assets/upnLogo.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Memverifikasi Data...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newNimController = TextEditingController(); 
  final TextEditingController _newPasswordController = TextEditingController();
  bool _obscurePassword = true;

  void _register() {
    String username = _newUsernameController.text.trim();
    String nim = _newNimController.text.trim();
    String password = _newPasswordController.text.trim();

    if (username.isEmpty || nim.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username, NIM, dan Password tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    bool isUsernameExist = allowedUsers.any((user) => user.username.toLowerCase() == username.toLowerCase());
    
    if (isUsernameExist) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username sudah terdaftar, gunakan yang lain!'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

  
    User newUser = User(username: username, password: password, NIM: nim);
    
    print('\n=== MENGIRIM DATA REGISTRASI ===');
    print('Username : ${newUser.username}');
    print('NIM      : ${newUser.NIM}');
    print('Password : ${newUser.password}');
    print('================================');

    Navigator.pop(context, newUser);
  }

  @override
  void dispose() {
    _newUsernameController.dispose();
    _newNimController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: const Text('Buat Akun Baru', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.lightBlue.shade400],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_add_alt_1_rounded, size: 80, color: Colors.white),
                  const SizedBox(height: 32),
                  
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Daftar Sekarang',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Lengkapi data di bawah ini',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 32),

                    
                        TextField(
                          controller: _newUsernameController,
                          decoration: InputDecoration(
                            labelText: 'Username Baru',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            prefixIcon: Icon(Icons.person_outline, color: Colors.blue.shade700),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                      
                        TextField(
                          controller: _newNimController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'NIM Baru',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            prefixIcon: Icon(Icons.badge_outlined, color: Colors.blue.shade700),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                  
                        TextField(
                          controller: _newPasswordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password Baru',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.blue.shade700),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'DAFTAR',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
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
      ),
    );
  }
}
