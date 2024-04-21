import 'package:flutter/foundation.dart';

class Favorites extends ChangeNotifier {
  List<dynamic> _favorites = [];

  List<dynamic> get favorites => _favorites;

  void addToFavorites(dynamic item) {
    _favorites.add(item);
    notifyListeners();
  }

  void removeFromFavorites(dynamic item) {
    _favorites.remove(item);
    notifyListeners();
  }
}
