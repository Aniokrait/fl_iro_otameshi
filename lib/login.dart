import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final mailAddressController = TextEditingController();
  final pwController = TextEditingController();

  Future<void> login() async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: mailAddressController.text, password: pwController.text);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> createUser() async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: mailAddressController.text, password: pwController.text);
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('this email is already used.');
      } else if (e.code == 'invalid-email') {
        print('this email address is invalid.');
      } else if (e.code == 'weak-password') {
        print('this password is weak.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: TextFormField(
                  controller: mailAddressController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'メールアドレス'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: TextFormField(
                  controller: pwController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'パスワード'),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () => login(),
                child: const Text("ログイン"),
              ),
              ElevatedButton(
                onPressed: () => createUser(),
                child: const Text("ユーザ作成"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
