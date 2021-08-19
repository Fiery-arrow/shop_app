import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/provider/fav_provider.dart';
import 'package:shop_app/services/global_methods.dart';
import 'package:shop_app/widgets/wishlist_empty.dart';
import 'package:shop_app/widgets/wishlist_full.dart';
import '../widgets/full_cart.dart';

class WishListScreen extends StatelessWidget {
  static final routeName = "/WishListScreen";

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavProvider>(context);
    final GlobalMethods globalMethods = GlobalMethods();

    return favProvider.getFavItem.isEmpty
        ? Scaffold(
            body: WishListEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("wishList (${favProvider.getFavItem.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogs(
                        context,
                        "Clear wishList",
                        "You wishList will be clear",
                        () => favProvider.clearFav());
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: favProvider.getFavItem.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: favProvider.getFavItem.values.toList()[index],
                  child: WishlistFull(
                    favProvider.getFavItem.keys.toList()[index],
                  ),
                );
              },
            ),
          );
  }
}
