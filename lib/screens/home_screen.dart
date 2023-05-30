// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hovoz/widgets/category_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                  //topLeft: Radius.circular(30.0),
                  //topRight: Radius.circular(30.0),
                  ),
            ),
            child: Column(
              children: const <Widget>[
                //FavoritesContacts(),
                //ChatsOnHomeScreen(),
              ],
            ),
          )),
          const CategorySelector()
        ],
      ),
    );
  }
}
