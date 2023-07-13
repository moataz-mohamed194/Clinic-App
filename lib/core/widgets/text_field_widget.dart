import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../string/app_color.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controler;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final bool? obscureText;
  final String? oldData;

  final TextInputType? keyboardType;
  final FormFieldValidator? validatorTextField;

  const TextFieldWidget(
      {this.rightWidget,
      this.obscureText,
      this.oldData,
        this.leftWidget,
      this.keyboardType,
      required this.hintText,
      this.controler,
      this.validatorTextField});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            controller: controler,
            keyboardType: keyboardType,
            initialValue: oldData,
            validator: (val) => validatorTextField!(val),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),

                  borderSide: BorderSide(color:  AppColors.mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),

                  borderSide: BorderSide(color:Colors.transparent),
                ),
                suffixIcon: rightWidget,
                filled: true,
                prefixIcon:leftWidget,
                fillColor: Colors.grey.shade200,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15.sp)),
            obscureText: obscureText ?? false),
      ],
    );
  }
}
