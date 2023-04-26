
import 'package:flutter/material.dart';
import 'package:kudoz_ice/order/placeorderform.dart';
import 'package:kudoz_ice/route/routing_page.dart';
import 'package:kudoz_ice/widgets/common_button.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../widgets/dimesial.dart';
import '../widgets/single_cart_item.dart';
import '../pages/home_screen.dart';

class checkout extends StatefulWidget {
  const checkout({
    Key? key,
  }) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {

  @override
  void initState() {
    super.initState();
    Provider.of<Cartprovider>(context, listen: false).getcartData();
  }

  @override
  Widget build(BuildContext context) {
    Cartprovider cartprovider = Provider.of<Cartprovider>(context);
    cartprovider.getcartData();
    int subtotal = cartprovider.subtotal();
    int shipping_charge = 50;
    int total = subtotal + shipping_charge;
    String productList = "";

    if (cartprovider.cartlist.isEmpty) {
      setState(() {
        shipping_charge = 0;
        total = 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "Check Out",
          style:
              TextStyle(color: Color(0xffF42852), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: (){
            Routingpage.pushreplase(context: context, navigateto: btn());
          }, icon: Icon(Icons.home,color: Color(0xffF42852),))
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(Dimensions.h8),
        child: Column(
          children: [
            Expanded(
              child: cartprovider.getcartlist.isEmpty
                  ? Container(
                height: 300,
                    child: Center(
                        child: Text(
                          "Plese Select item!",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                  )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: cartprovider.getcartlist.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        var data = cartprovider.cartlist[index];
                          productList += "${data.name} = ${data.pro_Quantity},";


                        return singlecartitem(
                          name: data.name,
                          pro_image: data.pro_image,
                          price: data.price,
                          pro_Quantity: data.pro_Quantity,
                          pro_cat: data.pro_cat,
                          pro_id: data.pro_id,
                        );
                      }),
            ),
            Expanded(
                child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "₹ ${subtotal}",
                    style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Text(
                    "Shipping",
                    style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "₹ ${shipping_charge}",
                    style: TextStyle(fontSize: Dimensions.h20, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Text(
                    "Total",
                    style: TextStyle(fontSize: Dimensions.h30, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "₹ ${total}",
                    style: TextStyle(fontSize: Dimensions.h30, fontWeight: FontWeight.bold),
                  ),
                ),
                cartprovider.getcartlist.isEmpty
                    ? Text("")
                    : MyElevatedButton(
                        btnname: "Place Order",
                        onPressed: () {
                          setState(() {

                            Routingpage.gotonext(
                                context: context,
                                navigateto: placeorderform(
                                  total: total,
                                  pro_name_list: productList,
                                ));
                          });
                        },
                      )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

