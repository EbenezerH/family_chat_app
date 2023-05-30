// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:hovoz/chats/views/messages_page.dart';
import 'package:flutter/material.dart';
import '../firebase.dart';
import '../user_model.dart';
import '../../theme/theme.dart';
import '../widgets/my_app_bar.dart';

// ignore: must_be_immutable
class ChatsPage extends StatefulWidget {
  User user;
  ChatsPage({super.key, required this.user});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: MyAppBar("Conversations"),
        ),
        body: Container(
            margin: const EdgeInsets.all(5),
            child: StreamBuilder<List<Chats>>(
                stream: DatabaseService().retrieveChats(widget.user.email),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active &&
                      snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: Column(
                        children: const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting...'),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      child: Container(
                        color: white70,
                        margin: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 65,
                              child: CircleAvatar(
                                backgroundColor: firstColor,
                                radius: 30,
                                child: Icon(Icons.person, size: 40),
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
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: black87),
                                    ),
                                    Text(
                                      snapshot.data![index].lastMessage
                                          .toString(),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesPage(
                                widget.user,
                                receiver: user2,
                              ),
                            ));
                      },
                    ),
                  );
                })),
        floatingActionButton: ElevatedButton(
            onPressed: () async {
              // DatabaseService().setUser(User(
              //   id: "myah@gmail.com",
              //   email: "myah@gmail.com",
              //   fullName: "MYAH IT",
              //   phoneNumber: "60110011",
              // ));

              // List<Message> listChat = await DatabaseService()
              //     .retrieveMesages(widget.myUser.id, "chat1");
              // List<String> chatsName = [];
              // for (var element in listChat) {
              //   chatsName.add(element.text);
              // }
              // print(chatsName);

              // try {
              //   final credential = await FirebaseAuth.instance
              //       .createUserWithEmailAndPassword(
              //     email: "myah@gmail.com",
              //     password: "123456",
              //   );
              // } on FirebaseAuthException catch (e) {
              //   if (e.code == 'weak-password') {
              //   } else if (e.code ==
              //       'email-already-in-use') {}
              // } catch (e) {}

              // MyUser user =
              //     await DatabaseService().getUser("02");
              // print(user.email);

              setNewChat(await DatabaseService().getUser("myah@gmail.com"));
            },
            child: const Text("Print name")));
  }

  void setNewChat(User user2) {
    DatabaseService().setChats(widget.user.email,
        Chats(chatId: user2.email, name: user2.firstName, lastMessage: ""));
    DatabaseService().setChats(
        user2.email,
        Chats(
            chatId: widget.user.email,
            name: widget.user.firstName,
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
