// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profils",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 6.0, bottom: 12.0, left: 22.0, right: 22.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/images/logo.jpg"),
                    ),
                    Column(
                      children: const [
                        Text(
                          "Edit",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Enter your name and add an optional \n"
                        " profile picture",
                      ),
                    ]),
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
            Column(
              children: const [Text("Fabrice CERCO IA")],
            ),
            const Divider(
              height: 10.0,
              indent: 5.0,
              color: Colors.black87,
            ),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "Phone Number",
                    style: TextStyle(backgroundColor: Colors.grey),
                  ),
                ),
                Divider(
                  height: 10.0,
                  indent: 5.0,
                  color: Colors.black87,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text("+229 65 98 67 14"),
                ),
              ],
            ),
            const Divider(
              height: 10.0,
              indent: 5.0,
              color: Colors.black87,
            ),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text("ABOUT"),
                ),
                Divider(
                  height: 10.0,
                  indent: 5.0,
                  color: Colors.black87,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text("CERCO IA"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
