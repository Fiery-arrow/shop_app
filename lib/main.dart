import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/theme_data.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dark_theme_provider.dart';
import 'package:shop_app/provider/fav_provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/auth/forget_password.dart';
import 'package:shop_app/screens/auth/login.dart';
import 'package:shop_app/screens/auth/sign_up.dart';
import 'package:shop_app/screens/bottom_bar.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/screens/feeds.dart';
import 'package:shop_app/screens/inner_screens/brands_navigation_rail%20copy.dart';
import 'package:shop_app/screens/inner_screens/categories_feeds.dart';
import 'package:shop_app/screens/inner_screens/product_details.dart';
import 'package:shop_app/screens/upload_product_form.dart';
import 'package:shop_app/screens/main_screen.dart';
import 'package:shop_app/screens/user_state.dart';
import 'package:shop_app/screens/wishList.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapShot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text("Error Occurred"),
              ),
            ),
          );
        }
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeData, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  routes: {
                    BrandNavigationRailScreen.routeName: (ctx) =>
                        BrandNavigationRailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    FeedsScreen.routeName: (ctx) => FeedsScreen(),
                    WishListScreen.routeName: (ctx) => WishListScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    CategoriesFeedsScreen.routeName: (ctx) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    MainScreens.routeName: (ctx) => MainScreens(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                  },
                  home: UserState(),
                );
              },
            ));
      },
    );
  }
}
