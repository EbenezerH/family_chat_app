// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
//import 'package:hovoz/couleurs/mes_couleurs.dart';
import 'package:hovoz/models/article_modele.dart';
import 'package:hovoz/screens/discussion.dart';


class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double largeurC1 = largeur / 8;
    double largeurC2 = largeur / 1.8;
    double largeurC3 = largeur / 4.2; //(largeur_c1 - largeur_c2);

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
          Widget>[
        Expanded(
          child: Container(
            width: largeur,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0))),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0)),
              child: ListView.builder(
                  itemCount: listArticles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Article article = listArticles[index];

                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Discussion(
                                    user: article.sender,
                                  ))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10.0, right: 5.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: article.categorie == 'Evènement'
                                ? const Color(0x20000000)
                                : article.categorie == 'Soutien'
                                    ? const Color(0x300000ff)
                                    : article.categorie == 'Recommandation'
                                        ? const Color(0x2000ff00)
                                        : article.categorie == 'Dévotion'
                                            ? const Color(0x30ff0000)
                                            : const Color(0xeeffffff),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0))),
                        child: Column(children: <Widget>[
                          Container(
                            width: largeur,
                            padding: EdgeInsets.only(left: largeur / 30),
                            child: Text(
                              "->  ${article.titre}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: largeur / 28,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const SizedBox(width: 0),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: largeurC1,
                                      height: largeur / 8,
                                      child: CircleAvatar(
                                        //radius: 50,
                                        backgroundImage:
                                            AssetImage(article.sender.imageUlr),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    SizedBox(
                                      width: largeurC1,
                                      child: Text(
                                        article.sender.name,
                                        style: TextStyle(
                                            color: const Color(0xFF151515),
                                            fontSize: largeur / 40,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                //SizedBox(width: 10.0),
                                SizedBox(
                                  width: largeurC2, //color: Colors.white,
                                  child: Text(
                                    article.description,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: largeur / 32,
                                        fontWeight: FontWeight.normal),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4, //textAlign: TextAlign.justify,
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    padding: const EdgeInsets.only(right: 5),
                                    color: const Color(0x00000000),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0x4000aaff),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      //width: largeurC3, height: largeur/5.5,
                                      child: Image.asset(
                                        "assets/images/eben1.jpg",
                                        width: largeur / 4,
                                        height: largeur / 4,
                                      ),
                                    ))
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: largeur / 30),
                                width: largeurC2,
                                child: Text(
                                  article.categorie,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: largeur / 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              article.unread
                                  ? Container(
                                      height: largeur / 30,
                                      width: largeur / 10,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "NEW",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: largeur / 48,
                                            fontWeight: FontWeight.bold),
                                      ))
                                  : SizedBox(width: largeur / 10),
                              //SizedBox(width: largeur/22),
                              SizedBox(
                                width: largeurC3 / 0.88, //color: Colors.white,
                                child: Text(
                                  article.time,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: largeur / 45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        splashColor: Colors.lightBlueAccent,
        tooltip: 'Nouvel article',
        child: const Icon(Icons.add),
      ),
    );
  }
}
