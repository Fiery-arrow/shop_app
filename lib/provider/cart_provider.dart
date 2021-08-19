import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart_attr.dart';


class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItem = {};

  Map<String, CartAttr> get getCartItem => _cartItem;
  double get totalAmount {
    var total = 0.0;
    _cartItem.forEach((key, value) {
      total += value.prince * value.quantity;
    });
    return total;
  }

  void addProductToCart(
      String productId, double price, String title, String imageUrl) {
    if (_cartItem.containsKey(productId)) {
      _cartItem.update(
        productId,
        (existingCartItem) => CartAttr(
          id: existingCartItem.id,
          title: existingCartItem.title,
          prince: existingCartItem.prince,
          quantity: existingCartItem.quantity + 1,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      _cartItem.putIfAbsent(
        productId,
        () => CartAttr(
          id: DateTime.now().toString(),
          title: title,
          prince: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void reduceItemByOne(String productId) {
    _cartItem.update(
      productId,
      (existingCartItem) => CartAttr(
        id: existingCartItem.id,
        title: existingCartItem.title,
        prince: existingCartItem.prince,
        quantity: existingCartItem.quantity - 1,
        imageUrl: existingCartItem.imageUrl,
      ),
    );
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItem.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItem.clear();
    notifyListeners();
  }
}
