import 'package:hovoz/models/message_model.dart';
import 'package:hovoz/models/user_model.dart';

class Article {
  final User sender;
  final String time;
  final String categorie;
  final String titre;
  final String description;
  final bool isLiked;
  final bool unread;

  Article({
    required this.sender,
    required this.time,
    required this.categorie,
    required this.titre,
    required this.description,
    required this.isLiked,
    required this.unread,
  });
}

List<Article> listArticles = [
  Article(
    sender: justin,
    time: "18:25",
    titre: "Mariage entre Barthélémy et Christianna",
    description:
        "Nous anonçons à tous que la dâte officielle du mariage entre Barthélémy et Christianna est déjà fixée. Cela la se tiendra le 28 février prochain. Que Dieu nous aide à réussir cet évennement pour la gloire de non nom.",
    isLiked: false,
    unread: true,
    categorie: 'Evènement',
  ),
  Article(
    sender: barthelemy,
    time: "22:45",
    titre: "Soutien au frère Ebénézer pour sa soutenance",
    description:
        'Dans un mois, le frere Ebénézer va faire un pas dans sa vie. Soutenons le pour sa soutenance.',
    isLiked: false,
    unread: true,
    categorie: 'Soutien',
  ),
  Article(
    sender: leontine,
    time: "19:11",
    titre: "Uniforme des membres de la famille pour le jour du mariage",
    description:
        "Comment allons-nous organiser le prochain mariage ? concernant l'uniforme à porter, moi je pense à un witefine. Comment allons-nous organiser le prochain mariage ? concernant l'uniforme à porter, moi je pense à un witefine. Comment allons-nous organiser le prochain mariage ? concernant l'uniforme à porter, moi je pense à un witefine. ",
    isLiked: false,
    unread: false,
    categorie: 'Recommandation',
  ),
  Article(
    sender: samuel,
    time: "17:41",
    titre: "Cérémonie de sortie d'enfant",
    description: "Moi je propose les witefine-look. ",
    isLiked: false,
    unread: false,
    categorie: 'Evènement',
  ),
  Article(
    sender: aime,
    time: "15:07",
    titre: "La foi qui tranforme les montagnes",
    description:
        "La foi est un grand don pour nous les enfants de Dieu mais malheureusement, beaucoup ne l'on pas encore compris.",
    isLiked: false,
    unread: false,
    categorie: 'Dévotion',
  ),
];
