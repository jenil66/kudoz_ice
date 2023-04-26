import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../route/routing_page.dart';
import 'common_text.dart';
import 'constant.dart';
import 'dimesial.dart';

class CommonButton extends StatefulWidget {
  String name;
  BorderRadiusGeometry? borderRadius;
  EdgeInsetsGeometry? margin;
  Function onPressed;
  double? height;
  double? width;
  Color? color;
  double? fontsize;
  AlignmentGeometry? alignment;

  CommonButton(
      {Key? key,
      required this.name,
      this.borderRadius,
      this.margin,
      this.alignment,
      this.height,
      this.width,
      this.color,
      this.fontsize,
      required this.onPressed})
      : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.only(),
      width: widget.width ?? 900,
      height: widget.height ?? Dimensions.h55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(10)),
          backgroundColor: widget.color ?? yellowcolor,
        ),
        onPressed: () {
          widget.onPressed();
        },
        child: CommonText(
          widget.name,
          color: Colors.white,
          fontSize: widget.fontsize ?? Dimensions.h12,
        ),
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton(
      {Key? key, required this.btnname, required this.onPressed})
      : super(key: key);
  final String btnname;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.h50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff333333),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h12)),
          ),
          child: Text(btnname)),
    );
  }
}


