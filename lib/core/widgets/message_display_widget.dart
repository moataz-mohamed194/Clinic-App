import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;
  final bool? typeOfLogin;

  const MessageDisplayWidget(
      {Key? key, required this.message, this.typeOfLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
          child: SingleChildScrollView(
        child: Text(
          message,
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      )),
    );
  }
}
