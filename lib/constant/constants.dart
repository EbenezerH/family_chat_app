import 'dart:math';

List slogans = [
  '"Jésus-Christ, notre seul espérance"',
  '"One family, One Heart"',
  '"La grâce de Dieu est notre partage"',
  '"Saintété, Humilité, Unité"'
];

Random random = Random();
var element = slogans[random.nextInt(slogans.length)];

String imgPath = "assets/images/";

//bool? isConnected;
int imgIndex = 0;

String theUid ="";
String? theEmail;
