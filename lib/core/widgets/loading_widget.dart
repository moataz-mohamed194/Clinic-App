import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          child: Lottie.asset('assets/json/loading.json'),
        ),
      ),
    );
  }
}
