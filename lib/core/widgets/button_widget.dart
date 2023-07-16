import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final Color backgroundColor;
  final double? paddingVertical;
  final Color textColor;
  final TextStyle? textStyle;
  final double marginWidth;
  final double marginHeight;
  final Color boarderColor;

  const ButtonWidget(
      {Key? key,
      required this.textColor,
      required this.boarderColor,
      this.textStyle,
      required this.text,
      this.paddingVertical,
      required this.marginHeight,
      required this.marginWidth,
      required this.action,
      required this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: marginWidth, vertical: marginHeight),
      padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: boarderColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(500.0),
        ),
      ),
      child: TextButton(
          onPressed: () {
            action();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: textStyle ?? TextStyle(color: textColor, fontSize: 15.sp),
            ),
          )),
    );
  }
}
