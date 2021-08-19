import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/services/global_methods.dart';
import 'package:shop_app/widgets/cart_empty.dart';
import '../widgets/full_cart.dart';

class CartScreen extends StatelessWidget {
  //the amount must be an integer
  //the amount must be at least 05 USD
  //the amount must be sent in cents

  static final routeName = "/CartScreen";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final GlobalMethods globalMethods = GlobalMethods();

    return cartProvider.getCartItem.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Cart (${cartProvider.getCartItem.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogs(
                        context,
                        "Remove Items",
                        "You cart will be clear",
                        () => cartProvider.clearCart());
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItem.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    print("${cartProvider.getCartItem.length}");
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItem.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItem.keys.toList()[index],
                      ),
                    );
                  }),
            ));
  }

  Widget checkoutSection(BuildContext ctx, double subTotal) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.red,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(ctx).textSelectionColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US \$${subTotal.toStringAsFixed(3)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
