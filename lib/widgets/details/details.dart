import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/pages/home_screen.dart';
import 'package:kudoz_ice/route/routing_page.dart';

import '../../widgets/dimesial.dart';
import 'components/second_part.dart';
import 'components/top_part.dart';

class Details extends StatelessWidget {
   Details(
      {Key? key,
      required this.pro_image,
      required this.name,
      required this.price,
      required this.description,
      required this.pro_id,
      required this.pro_cat,
  })
      : super(key: key);
  final String pro_image;
  final String name;
  final int price;
  final String pro_id;
  final String description;
  final String pro_cat;

  @override
  Widget build(BuildContext context) {
    print(pro_id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(name,style: TextStyle(color: Color(0xffF42852),fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Routingpage.pushreplase(context: context, navigateto: btn());
          }, icon: Icon(Icons.home,color: Color(0xffF42852),))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.w10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopPart(
                image: pro_image,
              ),
              SecondPart(
                name: name,
                price: price,
                description: description,
                pro_id: pro_id,
                pro_image: pro_image,
                  pro_Quantity:1,
                  pro_cat: pro_cat
              )
            ],
          ),
        ),
      ),
    );
  }
}
