// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../user_model.dart';

class ReplyMes extends StatefulWidget {
  ReplyState replyState;
  State parent;
  bool isMyMesReply;
  String receiverName;
  bool visibile;
  ReplyMes(this.replyState,
      {super.key,
      required this.parent,
      required this.isMyMesReply,
      required this.receiverName,
      this.visibile = true});

  @override
  State<ReplyMes> createState() => _ReplyMesState();
}

class _ReplyMesState extends State<ReplyMes> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        color: white,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 7),
              decoration: const BoxDecoration(
                  color: firstColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              widget.isMyMesReply
                                  ? "Vous"
                                  : widget.receiverName,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: firstColor,
                                  fontWeight: FontWeight.w800)),
                          Visibility(
                            visible: widget.visibile,
                            child: GestureDetector(
                                onTap: () {
                                  widget.parent.setState(() {
                                    widget.replyState.replyMessage = null;
                                    widget.replyState.paddingBottom = 65;
                                  });
                                },
                                child: const Icon(Icons.clear)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 1.3,
                      child: Text(
                        widget.replyState.replyMessage!.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyState {
  Message? replyMessage;
  double paddingBottom;
  ReplyState({this.replyMessage, this.paddingBottom = 65});
}
