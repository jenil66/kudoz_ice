import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'constant.dart';
import 'dimesial.dart';


class CommonIconButton extends StatefulWidget {
  Function onPressed;
  Widget? icon;
  Color? color;
  double? iconsize;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;

  CommonIconButton({Key? key,
    required this.onPressed,
    this.icon,
    this.color,
    this.iconsize,
    this.alignment,
    this.padding,
  }) : super(key: key);

  @override
  State<CommonIconButton> createState() => _CommonIconButtonState();
}

class _CommonIconButtonState extends State<CommonIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          widget.onPressed();
        },
        icon: widget.icon ?? Icon(Icons.arrow_back_ios),
      padding: widget.padding ?? EdgeInsets.zero,
      alignment: widget.alignment ?? Alignment.center,
      iconSize: widget.iconsize ?? Dimensions.h30,
      color: widget.color ??  yellowcolor,
    );
  }
}