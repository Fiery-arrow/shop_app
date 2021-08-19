import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/bottom_bar.dart';
import 'package:shop_app/screens/upload_product_form.dart';

class MainScreens extends StatelessWidget {

  static final routeName="/MainScreens";

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomBarScreen(),
        UploadProductForm()
      ],
    );
  }
}
