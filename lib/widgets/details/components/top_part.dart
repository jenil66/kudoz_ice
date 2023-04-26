import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudoz_ice/widgets/dimesial.dart';

class TopPart extends StatelessWidget {
  const TopPart({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.h20)
          ),

        ),
      ),
    );

  }
}
