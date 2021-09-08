import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/OffersProvider.dart';

class BannerSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //access the offer data, list of offers
    final offersData = Provider.of<OffersProvider>(context, listen: false);

    //store the list of offers
    final offers = offersData.items;

    // final double categoryHeight = MediaQuery.of(context).size.height * 0.2;
    // final double categoryWidth = 120.0;
    // final double cardInnerSpace = 12.0;
    // return SingleChildScrollView(
    //   physics: BouncingScrollPhysics(),
    //   scrollDirection: Axis.horizontal,
    //   child: Container(
    //     margin: const EdgeInsets.symmetric(vertical: 10),
    //     child: FittedBox(
    //       fit: BoxFit.fill,
    //       alignment: Alignment.topCenter,
    //       child: Row(
    //         children: <Widget>[
    //           Container(
    //             width: categoryWidth,
    //             padding: EdgeInsets.all(15),
    //             margin: EdgeInsets.only(right: 10),
    //             height: categoryHeight,
    //             decoration: BoxDecoration(
    //               color: Colors.blue.shade200,
    //               shape: BoxShape.circle,
    //             ),
    //             child: InkWell(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //     context,
    //                 //     MaterialPageRoute(
    //                 //         builder: (context) => DoctorsScreen()));
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.all(cardInnerSpace),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Image.asset('assets/images/doctor.png'),
    //                     Text(
    //                       'doctors',
    //                       style: TextStyle(fontSize: 14, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: categoryWidth,
    //             padding: EdgeInsets.all(15),
    //             margin: EdgeInsets.only(right: 10),
    //             height: categoryHeight,
    //             decoration: BoxDecoration(
    //               color: Colors.blue.shade200,
    //               shape: BoxShape.circle,
    //             ),
    //             child: InkWell(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //     context,
    //                 //     MaterialPageRoute(
    //                 //         builder: (context) => DoctorsScreen()));
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.all(cardInnerSpace),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Image.asset('assets/images/doctor.png'),
    //                     Text(
    //                       'doctors',
    //                       style: TextStyle(fontSize: 14, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: categoryWidth,
    //             padding: EdgeInsets.all(15),
    //             margin: EdgeInsets.only(right: 10),
    //             height: categoryHeight,
    //             decoration: BoxDecoration(
    //               color: Colors.blue.shade200,
    //               shape: BoxShape.circle,
    //             ),
    //             child: InkWell(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //     context,
    //                 //     MaterialPageRoute(
    //                 //         builder: (context) => DoctorsScreen()));
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.all(cardInnerSpace),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Image.asset('assets/images/doctor.png'),
    //                     Text(
    //                       'doctors',
    //                       style: TextStyle(fontSize: 14, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: categoryWidth,
    //             padding: EdgeInsets.all(15),
    //             margin: EdgeInsets.only(right: 10),
    //             height: categoryHeight,
    //             decoration: BoxDecoration(
    //               color: Colors.blue.shade200,
    //               shape: BoxShape.circle,
    //             ),
    //             child: InkWell(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //     context,
    //                 //     MaterialPageRoute(
    //                 //         builder: (context) => DoctorsScreen()));
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.all(cardInnerSpace),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Image.asset('assets/images/doctor.png'),
    //                     Text(
    //                       'doctors',
    //                       style: TextStyle(fontSize: 14, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: categoryWidth,
    //             padding: EdgeInsets.all(15),
    //             margin: EdgeInsets.only(right: 10),
    //             height: categoryHeight,
    //             decoration: BoxDecoration(
    //               color: Colors.blue.shade200,
    //               shape: BoxShape.circle,
    //             ),
    //             child: InkWell(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //     context,
    //                 //     MaterialPageRoute(
    //                 //         builder: (context) => DoctorsScreen()));
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.all(cardInnerSpace),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Image.asset('assets/images/doctor.png'),
    //                     Text(
    //                       'doctors',
    //                       style: TextStyle(fontSize: 14, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: categoryWidth,
    //             padding: EdgeInsets.all(15),
    //             margin: EdgeInsets.only(right: 10),
    //             height: categoryHeight,
    //             decoration: BoxDecoration(
    //               color: Colors.blue.shade200,
    //               shape: BoxShape.circle,
    //             ),
    //             child: InkWell(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //     context,
    //                 //     MaterialPageRoute(
    //                 //         builder: (context) => DoctorsScreen()));
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.all(cardInnerSpace),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Image.asset('assets/images/doctor.png'),
    //                     Text(
    //                       'doctors',
    //                       style: TextStyle(fontSize: 14, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return CarouselSlider(
      options: CarouselOptions(height: 150.0),
      items: offers.map((offerInstance) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                // decoration: BoxDecoration(color: Colors.amber),
                child: Image.network(
                  offerInstance.imageUrl,
                  fit: BoxFit.cover,
                ));
          },
        );
      }).toList(),
    );
  }
}
