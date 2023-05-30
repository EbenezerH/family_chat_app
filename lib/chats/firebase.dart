import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constants.dart';
import 'user_model.dart';

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // addUser(User userData) async {
  //   await _db.collection("users").add(userData.toMap());
  // }

  setUser(User userData) async {
    await _db.collection("users").doc(userData.id).set(userData.toMap());
  }

  setChats(String uid, Chats chats) async {
    await _db
        .collection("users")
        .doc(uid)
        .collection('chats')
        .doc(chats.chatId)
        .set(chats.toMap());
  }

  setMessages(String uid, String chatId, Message message) async {
    await _db
        .collection("users")
        .doc(uid)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }

  updateUser(User userData) async {
    await _db.collection("users").doc(userData.id).update(userData.toMap());
  }

  Future<void> deleteUser(String documentId) async {
    await _db.collection("users").doc(documentId).delete();
  }

  Future<List<User>> retrieveUser() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").get();
    return snapshot.docs
        .map((docSnapshot) => User.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Stream<List<Chats>> retrieveChats(String uid) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        _db.collection("users").doc(uid).collection('chats').orderBy('timeSent', descending: true).snapshots();

    return snapshot
        .map((event) => event.docs.map((e) => Chats.fromMap(e)).toList());
  }

  Stream<List<Message>> retrieveMesages(String uid, String idChats) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = _db
        .collection("users")
        .doc(uid)
        .collection('chats')
        .doc(idChats)
        .collection("messages")
        .orderBy('timeSent', descending: true)
        .snapshots();
    return snapshot.map((event) =>
        event.docs.map((e) => Message.fromDocumentSnapshot(e)).toList());
  }

  Future<String> getMessageId(String uid, String idChats, int index) {
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot = _db
        .collection("users")
        .doc(uid)
        .collection('chats')
        .doc(idChats)
        .collection("messages")
        .orderBy('timeSent', descending: true)
        .get();
    return snapshot.then((value) {
      var x = value.docs.elementAt(index);

      return x.id;
    });
  }

  Future<User> getUser(String id) async {
    var json = (await _db.collection('users').doc(id).get());

    String theFirstName = "";
    String theLastName = "";
    String thePhoneNumber = "";
    String theEmail = "";
    String theImageProfilePath = "";
    theFirstName = json["firstName"];
    theLastName = json["lastName"];
    thePhoneNumber = json["phoneNumber"];
    theEmail = json["email"];
    theImageProfilePath = json["imageProfilePath"];


    return User(
      id: id,
      email: theEmail,
      firstName: theFirstName,
      lastName: theLastName,
      phoneNumber: thePhoneNumber,
      imageProfilePath: theImageProfilePath
    );
  }

  Future<Chats> getChats(String uid, String idChat) async {
    var json = (await _db
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(uid)
        .get());

    String contactId = "";
    String name = "";
    String lastMessage = "";
    String timeSent = "";
    contactId = json["contactId"];
    name = json["name"];
    lastMessage = json["lastMessage"];
    timeSent = json["timeSent"];

    return Chats(
      chatId: contactId,
      name: name,
      lastMessage: lastMessage,
      timeSent: timeSent,
    );
  }

  Future<Message> getMessage(String uid, String idChat, String idMes) async {
    var json = (await _db
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .doc(idMes)
        .get());

    String text = '';
    String senderId = "";
    String receiverId = "";
    bool isReply;
    bool isRead;
    String replyMes;
    String replyMessageId = "";
    String replyMesSenderId = "";
    String timeSent = "";
    text = json["text"];
    senderId = json["senderId"];
    receiverId = json["receiverId"];
    replyMes = json["replyMes"] ?? '';
    isReply = json["isReply"] ?? false;
    isRead = json["isRead"] ?? false;
    replyMesSenderId = json['replyMesSenderId']?? '';
    replyMessageId = json["replyMessageId"] ?? '';
    timeSent = json["timeSent"] ?? '';

    return Message(text: text, senderId: senderId, receiverId: receiverId, isReply: isReply, isRead: isRead, timeSent: timeSent, replyMessageId: replyMessageId, replyMes: replyMes, replyMesSenderId: replyMesSenderId);
  }
}



addStringToSF(String kle, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(kle, value);
}

addBoolToSF(String kle, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(kle, value);
}


  getAllStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theUid = prefs.getString('uid')??'';
    theEmail = prefs.getString('email');
  }