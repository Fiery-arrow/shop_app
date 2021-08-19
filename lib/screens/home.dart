import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/feeds.dart';
import 'package:shop_app/screens/inner_screens/brands_navigation_rail%20copy.dart';
import 'package:shop_app/widgets/backlayer.dart';
import 'package:shop_app/widgets/category.dart';
import 'package:shop_app/widgets/popular_products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List carouselImage = [
    "assets/images/carousel1.png",
    "assets/images/carousel2.jpeg",
    "assets/images/carousel3.jpg",
    "assets/images/carousel4.png"
  ];

  List _brandImage = [
    "assets/images/addidas.jpg",
    "assets/images/apple.jpg",
    "assets/images/dell.jpg",
    "assets/images/h&m.jpg",
    "assets/images/nike.jpg",
    "assets/images/samsung.jpg",
    "assets/images/huawei.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    final popularItem = productData.getPopularProduct();

    productData.fetchProducts();

    return Scaffold(
      body: Center(
        child: BackdropScaffold(
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          headerHeight: MediaQuery.of(context).size.height * 0.25,
          appBar: BackdropAppBar(
            title: Text("Home"),
            leading: BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                ColorsConst.starterColor,
                ColorsConst.endColor
              ])),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                iconSize: 15,
                padding: EdgeInsets.all(10),
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(
                      "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg",
                    ),
                  ),
                ),
              ),
            ],
          ),
          backLayer: BackLayerMenu(),
          frontLayer: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  child: Carousel(
                    boxFit: BoxFit.fill,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 12000),
                    dotSize: 5.0,
                    dotIncreasedColor: Colors.purple,
                    dotBgColor: Colors.black.withOpacity(0.2),
                    dotPosition: DotPosition.bottomCenter,
                    showIndicator: true,
                    indicatorBgPadding: 5.0,
                    images: [
                      Image.asset(carouselImage[0]),
                      Image.asset(carouselImage[1]),
                      Image.asset(carouselImage[2]),
                      Image.asset(carouselImage[3]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Category exist",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (BuildContext ctx, int index) {
                      return CategoryWidget(index);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Popular brands",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      Spacer(),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Swiper(
                    itemCount: _brandImage.length,
                    autoplay: true,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    onTap: (index) {
                      Navigator.of(context).pushNamed(
                        BrandNavigationRailScreen.routeName,
                        arguments: {
                          index,
                        },
                      );
                    },
                    itemBuilder: (BuildContext ctx, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.blueGrey,
                          child: Image.asset(
                            _brandImage[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Popular Products",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      Spacer(),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(FeedsScreen.routeName,
                              arguments: "popular");
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 285,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularItem.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: popularItem[index],
                        child: PopularProducts(),
                      );
                    },
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
