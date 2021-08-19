import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart_attr.dart';
import 'package:shop_app/models/fav_attr.dart';

class FavProvider with ChangeNotifier {
  Map<String, FavAttr> _favItem = {};

  Map<String, FavAttr> get getFavItem => _favItem;

  void addAndRemoveFromFav(
      String productId, double price, String title, String imageUrl) {
    if (_favItem.containsKey(productId)) {
      removeItem(productId);
    } else {
      _favItem.putIfAbsent(
        productId,
        () => FavAttr(
          id: DateTime.now().toString(),
          title: title,
          prince: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _favItem.remove(productId);
    notifyListeners();
  }

  void clearFav() {
    _favItem.clear();
    notifyListeners();
  }
}
