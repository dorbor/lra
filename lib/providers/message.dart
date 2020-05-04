import 'package:flutter/foundation.dart';

class Message with ChangeNotifier {
  final String id;
  final String name;
  final String content;
  final double number;
  //final String content;
  //bool isFavorite;

  Message({
    @required this.id,
    @required this.name,
    @required this.content,
    @required this.number,
    //@required this.imageUrl,
    //this.isFavorite = false,
  });

//  void toggleFavoriteStatus() {
//    isFavorite = !isFavorite;
//    notifyListeners();
//  }
}
