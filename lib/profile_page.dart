// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hovoz/chats/firebase.dart';
import 'package:hovoz/chats/user_model.dart' as u;
import 'package:hovoz/theme/theme.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'change_email_page.dart';
import 'change_password_page.dart';
import 'chats/views/login.dart';
import 'constant/constants.dart';

class ProfilePage extends StatefulWidget {
  u.User user;
  ProfilePage(this.user, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
     firstNameController.text = widget.user.firstName;
     lastNameController.text = widget.user.lastName;
     emailController.text = widget.user.email;
     phoneNumberController.text = widget.user.phoneNumber;

  }
  final _formkey = GlobalKey<FormState>();
  bool _isUploading = false;

  String phoneNumber = "";
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController =
      TextEditingController();
  TextEditingController firstNameController =
      TextEditingController();
  TextEditingController lastNameController =
      TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          title: Text("Profile", style: TextStyle(color: textFieldBgColor)),
          backgroundColor: appBarColor,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 200,
              decoration: BoxDecoration(
                  color: white,
                 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isUploading = true;
                      });
                      _getFromGallery();
                    },
                    child: CircleAvatar(
                        radius: 62,
                        backgroundColor: white,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: grey,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: widget.user.imageProfilePath != ''
                                ? Image.network(widget.user.imageProfilePath).image
                                : Image.asset("${imgPath}white_bg_image.png")
                                    .image,
                            backgroundColor: white,
                            child: Stack(
                              children: [
                                widget.user.imageProfilePath != ''
                                    ? Container()
                                    : Icon(
                                        Icons.person_rounded,
                                        size: 102,
                                        color: grey,
                                      ),
                                const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(Icons.photo_camera)),
                              ],
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 240,
                    child: Text(
                      "${widget.user.firstName} ${widget.user.lastName}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 240,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        "Modifier le profil",
                        style: TextStyle(
                          color: greyWithOpacity5,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenWidth - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: firstColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding:
                                   EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Nom",
                                  style: TextStyle(fontSize: 14, color: Colors.black54),)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: screenWidth - 100,
                            child: Text(
                              widget.user.lastName,
                              style: TextStyle(
                                  color: black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () =>
                              editFirstName(context, "Saisir Nom", lastNameController),
                          child: const Icon(Icons.edit, color: firstColor))
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(Icons.person, color: firstColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding:
                                   EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Prénom",
                                  style: TextStyle(fontSize: 14, color: Colors.black54),)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: screenWidth - 100,
                            child: Text(
                              widget.user.firstName,
                              style: TextStyle(
                                  color: black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () =>
                              editFirstName(context, "Saisir Prénom", firstNameController),
                          child: const Icon(Icons.edit, color: firstColor))
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(Icons.email, color: firstColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding:
                                   EdgeInsets.symmetric(horizontal: 10),
                              child: Text("E-mail",
                                  style: TextStyle(fontSize: 14, color: Colors.black54),)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: screenWidth - 100,
                            child: Text(
                              widget.user.email,
                              style: TextStyle(
                                  color: black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChangeEmailPage(widget.user))),
                          child:  const Icon(Icons.edit, color: firstColor))
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                       const Icon(Icons.phone, color: firstColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding:
                                   EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Numéro",
                              style: TextStyle(fontSize: 14, color: Colors.black54))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: screenWidth - 100,
                            child: Text(
                              widget.user.phoneNumber,
                              style: TextStyle(
                                  color: black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () =>
                              editPhoneNumber(context, "Nouveau Numéro"),
                          child: const Icon(Icons.edit, color: firstColor))
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      changePassword(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                         Icon(Icons.password, color: firstColor),
                        SizedBox(width: 10),
                        Padding(
                          padding:  EdgeInsets.only(top: 3),
                          child: Text(
                            "Changer le mot de passe",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      disconnectionDialog(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                         Icon(Icons.power_settings_new, color: firstColor),
                        SizedBox(width: 10),
                        Padding(
                          padding:  EdgeInsets.only(top: 3),
                          child: Text(
                            "Se déconnecter",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

Future<void> _getFromGallery() async {
    final storageReference = FirebaseStorage.instance.ref().child("${widget.user.id}/profileImage.jpg");
    String imageUrl = "";
    double progress= 0;

    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Téléchargement en cours...'),
            ],
          ),
        );
      },
    );

    final File imageFile = File(pickedFile.path);

    final uploadTask = storageReference.putFile(imageFile);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async{
      switch (taskSnapshot.state) {
        case TaskState.running:
          setState(() {
            _isUploading = true;
            progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          });
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          print("Upload error.");
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          print("successful");
          final url = await storageReference.getDownloadURL();
          imageUrl = url.toString();
          setState(() {
            widget.user.updateUserImageProfilePath(widget.user.id, imageUrl);
          });
          break;
          }
        });

        await uploadTask;
        Navigator.pop(context);

        setState(() {
          _isUploading = false;
        });
        
      }
  }
  

  Future<void> editFirstName(BuildContext context, String title, TextEditingController controller) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: white,
        title: Text(title, style: TextStyle(color: black87)),
        content: Form(
          key: _formkey,
          child: TextFormField(
            controller: controller,
            textInputAction: TextInputAction.next,
            maxLines: 2,
            decoration: InputDecoration(
              filled: true,
              fillColor: whiteTogrey,
              enabled: true,
              labelStyle: const TextStyle(color: firstColor),
              contentPadding: const EdgeInsets.only(
                  left: 10.0, right: 10, bottom: 0, top: 10),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: focusedBorderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: red),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: focusedBorderColor),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            cursorColor: focusedBorderColor,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            validator: (value) {
              if (value!.isEmpty) {
                return "Ce champ ne peut pas être vide";
              }
              if (!RegExp(r'[A-Za-zÀ-ÖØ-öø-ÿ\s]+').hasMatch(value)) {
                return ("Veuillez entrer un nom correcte");
              } else {
                return null;
              }
            },
            onChanged: (value) {},
            keyboardType: TextInputType.name,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler', style: TextStyle(fontSize: 17)),
          ),
          TextButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                if(controller == firstNameController){
                  widget.user.updateUserFirstName(widget.user.id, controller.text);
                }else if(controller == lastNameController){
                  widget.user.updateUserLastName(widget.user.id, controller.text);
                }
                Navigator.of(context).pop();
              } else {
                return;
              }
            },
            child: const Text('Sauvegarder', style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }

  Future<void> editPhoneNumber(BuildContext context, String title) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: white,
        title: Text(title, style: TextStyle(color: black87)),
        content: Form(
          key: _formkey,
          child: IntlPhoneField(
            pickerDialogStyle: PickerDialogStyle(
                searchFieldInputDecoration: InputDecoration(
                    filled: true,
                    fillColor: whiteTogrey,
                    suffixIcon: const Icon(Icons.search, color: Colors.black87),
                    labelText: "Chercher un pays",
                    labelStyle: const TextStyle(color: Colors.black87)),
                searchFieldCursorColor: Colors.white,
                backgroundColor: white,
                countryCodeStyle: TextStyle(color: black87),
                countryNameStyle: TextStyle(color: black87)),
            controller: phoneNumberController,
            decoration: InputDecoration(
              filled: true,
              fillColor: whiteTogrey,
              labelText: 'Phone Number',
              labelStyle: const TextStyle(color: firstColor),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: focusedBorderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: red),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: focusedBorderColor),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            cursorColor: focusedBorderColor,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            initialCountryCode: 'BJ',
            onChanged: (phone) {
              debugPrint(phone.completeNumber);
              phoneNumber = phone.completeNumber;
            },
            onCountryChanged: (phone) {},
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler', style: TextStyle(fontSize: 17)),
          ),
          TextButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                widget.user.updateUserPhoneNumber(widget.user.id, phoneNumber);
                Navigator.of(context).pop();
              } else {
                return;
              }
            },
            child: const Text('Sauvegarder', style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }

  Future<void> changePassword(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: white,
        title: Text("Confirmation", style: TextStyle(color: black87)),
        content: Text("Voulez-vous changer le mot de passe ?",
            style: TextStyle(fontSize: 16, color: black87)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('non', style: TextStyle(fontSize: 17)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChangePasswordPage(widget.user)));
            },
            child: const Text('oui', style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
//save the phone number and the code separatly


AlertDialog _buildExitDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: white,
    title: Text('Confirmation', style: TextStyle(color: black87)),
    content: Text("Voulez-vous vous déconnecter ?",
        style: TextStyle(color: black87)),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: const Text('Non', style: TextStyle(fontSize: 17)),
      ),
      TextButton(
        onPressed: () async{
          final credential =
            await FirebaseAuth.instance.signOut();
          
          addBoolToSF('isConnected', false);
          Navigator.of(context).pop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false,
          );
        },
        child: const Text('Oui', style: TextStyle(fontSize: 17)),
      ),
    ],
  );
}

Future<void> disconnectionDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => _buildExitDialog(context),
  );
}
