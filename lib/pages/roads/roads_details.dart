import 'dart:math';

import 'package:flutter/material.dart';
import 'package:traffix/pages/widgets/rating.dart';

class RoadsDetails extends StatefulWidget {
  const RoadsDetails({Key? key}) : super(key: key);

  @override
  RoadsDetailsState createState() => RoadsDetailsState();
}

class RoadsDetailsState extends State<RoadsDetails> {
  int numberPackage = 0;

  removePackage() {
    setState(() {
      numberPackage--;
      numberPackage = max(numberPackage, 0);
    });
  }

  addPackage() {
    setState(() {
      numberPackage++;
      numberPackage = min(numberPackage, 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.menu),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: size.height * 0.7,
              color: Colors.grey,
              child: const Image(
                image: NetworkImage(
                    'https://baodanang.vn/dataimages/201505/original/images1144895_IMG_9473.JPG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 26, left: 20, right: 20),
              height: size.height * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trần Hưng Đạo",
                    style: appTheme.textTheme.headline4,
                  ),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(
                      Icons.location_pin,
                      size: 14,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "5km từ đây",
                      style: appTheme.textTheme.caption,
                    )
                  ]),
                  const SizedBox(height: 12),
                  Text(
                    "Mô tả",
                    style: appTheme.textTheme.headline5
                        ?.merge(const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Con đường dài ven sông, thuộc khu vực bán đảo Sơn Trà. Khu vực này thường xuyên có nhiều phương tiện lưu thông",
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                    style: appTheme.textTheme.bodyText1,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Giờ cao điểm",
                              style: TextStyle(
                                  color: Color(0xffFF7879),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: appTheme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(color: Colors.blue)),
                            elevation: 0,
                            textStyle: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'PlayFair',
                                fontWeight: FontWeight.bold)),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Theo dõi",
                            style: appTheme.textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
