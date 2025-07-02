import 'package:flutter/material.dart';

class MyAppState<T> extends ChangeNotifier {
  final List<T> items;
  late T current;
  List<T> favorites = [];

  MyAppState(this.items) {
    current = items[0];
  }

  void getTravel(index) {
    current = items[index];
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
      
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
  void toggleFavoriteDelete(item) {
    if (favorites.contains(item)) {
      favorites.remove(item);
      
    }
    notifyListeners();
  }
}