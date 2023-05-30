import 'package:hovoz/models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });
}

// You - current user
final User currentUser = User(
  id: 0,
  name: "Current User",
  imageUlr: "assets/images/eben1.jpg",
);

// Users

final User jeremie = User(
  id: 1,
  name: "Jérémie",
  imageUlr: "assets/images/jere.jpg",
);
final User justin = User(
  id: 2,
  name: "Justin",
  imageUlr: "assets/images/justin.jpg",
);
final User albert = User(
  id: 3,
  name: "Albert",
  imageUlr: "assets/images/eben2.jpg",
);
final User samuel = User(
  id: 4,
  name: "Samuel",
  imageUlr: "assets/images/sam.jpg",
);
final User leontine = User(
  id: 5,
  name: "Léontine",
  imageUlr: "assets/images/image5.jpg",
);
final User barthelemy = User(
  id: 6,
  name: "Barthélémy",
  imageUlr: "assets/images/barth.jpg",
);
final User aime = User(
  id: 7,
  name: "Aimé",
  imageUlr: "assets/images/aime.jpg",
);
final User rodrigue = User(
  id: 8,
  name: "Rodrigue",
  imageUlr: "assets/images/rod.jpg",
);
final User papa = User(
  id: 9,
  name: "Grégoire",
  imageUlr: "assets/images/papa.jpg",
);
final User maman = User(
  id: 10,
  name: "Madéleine",
  imageUlr: "assets/images/maman.jpg",
);
final User henoc = User(
  id: 11,
  name: "Henoc",
  imageUlr: "assets/images/henoc.jpg",
);

// Favorites contacts
List<User> favorites = [jeremie, samuel, justin, papa, aime, justin, maman];

// Exemples chats on home screen
List<Message> chats = [
  Message(
    sender: justin,
    time: "23:20",
    text: "Bonsoir, Bonne et agréable nuit.",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: jeremie,
    time: "22:45",
    text: "Oui, nous rendons gloire au Seigneur Jésus-Christ.",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: barthelemy,
    time: "22:33",
    text:
        "Il est chez sa mère. Si tu veux je peux te donner son numéro de téléphone",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: leontine,
    time: "19:11",
    text: "Je n'arrive pas à le croire aussi",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: papa,
    time: "15:07",
    text: "S'il te plait, j'ai trop faim. Apporte moi à manger.",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: henoc,
    time: "13:25",
    text: "As-tu chargé ma commission ?",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: maman,
    time: "08:25",
    text: "Si je finis vite, je passerai te voir.",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: samuel,
    time: "21:54",
    text: "ok boss",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: rodrigue,
    time: "08:55",
    text: "je passerai te voir.",
    isLiked: false,
    unread: false,
  ),
];

// Exemples messagesin chat screen
List<Message> messages = [
  Message(
    sender: currentUser,
    time: "08:25",
    text: "oui, Bonjour grande soeur. Et ce matin ?",
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: leontine,
    time: "08:27",
    text: "Je rends grace à Dieu. Et chez toi mon frère ?",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: "08:27",
    text: "Je vais bien aussi, Dieu merci. Et notre fille adorée ?",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: leontine,
    time: "08:29",
    text: "Elle se porte bien",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: "08:35",
    text: "Super, je lui envoie un petit coucou",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: leontine,
    time: "08:38",
    text: "Merci",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: leontine,
    time: "08:38",
    text: "Dis moi, et les affaires ?",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: "08:40",
    text: "Dieu est merveilleux grande soeur",
    isLiked: true,
    unread: true,
  ),
];
