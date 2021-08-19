import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/fav_provider.dart';
import 'package:shop_app/screens/inner_screens/product_details.dart';

class PopularProducts extends StatelessWidget {
/*  final String imageUrl;
  final String title;
  final String description;
  final double price;

  PopularProducts(this.imageUrl, this.title, this.description, this.price);*/

  @override
  Widget build(BuildContext context) {
    final popularAttribute = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetails.routeName,
                arguments: popularAttribute.id),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(popularAttribute.imageUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Entypo.star,
                        color: favProvider.getFavItem
                                .containsKey(popularAttribute.id)
                            ? Colors.red
                            : Colors.grey.shade800,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Entypo.star_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          "\$ ${popularAttribute.price}",
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${popularAttribute.title}",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "${popularAttribute.description}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: cartProvider.getCartItem
                                        .containsKey(popularAttribute.id)
                                    ? () {}
                                    : () {
                                        cartProvider.addProductToCart(
                                          popularAttribute.id,
                                          popularAttribute.price,
                                          popularAttribute.title,
                                          popularAttribute.imageUrl,
                                        );
                                      },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    cartProvider.getCartItem
                                            .containsKey(popularAttribute.id)
                                        ? MaterialCommunityIcons.check_all
                                        : MaterialCommunityIcons.cart_plus,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
