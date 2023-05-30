// ignore_for_file: unnecessary_statements, library_private_types_in_public_api, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../chats/firebase.dart';
import '../chats/user_model.dart';
import '../chats/views/messages_page.dart';
import '../constant/constants.dart';
import '../theme/theme.dart';

class ChatsOnHomeScreen extends StatefulWidget {
  final User user;
  List<User>? allUsers;
  ChatsOnHomeScreen(this.user, {super.key, this.allUsers});

  @override
  _ChatsOnHomeScreenState createState() {
    return _ChatsOnHomeScreenState();
  }
}

class _ChatsOnHomeScreenState extends State<ChatsOnHomeScreen> {
  @override
  void initState() {
    DatabaseService().retrieveChats(widget.user.id).listen((chats) {
      setState(() {
        _userChats = chats;
      });
    });
    super.initState();
  }
  
  List<Chats> _userChats = [];
  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double largeur2 = largeur / 1.02;
    return Scaffold(
      body: Column(
        children: [
          //const OnligneContacts(),
          Expanded(
            child: Container(
            margin: const EdgeInsets.all(5),
            child: StreamBuilder<List<Chats>>(
                stream: DatabaseService().retrieveChats(widget.user.id),
                builder: (BuildContext context, AsyncSnapshot<List<Chats>> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return Center(child: CircularProgressIndicator());
      default:
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final chat = snapshot.data![index];
            return FutureBuilder<User>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(chat.chatId)
                  .get()
                  .then((doc) => User.fromDocumentSnapshot(doc)),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  final user = userSnapshot.data!;
                  return 
                  // ListTile(
                  //   leading: CircleAvatar(
                  //     backgroundImage: user.imageProfilePath.isNotEmpty
                  //         ? NetworkImage(user.imageProfilePath)
                  //         : null,
                  //   ),
                  //   title: Text(user.firstName + ' ' + user.lastName),
                  //   subtitle: Text(chat.lastMessage),
                  //   onTap: () {
                  //     // Naviguer vers l'écran de la conversation
                  //   },
                  // );
                  GestureDetector(
                      child: Container(
                        color: white70,
                        margin: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                             SizedBox(
                              width: 65,
                              child: CircleAvatar(
                                backgroundColor: firstColor,
                            backgroundImage: user.imageProfilePath.isNotEmpty
                                ? NetworkImage(user.imageProfilePath)
                                : null,
                                radius: 30,
                                child: user.imageProfilePath.isNotEmpty? Container() : const Icon(Icons.person, size: 40),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data![index].name.toString(),
                                          maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: black87),
                                    ),
                                    Text(
                                      snapshot.data![index].lastMessage
                                          .toString(),
                                          maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(fontSize: 17, color: grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                                width: 50,
                                child: Text(
                                  timeSentStr(snapshot.data![index].timeSent!),
                                  style: TextStyle(fontSize: 15, color: grey),
                                ))
                          ],
                        ),
                      ),
                      onTap: () async {
                        User user2 = await DatabaseService()
                            .getUser(snapshot.data![index].chatId.toString());
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesPage(
                                widget.user,
                                receiver: user2,
                              ),
                            ));
                      },
                    );
                } else if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          
        
                      
                     /* */
                    },
                  );
                }
                }
                ),
              )
          ),
        ],
      ),
      floatingActionButton: FocusedMenuHolder( onPressed: (){}, 
      menuItems: widget.allUsers!
            .where((user2) => !_userChats.any((chat) => chat.chatId == user2.id)
             && user2.id != widget.user.id)
            .map((user2) => FocusedMenuItem(
                  title: Text("${user2.firstName} ${user2.lastName}"),
                  onPressed: () {
                    setNewChat(user2);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesPage(
                                widget.user,
                                receiver: user2,
                              ),
                            ));
                  },
                ))
            .toList(),
      openWithTap: true, 
      child: const CircleAvatar(
        radius: 27,
        backgroundColor: Color.fromARGB(255, 238, 209, 180),
         child: Icon(Icons.add),
      ),)
    );
  }

  void setNewChat(User user2) {
    DatabaseService().setChats(widget.user.id,
        Chats(chatId: user2.id, name: "${user2.firstName} ${user2.lastName}", lastMessage: ""));
    DatabaseService().setChats(
        user2.id,
        Chats(
            chatId: widget.user.id,
            name: "${widget.user.firstName} ${widget.user.lastName}",
            lastMessage: ""));
  }

  String timeSentStr(String timeSent) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeSent));

    String twoDecimal(int number) {
      String twoDecimal = number.toString();
      if (number < 10) {
        twoDecimal = "0$number";
      }
      return twoDecimal;
    }
    String time = "${twoDecimal(dateTime.hour)}:${twoDecimal(dateTime.minute)}";

    return time;
  }
}
