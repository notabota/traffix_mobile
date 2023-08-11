import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traffix/constants/constants.dart';
import 'package:traffix/pages/cameras/traffic_logs.dart';
import 'package:traffix/pages/widgets/app_content.dart';
import 'package:traffix/pages/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TrafficInfo extends StatefulWidget {
  const TrafficInfo({Key? key}) : super(key: key);

  @override
  TrafficInfoState createState() => TrafficInfoState();
}

class TrafficInfoState extends State<TrafficInfo> {
  int _cardIndex = 1;
  String? url = "";
  double progress = 0;
  Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
      FirebaseFirestore.instance
          .collection('cameras')
          .doc('otlbDcquamUo3qlt5phq')
          .snapshots();

  @override
  Widget build(BuildContext context) {
    var header = Padding(
      padding: EdgeInsets.all(kSpacingUnit.w * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SvgPicture.asset('assets/icons/menu.svg'),
          InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: TrafficLogs(),
              ),
            ),
            child: Container(
              height: kSpacingUnit.w * 4,
              width: kSpacingUnit.w * 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor1,
                    blurRadius: kSpacingUnit * 2,
                    offset: Offset(0, kSpacingUnit.w),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/imgs/avatar.png'),
                ),
              ),
            ),
          )
        ],
      ),
    );

    var cardHeading = Padding(
      padding: EdgeInsets.symmetric(
        vertical: kSpacingUnit.w,
        horizontal: kSpacingUnit.w * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Hình ảnh',
            style: kHeadingTextStyle,
          ),
          Row(
            children: <Widget>[
              Text(
                'Add New',
                style: kBodyTextStyle,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w),
                child: SvgPicture.asset('assets/icons/plus.svg'),
              ),
            ],
          )
        ],
      ),
    );

    var cardCarousel = Stack(
      children: <Widget>[
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 240.w,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: _cardIndex,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _cardIndex = index;
              });
            },
          ),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index, int _) {
            return _getVideo(index);
          },
        ),
        // Positioned(
        //   bottom: kSpacingUnit.w * 2,
        //   left: 0,
        //   right: 0,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: cardsMockData.map((card) {
        //       return Container(
        //         width: kSpacingUnit.w,
        //         height: kSpacingUnit.w,
        //         margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w / 2),
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: cardsMockData[_cardIndex].number == card.number
        //               ? kPrimaryColor
        //               : Colors.transparent,
        //           border: Border.all(
        //             color: kPrimaryColor,
        //             width: 1.5,
        //           ),
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // )
      ],
    );

    var transactionHeading = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ).copyWith(
        top: kSpacingUnit.w * 2,
        bottom: kSpacingUnit.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Thông tin',
            style: kHeadingTextStyle,
          ),
          SvgPicture.asset(
            'assets/icons/more.svg',
            color: kTextSecondaryColor,
          )
        ],
      ),
    );

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: documentStream,
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        Map<String, dynamic> cameraData = snapshot.data!.data()!;
        List<String> dataList = ['vehicles'];
        const Map<String, Icon> iconList = {};

        return Scaffold(
          backgroundColor: Colors.white,
          body: AppContent(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  header,
                  cardHeading,
                  cardCarousel,
                  transactionHeading,
                  for (String dataType in dataList)
                    Expanded(
                      child: ListView(
                        children: cameraData[dataType]['value']
                            .entries
                            .map<Widget>((entry) {
                          // print(entry);
                          // print(entry.key);
                          // print(entry.value);
                          return TrafficDataList(
                            icon: const Icon(Icons.directions_car_sharp),
                            description: cameraData[dataType]['description'],
                            title: entry.key,
                            date: cameraData[dataType]['date'],
                            value: entry.value,
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _getVideo(int index) {
    String uri;
    if (index == 1) {
      uri = "https://ac41-58-187-187-177.ngrok.io";
    } else {
      uri = 'google.com';
    }
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(children: <Widget>[
        Container(
            // padding: const EdgeInsets.all(10.0),
            child: progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container()),
        Expanded(
          child: Container(
            // margin: const EdgeInsets.only(top: 440.0, left: 10.0, right: 10.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(uri)),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                  android: AndroidInAppWebViewOptions(
                    useHybridComposition: true,
                  ),
                  ios: IOSInAppWebViewOptions(
                    allowsInlineMediaPlayback: true,
                  )),
              onLoadStart: (InAppWebViewController controller, Uri? uri) {
                setState(() {
                  url = uri?.path;
                });
              },
              onLoadStop: (InAppWebViewController controller, Uri? uri) {
                setState(() {
                  url = uri?.path;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
      ]),
    );
  }
}
