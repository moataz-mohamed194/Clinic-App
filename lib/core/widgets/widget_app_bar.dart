import 'package:flutter/material.dart';

import '../string/app_icons.dart';

WidgetAppBar(
    {String title = '',
    required context,
    bool doNotShowBackButton = false,
    bool showHomeIcon = false}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    leading: doNotShowBackButton == true && showHomeIcon == false
        ? Container()
        : doNotShowBackButton == false && showHomeIcon == false
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : Container(
                child: Image.asset(AppIcons.iconHealthCare),
                padding: EdgeInsets.all(7),
              ),
  );
}
