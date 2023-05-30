// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hovoz/theme/theme.dart';

import '../chats/user_model.dart';
import '../constant/constants.dart';
import '../profile_page.dart';

class MyDrawer extends StatefulWidget {
  User user;
  MyDrawer(this.user, {Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  double drawerTextSize = 16;
  Color themeTextColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      //backgroundColor: themeFontColor,
      width: 280,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              curve: Curves.fastOutSlowIn,
              decoration: const BoxDecoration(
                //color:Color.fromARGB(255, 255, 247, 220),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    firstColor,
                    firstColor,
                    firstColor,
                  Color.fromARGB(255, 255, 173, 67),
                  Color.fromARGB(255, 255, 213, 144),
                ], )
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProfilePage(widget.user)));
                            },
                            child: Stack(
                              children: [
                                CircleAvatar(
                                    radius: 50,
                                    backgroundColor: profileIconeBb,
                                    backgroundImage: widget.user.imageProfilePath != ''
                                      ? Image.network(widget.user.imageProfilePath).image
                                        : Image.asset(
                                                "${imgPath}white_bg_image.png")
                                            .image,
                                    child: widget.user.imageProfilePath != ''
                                        ? Container()
                                        : const Icon(
                                            Icons.person,
                                            size: 80,
                                          )),
                                const Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(Icons.edit))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${widget.user.firstName} ${widget.user.lastName}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 25,
                            ),
                          ))
                
                ],
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.book,
                  color: appBarColor,
                ),
                title: Text('Rappels',
                    style: TextStyle(
                        fontSize: drawerTextSize, color: themeTextColor)),
                //subtitle: const Text("Votre Bible d'étude"),
                onTap: () {
                }),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: appBarColor,
              ),
              title: Text('Calendrier',
                  style: TextStyle(
                      fontSize: drawerTextSize, color: themeTextColor)),
              //subtitle: const Text("Le Calendrier Biblique Annuel en Français"),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => const Calendrier()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: appBarColor,
              ),
              title: Text('Favoris',
                  style: TextStyle(
                      fontSize: drawerTextSize, color: themeTextColor)),
              //subtitle: Text("Modifier le Thème"),
              onTap: null,
            ),
            ListTile(
                leading: Icon(
                  Icons.settings,
                  color: appBarColor,
                ),
                title: Text('Paramètre',
                    style: TextStyle(
                        fontSize: drawerTextSize, color: themeTextColor)),
                //subtitle: const Text("Choisir ses préférances"),
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => const Parametre()));
                }),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: appBarColor,
              ),
              title: Text('Se déconnecter',
                  style: TextStyle(
                      fontSize: drawerTextSize, color: themeTextColor)),
              onTap: () {
                  disconnectionDialog(context);
                },
            ),
            ListTile(
              leading: Icon(
                Icons.more_horiz,
                color: appBarColor,
              ),
              title: Text('A propos',
                  style: TextStyle(
                      fontSize: drawerTextSize, color: themeTextColor)),
              //subtitle: Text("En savoir plus . . ."),
              onTap: null,
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
