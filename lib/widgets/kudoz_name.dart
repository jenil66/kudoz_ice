import 'package:flutter/cupertino.dart';

import 'dimesial.dart';

class kudozname extends StatelessWidget {
  const kudozname({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: '   Kudoz',
          style: TextStyle(fontSize: Dimensions.h25, color: Color(0xffF78A00)
          ),
          children: [
            TextSpan(
                text: '\nIcecream',
                style: TextStyle(fontSize: Dimensions.h15, color: Color(0xffF42852), fontWeight: FontWeight.normal)
            ),TextSpan(
                text: ' &',
                style: TextStyle(fontSize: Dimensions.h18,color: Color(0xffF78A00))
            ),
            TextSpan(
                text: ' Eatery',
                style: TextStyle(fontSize: Dimensions.h15, color: Color(0xffF42852), fontWeight: FontWeight.normal)
            ),
          ]),
    );
  }
}
