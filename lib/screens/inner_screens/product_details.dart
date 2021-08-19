import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:shop_app/provider/fav_provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/wishList.dart';
import 'package:shop_app/widgets/feeds_product.dart';

import '../cart.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey previewContainer = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productData = Provider.of<Products>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavProvider>(context);

    final productList = productData.products;

    final productId = ModalRoute.of(context).settings.arguments as String;
    print(productId);

    final productAttribute = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              productAttribute.imageUrl,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.all(16.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                '${productAttribute.title}',
                                maxLines: 2,
                                style: TextStyle(
                                  // color: Theme.of(context).textSelectionColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'US \$ ${productAttribute.price}',
                              style: TextStyle(
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConst.subTitle,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21.0),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 3.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '${productAttribute.description}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 21.0,
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConst.subTitle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      _details(themeState.darkTheme, 'Brand: ',
                          '${productAttribute.brand}'),
                      _details(themeState.darkTheme, 'Quantity: ',
                          '${productAttribute.quantity}'),
                      _details(themeState.darkTheme, 'Category: ',
                          '${productAttribute.productCategoryName}'),
                      _details(themeState.darkTheme, 'Popularity: ',
                          productAttribute.isPopular ? "Popular" : "not"),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),

                      // const SizedBox(height: 15.0),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConst.subTitle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 360,
                  child: ListView.builder(
                    itemCount: productList.length < 7 ? productList.length : 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                        value: productList[index],
                        child: FeedsProduct(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "DETAIL",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                actions: <Widget>[
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
                          Navigator.of(context)
                              .pushNamed(WishListScreen.routeName);
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
                ]),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Colors.redAccent.shade400,
                      onPressed: cartProvider.getCartItem.containsKey(productId)
                          ? () {}
                          : () {
                              cartProvider.addProductToCart(
                                productId,
                                productAttribute.price,
                                productAttribute.title,
                                productAttribute.imageUrl,
                              );
                            },
                      child: Text(
                        cartProvider.getCartItem.containsKey(productId)
                            ? "In Cart"
                            : 'Add to Cart'.toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Buy now'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).textSelectionColor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConst.subTitle,
                    height: 50,
                    child: InkWell(
                      splashColor: ColorsConst.favColor,
                      onTap: () {
                        favProvider.addAndRemoveFromFav(
                          productId,
                          productAttribute.price,
                          productAttribute.title,
                          productAttribute.imageUrl,
                        );
                      },
                      child: Center(
                        child: Icon(
                          favProvider.getFavItem.containsKey(productId)
                              ? Icons.favorite
                              : MyAppIcons.wishList,
                          color: favProvider.getFavItem.containsKey(productId)
                              ? Colors.red
                              : ColorsConst.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  Widget _details(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: themeState
                  ? Theme.of(context).disabledColor
                  : ColorsConst.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
