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

  void _login() {
    String inputUsername = _usernameController.text.trim(); 
    String inputPassword = _passwordController.text.trim();

    // toLowerCase() digunakan agar tidak sensitif huruf besar/kecil (misal ngetik 'rheza' atau 'Rheza' tetap bisa)
    bool isValidUser = allowedUsers.any((user) => 
      user.username.toLowerCase() == inputUsername.toLowerCase() && 
      user.password == inputPassword
    );

    if (isValidUser) {
      setState(() {
        _isLoginFailed = false;
      });
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        _isLoginFailed = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal: Username atau Password salah!'),
          backgroundColor: Colors.red,
        ),
      );
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
      appBar: AppBar(
        title: const Text('Login Tugas Mobile'),
        backgroundColor: Colors.blue, 
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/upnLogo.png',
                width: 170, 
                height: 170, 
                fit: BoxFit.contain, 
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _usernameController,
                onChanged: (value) {
                  if (_isLoginFailed) {
                    setState(() => _isLoginFailed = false);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: _isLoginFailed ? Colors.red : Colors.blue),
                  prefixIcon: Icon(Icons.person, color: _isLoginFailed ? Colors.red : Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _isLoginFailed ? Colors.red : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _isLoginFailed ? Colors.red : Colors.blue, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: true,
                onChanged: (value) {
                  if (_isLoginFailed) {
                    setState(() => _isLoginFailed = false);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Password', 
                  labelStyle: TextStyle(color: _isLoginFailed ? Colors.red : Colors.blue),
                  prefixIcon: Icon(Icons.lock, color: _isLoginFailed ? Colors.red : Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _isLoginFailed ? Colors.red : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _isLoginFailed ? Colors.red : Colors.blue, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Login
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'MASUK',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}