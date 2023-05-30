// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../user_model.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  Message? replyMessage;
  final bool isMyMessage;
  final String userEmail;
  final String receiverEmail;
  MessageCard(this.message,
      {super.key,
      this.replyMessage,
      required this.isMyMessage,
      required this.userEmail,
      required this.receiverEmail});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return widget.message.isReply == false
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: widget.isMyMessage
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Visibility(
                visible: !widget.isMyMessage,
                child: ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    color: widget.isMyMessage ? firstColor : grey,
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(
                      minWidth: width / 10, maxWidth: width / 1.3),
                  decoration: BoxDecoration(
                    color: widget.isMyMessage ? firstColor : grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                        topRight: widget.isMyMessage
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                        topLeft: widget.isMyMessage
                            ? const Radius.circular(15)
                            : const Radius.circular(0)),
                  ),
                  child: Text(
                    widget.message.text,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      color: black,
                      decoration: TextDecoration.none,
                    ),
                  )),
              Visibility(
                visible: widget.isMyMessage,
                child: ClipPath(
                  clipper: TriangleClipper2(),
                  child: Container(
                    color: widget.isMyMessage ? firstColor : grey,
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: widget.isMyMessage
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Visibility(
                visible: !widget.isMyMessage,
                child: ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    color: widget.isMyMessage ? firstColor : grey,
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(
                      minWidth: width / 10, maxWidth: width / 1.3),
                  decoration: BoxDecoration(
                    color: widget.isMyMessage ? blue : green,
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                        topRight: widget.isMyMessage
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                        topLeft: widget.isMyMessage
                            ? const Radius.circular(15)
                            : const Radius.circular(0)),
                  ),
                  child: Column(
                    children: [
                      Text(widget.replyMessage != null
                          ? widget.replyMessage!.text
                          : "null"),
                      Text(
                        widget.message.text,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  )),
              Visibility(
                visible: widget.isMyMessage,
                child: ClipPath(
                  clipper: TriangleClipper2(),
                  child: Container(
                    color: widget.isMyMessage ? firstColor : grey,
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ],
          );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class TriangleClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper2 oldClipper) => false;
}
