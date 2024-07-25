import 'package:flutter/material.dart';

class FavouriteItem {
  final String imagePath;
  final String name;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int balconies;

  FavouriteItem({
    required this.imagePath,
    required this.name,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.balconies,
  });
}

class FavouritesProvider with ChangeNotifier {
  List<FavouriteItem> _favouriteItems = [];

  List<FavouriteItem> get favouriteItems => _favouriteItems;

  void addFavourite(FavouriteItem item) {
    _favouriteItems.add(item);
    notifyListeners();
  }

  void removeFavourite(FavouriteItem item) {
    _favouriteItems.remove(item);
    notifyListeners();
  }
}
