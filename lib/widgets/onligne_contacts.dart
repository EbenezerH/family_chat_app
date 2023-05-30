import 'package:flutter/material.dart';
import 'package:hovoz/models/message_model.dart';
import 'package:hovoz/screens/discussion.dart';

class OnligneContacts extends StatelessWidget {
  const OnligneContacts({super.key});

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    double screenSize = hauteur / largeur;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "On ligne",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.more_horiz),
                    iconSize: 30,
                    color: Colors.blueGrey,
                    onPressed: () {}),
              ],
            ),
          ),
          SizedBox(
            height: 105,
            //color: Colors.indigo,
            child: ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Discussion(
                                  user: favorites[index],
                                ))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(children: <Widget>[
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage(favorites[index].imageUlr),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          favorites[index].name,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
