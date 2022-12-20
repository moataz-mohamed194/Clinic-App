import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdWidgets extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AdWidgets();
  }

}

class _AdWidgets extends State<AdWidgets>{

  late BannerAd x;
  @override
  void initState() {
    super.initState();
    x= BannerAd(
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener()
    );
    x.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: AdWidget(ad: x),
    );
  }

}