import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //StreamBuilderのsnapshotにユーザのログイン状態情報が入ってくる。
        //情報がない=ログインしていない
        if (!snapshot.hasData) {
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
            ],
          );
        }

        //ログインされてればアプリ画面を表示する。
//        FirebaseAuth.instance.signOut();
        return const LoginScreen();

      },
    );
  }
}
