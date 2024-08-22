import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register_app/models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'İsim',
                hintText: 'İsminizi girin',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Soyad',
                hintText: 'Soyadınızı girin',
              ),
            ),
            // E-posta alanı
            SizedBox(height: 20),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-posta',
                hintText: 'E-posta adresini girin',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            // Şifre alanı
            TextField(
              controller: _passwordController,
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Şifre',
                hintText: 'Şifreyi girin',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // Şifre tekrar alanı
            TextField(
              controller: _confirmPasswordController,
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Şifre Tekrarı',
                hintText: 'Şifreyi tekrar girin',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Şifreler eşleşmiyor')),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      UserModel userModel= UserModel(
          uid: userCredential.user!.uid,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set(userModel.toMap());


      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Üyelik oluşturma hatası: $e')),
      );
    }

  }

}
