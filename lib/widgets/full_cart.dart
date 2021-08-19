import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_attr.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/screens/inner_screens/product_details.dart';
import 'package:shop_app/services/global_methods.dart';

class CartFull extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartFull({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  });

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  GlobalMethods globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    //final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);

    final cartProvider = Provider.of<CartProvider>(context);

    double subTotal = cartAttr.prince * cartAttr.quantity;

    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductDetails.routeName, arguments: widget.productId),
      child: Container(
        height: 140,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    cartAttr.imageUrl,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${cartAttr.title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              globalMethods.showDialogs(
                                  context,
                                  "Remove Item",
                                  "Product will be removed from the cart",
                                  () => cartProvider
                                      .removeItem(widget.productId));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Entypo.cross,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cartAttr.prince}\$',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Sub Total:'),
                        SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            '${subTotal.toStringAsFixed(2)}  \$',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    // themeChange.darkTheme
                                    //     ? Colors.brown.shade900
                                    //:
                                    Theme.of(context).accentColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Ships Free',
                          style: TextStyle(
                              color:
                                  // themeChange.darkTheme
                                  // ? Colors.brown.shade900
                                  // :
                                  Theme.of(context).accentColor),
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: cartAttr.quantity < 2
                                ? () {}
                                : () {
                                    cartProvider.reduceItemByOne(
                                      widget.productId,
                                    );
                                  },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.minus,
                                  color: cartAttr.quantity < 2
                                      ? Colors.grey
                                      : Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.purple,
                                Colors.pink,
                              ], stops: [
                                0.0,
                                0.7
                              ]),
                            ),
                            child: Text(
                              '${cartAttr.quantity}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: () {
                              cartProvider.addProductToCart(
                                widget.productId,
                                cartAttr.prince,
                                cartAttr.title,
                                cartAttr.imageUrl,
                              );
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.plus,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
