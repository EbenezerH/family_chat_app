// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hovoz/models/message_model.dart';
import 'package:hovoz/models/user_model.dart';
import 'package:hovoz/couleurs/mes_couleurs.dart';

class Discussion extends StatefulWidget {
  final User user;
  const Discussion({super.key, required this.user});
  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  _buildMessage(Message message, bool isMe) {
    double largeur = MediaQuery.of(context).size.width;
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 60.0)
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              //right: 80.0
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: largeur / 1.3,
      decoration: BoxDecoration(
        color: isMe
            ? Theme.of(context).colorScheme.secondary
            : const Color(0xFFFAEFFE),
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0))
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.time,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              message.text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          ]),
    );

    if (isMe) {
      return msg;
    }

    return Row(children: <Widget>[
      msg,
      IconButton(
        icon: message.isLiked
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
        iconSize: 30.0,
        color: message.isLiked ? Colors.red : Colors.black54,
        onPressed: () {},
      ),
    ]);
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 80.0,
      color: Colors.white,
      child: Row(children: <Widget>[
        Expanded(
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: "Taper un message",
              hintStyle: const TextStyle(fontSize: 15),
              prefix: const IconButton(
                icon: Icon(Icons.emoji_emotions_rounded),
                onPressed: null,
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.attach_file),
                        iconSize: 25.0,
                        onPressed: () {}),
                    IconButton(
                        icon: const Icon(Icons.camera_alt),
                        iconSize: 25.0,
                        onPressed: () {})
                  ],
                ),
              ),
            ),
          ),
        ),
        IconButton(
            icon: const Icon(Icons.mic_rounded),
            iconSize: 25.0,
            color: Colors.blue,
            onPressed: () {})
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          GestureDetector(
            child: SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 10.0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage(widget.user.imageUlr),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 15, left: 10),
                              child: Text(
                                widget.user.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              width: largeur - 250,
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                "Tap here for contact info",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ]),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                            icon: const Icon(Icons.video_call),
                            iconSize: 30.0,
                            color: Colors.blue,
                            onPressed: () {}),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                            icon: const Icon(Icons.call),
                            iconSize: 28.0,
                            color: Colors.blue,
                            onPressed: () {}),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                            icon: const Icon(Icons.more_vert),
                            iconSize: 28.0,
                            color: Colors.blue,
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                margin: const EdgeInsets.only(left: 3.0),
                width: MediaQuery.of(context).size.width / 1.015,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(blanc),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          child: ListView.builder(
                              //reverse: true,
                              padding: const EdgeInsets.only(top: 10.0),
                              itemCount: messages.length,
                              //scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final message = messages[index];
                                final bool isMe =
                                    message.sender.id == currentUser.id;
                                return _buildMessage(message, isMe);
                              }),
                        ),
                      ),
                    ),
                    _buildMessageComposer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
