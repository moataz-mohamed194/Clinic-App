import 'package:flutter/material.dart';

generalAppBar({required context, required String title}){
  return AppBar(
    elevation: 0,
    leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
    title: Text(title, style: TextStyle(color: Colors.black),),
    backgroundColor: Colors.white,
  );
}