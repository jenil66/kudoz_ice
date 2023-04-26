import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'dimesial.dart';


class CommonText extends StatelessWidget {
  String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  double? letterSpacing;
  double? wordSpacing;
  TextAlign? textAlign;
  int? maxLines;
  TextOverflow? overflow;

   CommonText(this.text,  {Key? key,
     this.color,
     this.fontSize,
     this.fontWeight,
     this.letterSpacing,
     this.wordSpacing,
     this.textAlign,
     this.maxLines,
     this.overflow
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text( text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        wordSpacing: wordSpacing ?? 0,
        letterSpacing: letterSpacing ?? 0 ,
        color: color ?? Colors.white,
        fontSize: fontSize ?? Dimensions.h12,
        fontWeight:fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
