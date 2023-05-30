import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

class User {
  final String id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String imageProfilePath;
  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.phoneNumber = '',
      this.imageProfilePath = ''
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  User.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()?["id"] ?? '',
        email = doc.data()?["email"] ?? '',
        firstName = doc.data()?["firstName"] ?? '',
        lastName = doc.data()?["lastName"] ?? '',
        phoneNumber = doc.data()?["phoneNumber"] ?? '',
        imageProfilePath = doc.data()?["imageProfilePath"] ?? '';

  void updateUserImageProfilePath(String userId, String imagePath) async {
  imageProfilePath = imagePath;
  await usersCollection.doc(userId).update({
    'imageProfilePath': imagePath,
  });
}
  void updateUserPhoneNumber(String userId, String thePhoneNumber) async {
    phoneNumber = thePhoneNumber;
  await usersCollection.doc(userId).update({
    'phoneNumber': thePhoneNumber,
  });
}
  void updateUserFirstName(String userId, String theFirstName) async {
    firstName = theFirstName;
  await usersCollection.doc(userId).update({
    'firstName': theFirstName,
  });
}
  void updateUserLastName(String userId, String theLastName) async {
    lastName = theLastName;
  await usersCollection.doc(userId).update({
    'firstName': theLastName,
  });
}
  void updateUserEmail(String userId, String theEmail) async {
    email = theEmail;
  await usersCollection.doc(userId).update({
    'email': theEmail,
  });
}

}

class Chats {
  final String chatId;
  final String lastMessage;
  final String? name;
  final String? timeSent;

  Chats({
    required this.chatId,
    required this.lastMessage,
    this.name,
    this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'lastMessage': lastMessage,
      'name': name,
      'timeSent': timeSent ?? DateTime.now().millisecondsSinceEpoch.toString(),
    };
  }

  Chats.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
      : chatId = doc.data()?["chatId"] ?? '',
        lastMessage = doc.data()?["lastMessage"] ?? '',
        name = doc.data()?["name"] ?? '',
        timeSent = doc.data()?["timeSent"] ?? '';
}

class Message {
  String text;
  String senderId;
  String receiverId;
  bool isRead;
  final String? timeSent;
  bool? isReply;
  String? replyMes;
  String? replyMesSenderId;
  String? replyMessageId;
  Message({
    required this.text,
    required this.senderId,
    required this.receiverId,
    this.isRead = false,
    this.timeSent,
    this.isReply,
    this.replyMes,
    this.replyMesSenderId,
    this.replyMessageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'isRead': isRead,
      'isReply': isReply,
      'replyMessageId': replyMessageId,
      'replyMes': replyMes,
      'replyMesSenderId': replyMesSenderId,
      'timeSent': timeSent ?? DateTime.now().millisecondsSinceEpoch.toString()
    };
  }

  Message.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : text = doc.data()!["text"],
        senderId = doc.data()!["senderId"],
        receiverId = doc.data()!["receiverId"],
        isRead = doc.data()!["isReply"] ?? false,
        isReply = doc.data()!["isReply"] ?? false,
        replyMessageId = doc.data()!["replyMessageId"] ?? '',
        replyMes = doc.data()!["replyMes"] ?? '',
        replyMesSenderId = doc.data()!["replyMesSenderId"] ?? '',
        timeSent = doc.data()?["timeSent"] ?? '';
}
