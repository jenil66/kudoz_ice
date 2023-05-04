import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kudoz_ice/cart/cart.dart';
import 'package:kudoz_ice/widgets/List_view_widget.dart';
import 'package:kudoz_ice/pages/search_page.dart';
import 'package:kudoz_ice/pages/wishlist.dart';
import 'package:kudoz_ice/route/routing_page.dart';
import 'package:kudoz_ice/widgets/constant.dart';
import 'package:provider/provider.dart';
import '../order/my_order_list.dart';
import '../provider/cart_provider.dart';
import '../widgets/details/details.dart';
import '../widgets/dimesial.dart';
import '../widgets/profile.dart';
import '../widgets/kudoz_name.dart';
import '../widgets/single_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildproduct(
      {required Stream<QuerySnapshot<Map<String, dynamic>>>? stream}) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshort) {
        if (!streamsnapshort.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: streamsnapshort.data!.docs.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              var data = streamsnapshort.data!.docs[index];
              return singleproduct(
                  pro_image: data["pro_image"],
                  pro_name: data["pro_name"],
                  pro_price: data["pro_price"],
                  pro_id: data["pro_id"],
                  cat_name: data["cat_name"],
                  onTap: () {
                    Routingpage.gotonext(
                        context: context,
                        navigateto: Details(
                            pro_image: data["pro_image"],
                            name: data["pro_name"],
                            price: data["pro_price"],
                            description: data["pro_des"],
                            pro_id: data["pro_id"],
                            pro_cat: data["cat_name"]));
                  });
            });
      },
    );
  }

  Widget buildcategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.h25,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: Dimensions.h15),
        Container(
          height: Dimensions.h120,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Category").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshort) {
              if (!streamsnapshort.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: streamsnapshort.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Listviewwidget(
                                            collection: "Category",
                                            id: streamsnapshort
                                                .data!.docs[index].id,
                                            subcollection: streamsnapshort
                                                .data!.docs[index]["cat_name"],
                                          )));
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(Dimensions.h10),
                              height: Dimensions.h120,
                              width: Dimensions.h150,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.h15),
                              ),
                              child: Stack(children: [
                                Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: greycolor.withOpacity(0.7),
                                    image: DecorationImage(
                                        image: NetworkImage(streamsnapshort
                                            .data!.docs[index]["ci"]),
                                        fit: BoxFit.fill,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.dstATop)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(Dimensions.h10),
                                ),
                                Positioned(
                                    child: Center(
                                        child: Text(
                                  streamsnapshort.data!.docs[index]["cat_name"],
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))
                              ])

                              // child: Text(CategoryList[index],style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
                              ),
                        ),
                        SizedBox(width: Dimensions.w10)
                      ],
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Cartprovider cartprovider = Provider.of<Cartprovider>(context);
    cartprovider.getcartData();
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.h8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.h10),
              CarouselSlider(
                items: [
                  Image.asset("assets/slider/slider1.jpg"),
                  Image.asset("assets/slider/slider2.jpg"),
                  Image.asset("assets/slider/slider3.jpg"),
                  Image.asset("assets/slider/slider4.jpg"),
                  Image.asset("assets/slider/slider5.jpg"),
                  Image.asset("assets/slider/slider6.jpg"),
                  Image.asset("assets/slider/slider7.jpg"),
                  Image.asset("assets/slider/slider8.jpg"),
                  Image.asset("assets/slider/slider9.jpg"),
                  Image.asset("assets/slider/slider10.jpg"),
                  Image.asset("assets/slider/slider11.jpg"),
                  Image.asset("assets/slider/slider12.jpg"),
                  Image.asset("assets/slider/slider13.jpg"),
                  Image.asset("assets/slider/slider14.jpg"),
                ],
                options: CarouselOptions(
                  animateToClosest: true,
                  height: Dimensions.h200,
                  viewportFraction: 0.6,
                  aspectRatio: 18 / 6,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: Dimensions.h10),
              buildcategory(),
              SizedBox(height: Dimensions.h10),
              Text(
                'Products',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.h25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Dimensions.h10),
              buildproduct(
                stream: FirebaseFirestore.instance
                    .collection("product")
                    .snapshots(),
              ),
              SizedBox(height: Dimensions.h10),
            ],
          ),
        ),
      ]),
    );
  }
}

class btn extends StatefulWidget {
  const btn({Key? key}) : super(key: key);

  @override
  State<btn> createState() => _btnState();
}

class _btnState extends State<btn> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    wishlish(),
    Cart(),
    myorderlist(),
    profile()
  ];

  @override
  Widget build(BuildContext context) {
    Cartprovider cartprovider = Provider.of<Cartprovider>(context);
    cartprovider.getcartData();
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: Colors.grey[900],
              title: kudozname(),
              centerTitle: true,
              leading: Image.asset("assets/kudoz.png"),
              actions: [
                IconButton(
                  onPressed: () {
                    Routingpage.gotonext(
                        context: context, navigateto: searchpage());
                  },
                  icon: Icon(
                    Icons.search_rounded,
                  ),
                )
              ],
            )
          : null,
      // drawer: drawer(),
      // backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 5, left: 7, bottom: 5, right: 7),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,

              // type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,

              selectedItemColor: Color(0xffF42852),
              iconSize: 30,
              unselectedItemColor: Colors.grey[900],
              elevation: 8.0,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  // backgroundColor: Colors.black,
                  icon: Icon(
                      _currentIndex == 0 ? Icons.home : Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_currentIndex == 1
                      ? Icons.favorite
                      : Icons.favorite_border_rounded),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(_currentIndex == 2
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined),
                      if (cartprovider.getcartlist.isNotEmpty)
                        Positioned(
                          right: 0,
                          top: -5,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xffF78A00),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${cartprovider.getcartlist.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_currentIndex == 3
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined),
                  label: 'My Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_currentIndex == 4
                      ? Icons.person_3
                      : Icons.person_3_outlined),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
