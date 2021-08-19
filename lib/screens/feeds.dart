import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/fav_provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/wishList.dart';
import 'package:shop_app/widgets/feeds_product.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'cart.dart';

class FeedsScreen extends StatelessWidget {
  static final routeName = "/FeedsScreen";

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context).settings.arguments as String;
    final productsProvider = Provider.of<Products>(context);
    List<Product> productsList = productsProvider.products;

    if (popular == "popular") {
      productsList = productsProvider.getPopularProduct();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text("Feeds"),
        actions: [
          Consumer<FavProvider>(
            builder: (_, fav, child) => Badge(
              badgeColor: ColorsConst.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                fav.getFavItem.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.wishList,
                  color: ColorsConst.favColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(WishListScreen.routeName);
                },
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, child) => Badge(
              badgeColor: ColorsConst.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                cart.getCartItem.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.cart,
                  color: ColorsConst.cartColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 440,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(productsList.length, (index) {
          return ChangeNotifierProvider.value(
            value: productsList[index],
            child: FeedsProduct(),
          );
        }),
      ),
//         StaggeredGridView.countBuilder(
//           padding: ,
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) =>FeedProducts(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
    );
  }
}
