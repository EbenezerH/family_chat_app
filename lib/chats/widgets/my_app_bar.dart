import 'package:flutter/material.dart';
import '../../theme/theme.dart';
//import '/views/nav_bar/main_nav_bar.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  const MyAppBar(this.title, {super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(widget.title, style: TextStyle(color: textFieldBgColor)),
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: textFieldBgColor),
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ),
        //leading: Image.asset('assets/images/logo.png'),
        actions: [
          //Image.asset('assets/images/logo_nom.png'),
          //const Spacer(),
          IconButton(
              icon: Icon(
                Icons.person,
                color: textFieldBgColor,
                size: 27,
              ),
              iconSize: 20,
              color: grey,
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              }),
          IconButton(
              icon: Icon(
                darkMode == false ? Icons.dark_mode : Icons.light_mode,
                color: textFieldBgColor,
                size: 27,
              ),
              iconSize: 20,
              color: grey,
              onPressed: () {
                if (darkMode) {
                  setState(() {
                    darkMode = false;
                  });
                } else {
                  setState(() {
                    darkMode = true;
                  });
                }
                //reload();
                debugPrint(darkMode.toString());
                FocusScope.of(context).requestFocus(FocusNode());
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => MainNavBar()));
              }),
          const Text("   ")
        ],
      ),
    );
  }
}
