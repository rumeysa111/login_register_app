import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_register_app/views/login_screen.dart';
import 'package:login_register_app/views/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hoş Geldiniz',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Uygulamamıza hoş geldiniz. Devam etmek için giriş yapın veya kayıt olun.',
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LoginScreen()),);
                },
                child: Text('Giriş Yap')),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
              
            }, child: const Text('Kayıt Ol '))
          ],
        ),
      ),
    );
  }
}
