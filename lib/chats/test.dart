import 'package:hovoz/theme/theme.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Offset offset = const Offset(0, 50);
  Offset offset2 = const Offset(0, 200);
  bool visible = true;
  List<Offset> offsetL = [
    const Offset(0, 200),
    const Offset(0, 200),
    const Offset(0, 200)
  ];
  bool isSwipe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 600,
        child: Column(
          children: [
            Draggable(
                onDragStarted: () => visible = false,
                onDragEnd: (details) {},
                onDraggableCanceled: (velocity, offset) => visible = true,
                onDragUpdate: (details) {
                  details.localPosition.dx;
                  if (details.globalPosition.dx > 100) {}
                },
                axis: Axis.horizontal,
                feedbackOffset: offset,
                feedback: Container(
                  color: red,
                  width: 100,
                  height: 50,
                ),
                child: Visibility(
                  visible: visible,
                  child: Container(
                    color: blue,
                    height: 50,
                    width: 50,
                  ),
                )),
          ],
        ),
      ),
      /*ListView(
          children: List.generate(offsetL.length, (index) {
            return Container(
              width: 300,
              height: 200,
              color: white70,
              child: Stack(
                children: [
                  // Positioned(
                  //   left: offset.dx,
                  //   top: offset.dy,
                  //   child: GestureDetector(
                  //     onPanUpdate: (details) {
                  //       setState(() {
                  //         offset = Offset(offset.dx + details.delta.dx,
                  //             offset.dy + details.delta.dy);
                  //       });
                  //     },
                  //     child: Container(width: 100, height: 100, color: Colors.blue),
                  //   ),
                  // ),

                  // Positioned(
                  //   left: offset2.dx,
                  //   top: offset2.dy,
                  //   child: GestureDetector(
                  //     onPanUpdate: (details) {
                  //       setState(() {
                  //         offset2 =
                  //             Offset(offset2.dx + details.delta.dx, offset2.dy);
                  //         print(
                  //             "X = ${offset2.dx + details.delta.dx},\n Y= ${offset2.dy}");
                  //       });
                  //       if (offset2.dx > 60) {
                  //         isSwipe = true;
                  //       } else {
                  //         isSwipe = false;
                  //       }
                  //     },
                  //     onPanEnd: (details) {
                  //       setState(() {
                  //         offset2 = Offset(0, 200);
                  //       });
                  //     },
                  //     child: Container(width: 100, height: 100, color: green),
                  //   ),
                  // ),
                  Positioned(
                    left: offsetL[index].dx,
                    child: GestureDetector(
                      onPanEnd: (details) {
                        setState(() {
                          offsetL[index] = Offset(0, 200);
                        });
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          offsetL[index] = Offset(
                              offsetL[index].dx + details.delta.dx,
                              offsetL[index].dy);
                        });
                        if (offsetL[index].dx > 60) {
                          isSwipe = true;
                        } else {
                          isSwipe = false;
                        }
                        print(isSwipe);
                      },
                      child: Container(width: 100, height: 100, color: grey),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      */
    );
  }
}
