import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _products = [];
      productSnapshot.docs.forEach((element) {
        _products.insert(
          0,
          Product(
            id: element.get("productId"),
            title: element.get("productTitle"),
            description: element.get("productDescription"),
            price: double.parse(element.get("price")),
            imageUrl: element.get("productImage"),
            brand: element.get("productBrand"),
            productCategoryName: element.get("productCategory"),
            quantity: int.parse(element.get("quantity")),
            isPopular: true,
          ),
        );
      });
    });
  }

  List<Product> getPopularProduct() {
    return _products.where((element) => element.isPopular).toList();
  }

  List<Product> findByCategory(String categoryName) {
    List _categoryList = _products
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> findByBrand(String brandName) {
    List _categoryList = _products
        .where((element) =>
            element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> searchQuery(String searchText) {
    List _searchList = _products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }

/* List<Product> _products = [
    Product(
        id: 'Samsung1',
        title: 'Samsung Galaxy S9',
        description:
            'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone w/ 12MP Camera - Midnight Black',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        quantity: 65,
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A10s',
        title: 'Samsung Galaxy A10s',
        description:
            'Samsung Galaxy A10s A107M - 32GB, 6.2" HD+ Infinity-V Display, 13MP+2MP Dual Rear +8MP Front Cameras, GSM Unlocked Smartphone - Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
        brand: 'Samsung ',
        productCategoryName: 'Phones',
        quantity: 1002,
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A51',
        title: 'Samsung Galaxy A51',
        description:
            'Samsung Galaxy A51 (128GB, 4GB) 6.5", 48MP Quad Camera, Dual SIM GSM Unlocked A515F/DS- Global 4G LTE International Model - Prism Crush Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        quantity: 6423,
        isPopular: true),
    Product(
        id: 'Huawei P40 Pro',
        title: 'Huawei P40 Pro',
        description:
            'Huawei P40 Pro (5G) ELS-NX9 Dual/Hybrid-SIM 256GB (GSM Only | No CDMA) Factory Unlocked Smartphone (Silver Frost) - International Version',
        price: 900.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
        brand: 'Huawei',
        productCategoryName: 'Phones',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro',
        title: 'iPhone 12 Pro',
        description:
            'New Apple iPhone 12 Pro (512GB, Gold) [Locked] + Carrier Subscription',
        price: 1100,
        imageUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro Max ',
        title: 'iPhone 12 Pro Max ',
        description:
            'New Apple iPhone 12 Pro Max (128GB, Graphite) [Locked] + Carrier Subscription',
        price: 50.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        quantity: 2654,
        isPopular: false),
    Product(
        id: 'Hanes Mens ',
        title: 'Long Sleeve Beefy Henley Shirt',
        description: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
        price: 22.30,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
        brand: 'No brand',
        productCategoryName: 'Clothes',
        quantity: 58466,
        isPopular: true),
    Product(
        id: 'Weave Jogger',
        title: 'Weave Jogger',
        description: 'Champion Mens Reverse Weave Jogger',
        price: 58.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        quantity: 84894,
        isPopular: false),
    Product(
        id: 'Adeliber Dresses for Womens',
        title: 'Adeliber Dresses for Womens',
        description:
            'Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        quantity: 49847,
        isPopular: true),
    Product(
        id: 'Tanjun Sneakers',
        title: 'Tanjun Sneakers',
        description:
            'NIKE Men\'s Tanjun Sneakers, Breathable Textile Uppers and Comfortable Lightweight Cushioning ',
        price: 191.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
        brand: 'Nike',
        productCategoryName: 'Shoes',
        quantity: 65489,
        isPopular: false)
  ];*/
}
