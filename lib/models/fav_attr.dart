import 'package:flutter/material.dart';

class FavAttr with ChangeNotifier {
  final String id;
  final String title;

  final double prince;
  final String imageUrl;

  FavAttr({
    this.id,
    this.title,
    this.prince,
    this.imageUrl,
  });
}
