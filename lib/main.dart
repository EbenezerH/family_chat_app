// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hovoz/chats/firebase.dart';
import 'package:hovoz/theme/theme.dart';
import 'package:hovoz/views/introduction_page.dart';
import 'package:hovoz/widgets/chats_on_home_screen.dart';
import 'package:hovoz/screens/ma_famille.dart';
import 'package:hovoz/screens/accueil.dart';
import 'package:hovoz/screens/settings.dart';
import 'package:hovoz/screens/ma_devotion.dart';
import 'package:hovoz/chats/views/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hovoz/widgets/my_drawer.dart';
import 'chats/user_model.dart';
import 'constant/constants.dart';
import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        // This is the theme of your application
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: const Color(0xFFFEF9EB)),
      ),
      home: const IntroductionPage(),
    );
  }
}

class NavBarPages extends StatefulWidget {
  final User user;
  const NavBarPages(this.user, {super.key});

  @override
  _NavBarPagesState createState() => _NavBarPagesState();
}

class _NavBarPagesState extends State<NavBarPages> {
  @override
  void initState() {
      getAllUsers();
    super.initState();
  }
  List<User>? usersList;
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    var page = [
      const Madevotion(),
      const MaFamille(),
      const Accueil(),
      ChatsOnHomeScreen(widget.user, allUsers: usersList),
      const Settings(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        
        title: Column(
          children: [
            const Text("Famille HOVOZOUNKOU",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(element,
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ))
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.nights_stay),
              iconSize: 30,
              color: Colors.blueGrey,
              onPressed: () {}),
          const Text("   ")
        ],
      ),
      drawer: MyDrawer(widget.user),
      body: WillPopScope(onWillPop: () => onWillPop(context, buildExitDialog(context)), child: page[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Color(0xFF6200EE),
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        //unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Ma Dévotion',
            icon: Icon(Icons.book_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Ma Famille',
            icon: Icon(Icons.family_restroom),
          ),
          BottomNavigationBarItem(
            label: 'Accueil',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Discussion',
            icon: Icon(Icons.messenger),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }  
  Future getAllUsers()async{
    usersList = await DatabaseService().retrieveUser();
  }
}
