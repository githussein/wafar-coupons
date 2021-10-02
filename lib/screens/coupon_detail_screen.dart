import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/coupons_provider.dart';

class CouponDetailScreen extends StatelessWidget {
  static const routeName = '/coupon-details';

  @override
  Widget build(BuildContext context) {
    //extract data of the coupon using th ID
    final String couponId =
        ModalRoute.of(context).settings.arguments as String; //the id

    //access the coupon data, listen only the first time
    final loadedCoupon =
        Provider.of<CouponsProvider>(context, listen: true).findById(couponId);

    // final coursePrice = Container(
    //   padding: const EdgeInsets.all(7.0),
    //   decoration: BoxDecoration(
    //       border: Border.all(color: Colors.white),
    //       borderRadius: BorderRadius.circular(5.0)),
    //   child: Text(
    //     loadedCoupon.id,
    //     style: TextStyle(color: Colors.white),
    //   ),
    // );

    // final topContentText = Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     SizedBox(height: 120.0),
    //     Text(
    //       loadedCoupon.title,
    //       style: TextStyle(color: Colors.white, fontSize: 45.0),
    //     ),
    //     SizedBox(height: 30.0),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         Expanded(
    //             flex: 6,
    //             child: Padding(
    //                 padding: EdgeInsets.only(left: 10.0),
    //                 child: Text(
    //                   loadedCoupon.id,
    //                   style: TextStyle(color: Colors.white),
    //                 ))),
    //         Expanded(flex: 1, child: coursePrice)
    //       ],
    //     ),
    //   ],
    // );

    final topContent = Container(
      margin: EdgeInsets.all(10),
      child: CircleAvatar(
        backgroundImage: NetworkImage(loadedCoupon.imageUrl),
        minRadius: 30,
        maxRadius: 70,
      ),
    );
    // Stack(
    //   children: <Widget>[
    //     Container(
    //         margin: EdgeInsets.all(10),
    //         padding: EdgeInsets.only(left: 10.0),
    //         height: MediaQuery.of(context).size.height * 0.3,
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: NetworkImage(loadedCoupon.imageUrl),
    //             fit: BoxFit.fitHeight,
    //           ),
    //         )),
    //
    //
    //     // Container(
    //     //   height: MediaQuery.of(context).size.height * 0.5,
    //     //   padding: EdgeInsets.all(40.0),
    //     //   width: MediaQuery.of(context).size.width,
    //     //   // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
    //     //   child: Center(
    //     //     child: topContentText,
    //     //   ),
    //     // ),
    //     // Positioned(
    //     //   left: 8.0,
    //     //   top: 60.0,
    //     //   child: InkWell(
    //     //     onTap: () {
    //     //       Navigator.pop(context);
    //     //     },
    //     //     child: Icon(Icons.arrow_back, color: Colors.white),
    //     //   ),
    //     // )
    //   ],
    // )

    final bottomContentTitle = Text(
      loadedCoupon.title,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );

    final bottomContentCode = RaisedButton(
      child: Container(
        width: 100,
        child: Row(
          children: [
            Text(
              loadedCoupon.code,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Icon(Icons.copy),
          ],
        ),
      ),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: loadedCoupon.code)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "تم نسخ الكود",
            textAlign: TextAlign.center,
          )));
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).primaryTextTheme.button.color,
    );

    final space = Divider(height: 30);
    final bottomContentText = Text(
      loadedCoupon.description,
      style: TextStyle(fontSize: 18.0),
    );

    void _launchURL() async => await canLaunch(loadedCoupon.link)
        ? await launch(loadedCoupon.link)
        : throw 'Could not launch ';

    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          onPressed: _launchURL,
          color: Theme.of(context).primaryColor,
          child: Text('Start shopping', style: TextStyle(color: Colors.white)),
        ));

    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentTitle,
            space,
            bottomContentCode,
            space,
            bottomContentText,
            space,
            readButton
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).coupon_details),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}
