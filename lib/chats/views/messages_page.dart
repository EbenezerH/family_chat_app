// ignore_for_file: must_be_immutable

import 'package:hovoz/chats/firebase.dart';
import 'package:hovoz/chats/user_model.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'package:swipe_to/swipe_to.dart';

import '../widgets/message_card.dart';
import '../widgets/reply_mes.dart';

class MessagesPage extends StatefulWidget {
  User user;
  User receiver;
  MessagesPage(this.user, {super.key, required this.receiver});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
  }

  String text = '';
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  ReplyState replyState = ReplyState();
  int mesIndex = 0;
  String userReplyMesID = '';
  String receiverReplyMesID = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 20,
        title: Row(
          children: [
            SizedBox(
              width: 65,
              child: CircleAvatar(
                backgroundColor: white70,
                radius: 25,
                child: const Icon(Icons.person, size: 40),
              ),
            ),
            Expanded(
              child: Text("${widget.receiver.firstName} ${widget.receiver.lastName}", 
              maxLines: 1,
              overflow: TextOverflow.ellipsis,),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: StreamBuilder<List<Message>>(
                    stream: DatabaseService().retrieveMesages(
                        widget.user.id, widget.receiver.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.active &&
                          snapshot.connectionState != ConnectionState.done) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(height: height / 3),
                              const SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting...'),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.only(
                            bottom: replyState.paddingBottom, top: 10),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];

                          return SwipeTo(
                              onRightSwipe: () {
                                focusNode.requestFocus();

                                setState(() {
                                  mesIndex = index;
                                  replyToMessage(message);
                                });

                                void replyMesID() async {
                                  userReplyMesID = await DatabaseService()
                                      .getMessageId(widget.user.id,
                                          widget.receiver.id, index);
                                  receiverReplyMesID = await DatabaseService()
                                      .getMessageId(widget.receiver.id,
                                          widget.user.id, index);
                                }

                                replyMesID();
                              },
                              child: message.isReply == false
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: isMyMessage(message)
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: !isMyMessage(message),
                                          child: ClipPath(
                                            clipper: TriangleClipper(),
                                            child: Container(
                                              color: isMyMessage(message)
                                                  ? firstColor
                                                  : grey,
                                              height: 10,
                                              width: 10,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            constraints: BoxConstraints(
                                                minWidth: width / 10,
                                                maxWidth: width / 1.3),
                                            decoration: BoxDecoration(
                                              color: isMyMessage(message)
                                                  ? firstColor
                                                  : grey,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      const Radius.circular(15),
                                                  bottomRight:
                                                      const Radius.circular(15),
                                                  topRight: isMyMessage(message)
                                                      ? const Radius.circular(0)
                                                      : const Radius.circular(
                                                          15),
                                                  topLeft: isMyMessage(message)
                                                      ? const Radius.circular(
                                                          15)
                                                      : const Radius.circular(
                                                          0)),
                                            ),
                                            child: Text(
                                              message.text,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto',
                                                color: black,
                                                decoration: TextDecoration.none,
                                              ),
                                            )),
                                        Visibility(
                                          visible: isMyMessage(message),
                                          child: ClipPath(
                                            clipper: TriangleClipper2(),
                                            child: Container(
                                              color: isMyMessage(message)
                                                  ? firstColor
                                                  : grey,
                                              height: 10,
                                              width: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : replyMesCard(message, width));
                        },
                      );
                    }),
              ),
              Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      if (replyState.replyMessage != null)
                        ReplyMes(replyState,
                            parent: this,
                            isMyMesReply: isMyMessage(replyState.replyMessage!),
                            receiverName: "${widget.receiver.firstName} ${widget.receiver.lastName}"),
                      Container(
                        color: white,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.file_present),
                            ),
                            Container(
                              width: width - 120,
                              color: white,
                              child: TextField(
                                controller: controller,
                                focusNode: focusNode,
                                minLines: 1,
                                maxLines: 7,
                                style: const TextStyle(fontSize: 17),
                                decoration: const InputDecoration(
                                  hintText: "Message",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                ),
                                onChanged: (value) => setState(() {
                                  text = value;
                                }),
                              ),
                            ),
                            const Icon(Icons.emoji_emotions),
                            IconButton(
                                onPressed: () {
                                  sendMessage(text, mesIndex);
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: firstColor,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget replyMesCard(Message message, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMyMessage(message)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Visibility(
          visible: !isMyMessage(message),
          child: ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              color: isMyMessage(message) ? firstColor : grey,
              height: 10,
              width: 10,
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 5),
            constraints:
                BoxConstraints(minWidth: width / 10, maxWidth: width / 1.3),
            decoration: BoxDecoration(
              color: isMyMessage(message) ? firstColor : grey,
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(15),
                  bottomRight: const Radius.circular(15),
                  topRight: isMyMessage(message)
                      ? const Radius.circular(0)
                      : const Radius.circular(15),
                  topLeft: isMyMessage(message)
                      ? const Radius.circular(15)
                      : const Radius.circular(0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      minWidth: width / 10, maxWidth: width / 1.4),
                  padding: const EdgeInsets.only(left: 7),
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 250, 250, 250),
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                              message.isReply == true
                                  ? message.replyMesSenderId! ==
                                          widget.user.email
                                      ? "Vous"
                                      : "${widget.receiver.firstName} ${widget.receiver.lastName}"
                                  : '',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: green,
                                  fontWeight: FontWeight.w800)),
                        ),
                        SizedBox(
                          child: Text(
                            message.isReply == true ? message.replyMes! : '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      color: black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            )),
        Visibility(
          visible: isMyMessage(message),
          child: ClipPath(
            clipper: TriangleClipper2(),
            child: Container(
              color: isMyMessage(message) ? firstColor : grey,
              height: 10,
              width: 10,
            ),
          ),
        ),
      ],
    );
  }

  bool isMyMessage(Message message) {
    bool isMe = false;
    if (message.senderId == widget.user.id) {
      isMe = true;
    }
    return isMe;
  }

  void sendMessage(String text, int index) async {
    String timeSent = DateTime.now().millisecondsSinceEpoch.toString();
    bool isReply = replyState.replyMessage == null ? false : true;
    Message? userReplyMes = isReply == true
        ? await DatabaseService().getMessage(
            widget.user.id, widget.receiver.id, userReplyMesID)
        : null;
    Message? receiverReplyMes = isReply == true
        ? await DatabaseService().getMessage(
            widget.user.id, widget.receiver.id, userReplyMesID)
        : null;

    controller.clear();
    DatabaseService().setChats(
        widget.user.id.toString(),
        Chats(
            chatId: widget.receiver.id,
            name: "${widget.receiver.firstName} ${widget.receiver.lastName}",
            lastMessage: text));

    DatabaseService().setMessages(
        widget.user.id.toString(),
        widget.receiver.id,
        Message(
          text: text,
          senderId: widget.user.id,
          receiverId: widget.receiver.id,
          timeSent: timeSent,
          isReply: isReply,
          replyMes: isReply ? userReplyMes!.text : '',
          replyMesSenderId: isReply ? userReplyMes!.senderId : '',
          replyMessageId: isReply == false ? '' : userReplyMesID,
        ));

    DatabaseService().setChats(
        widget.receiver.id.toString(),
        Chats(
            chatId: widget.user.id,
            name: "${widget.user.firstName} ${widget.user.lastName}",
            lastMessage: text));

    DatabaseService().setMessages(
        widget.receiver.id.toString(),
        widget.user.id.toString(),
        Message(
          text: text,
          senderId: widget.user.id,
          receiverId: widget.receiver.id,
          timeSent: timeSent,
          isReply: isReply,
          replyMes: isReply ? receiverReplyMes!.text : '',
          replyMesSenderId: isReply ? receiverReplyMes!.senderId : '',
          replyMessageId: isReply == false ? '' : receiverReplyMesID,
        ));

    setState(() {
      replyState.replyMessage = null;
      replyState.paddingBottom = 65;
    });
  }

  void replyToMessage(Message message) {
    setState(() {
      replyState.replyMessage = message;
      replyState.paddingBottom = 160;
    });
  }
}
