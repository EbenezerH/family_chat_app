// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hovoz/chats/firebase.dart';
import 'package:hovoz/chats/user_model.dart' as u;
import 'package:hovoz/chats/views/login.dart';
import 'package:hovoz/constant/constants.dart';
import 'package:hovoz/main.dart';
import 'package:hovoz/theme/theme.dart';

class LoadingScreen extends StatefulWidget {
  final String userId;

  const LoadingScreen({Key? key, required this.userId}): super(key: key);

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      
      if (user != null && user.uid == widget.userId) {
        // L'utilisateur est déjà connecté, on peut passer à l'étape suivante.
        u.User myUser = await DatabaseService().getUser(user.uid);
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>  NavBarPages(myUser),
          ),
        );
      } else {
        // L'utilisateur n'est pas connecté, on doit le récupérer depuis Firebase.
        // User? user = await FirebaseAuth.instance.userChanges().firstWhere(
        //     (user) => user != null && user.uid == widget.userId);
        // if (user != null) {
        //   // On a récupéré l'utilisateur, on peut passer à l'étape suivante.
        // }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Login(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            const Text("Famille HOVOZOUNKOU"),
            const SizedBox(height: 5),
            Text(element)
          ],
        ),
      ),
    );
  }
}
