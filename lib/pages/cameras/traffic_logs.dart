import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:traffix/constants/constants.dart';
import 'package:traffix/pages/widgets/app_content.dart';
import 'package:traffix/pages/widgets/box_panel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffix/pages/widgets/traffic_line_chart.dart';
import 'package:traffix/pages/widgets/traffic_pie_chart.dart';

class TrafficLogs extends StatelessWidget {
  TrafficLogs({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> logsStream = FirebaseFirestore.instance
      .collection('cameras')
      .doc('otlbDcquamUo3qlt5phq')
      .collection('logs')
      .orderBy('date', descending: true)
      .limit(30)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var header = Padding(
      padding: EdgeInsets.all(kSpacingUnit.w * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset('assets/icons/arrow_left.svg'),
          ),
          InkWell(
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

    var accountHeading = Padding(
      padding: EdgeInsets.symmetric(
        vertical: kSpacingUnit.w,
        horizontal: kSpacingUnit.w * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Account',
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

    var summaryPanel = Row(
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 2),
        Expanded(
          child: BoxPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset('assets/icons/arrow_up.svg'),
                SizedBox(height: kSpacingUnit.w),
                Text(
                  '\$459.23',
                  style: kNumberTitleTextStyle,
                ),
                SizedBox(height: kSpacingUnit.w / 2),
                Text(
                  'Total Spent',
                  style: kBodyTextStyle,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: kSpacingUnit.w * 2),
        Expanded(
          child: BoxPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset('assets/icons/arrow_down.svg'),
                SizedBox(height: kSpacingUnit.w),
                Text(
                  '\$2049.95',
                  style: kNumberTitleTextStyle,
                ),
                SizedBox(height: kSpacingUnit.w / 2),
                Text(
                  'Total Received',
                  style: kBodyTextStyle,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: kSpacingUnit.w * 2),
      ],
    );

    var upgradeAccountBanner = BoxPanel(
      shadow: BoxShadow(
          color: kShadowColor2,
          blurRadius: kSpacingUnit.w * 4,
          offset: Offset(0, kSpacingUnit.w * 2)),
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      image: const DecorationImage(
        image: AssetImage(
          'assets/imgs/upgrade_account_bg.png',
        ),
        fit: BoxFit.cover,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: kShadowColor1,
                  blurRadius: kSpacingUnit.w,
                  offset: const Offset(0, kSpacingUnit / 2),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kSpacingUnit.w,
                vertical: kSpacingUnit.w / 2,
              ),
              child: Text(
                'Become Pro Member',
                style: kCaptionTextStyle.copyWith(
                  color: kPurpleColor,
                ),
              ),
            ),
          ),
          SizedBox(height: kSpacingUnit.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Upgrade your acount',
                style: kSubheaderTextStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SvgPicture.asset('assets/icons/arrow_right.svg'),
            ],
          ),
          SizedBox(height: kSpacingUnit.w),
        ],
      ),
    );

    Color lineColor(num rate) {
      if (rate <= 0.4) {
        return const Color(0xff5AFF78);
      } else if (rate <= 0.75) {
        return const Color(0xffFFC610);
      } else {
        return const Color(0xffFF0059);
      }
    }

    return StreamBuilder<QuerySnapshot>(
      stream: logsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        var logsDocs = snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return data;
        }).toList();

        Map<String, Map<String, dynamic>> panelsLogsData = {
          'vehicles': {
            'title': 'Lượng phương tiện',
            'value': 0,
            'rate': 0,
          },
          'accidents': {
            'title': 'Tai nạn',
            'value': 0,
            'rate': 0,
          },
          'congestion': {
            'title': 'Ùn tắc',
            'value': 0,
            'rate': 0,
          },
        };

        Map<String, List<FlSpot>> lineChartsLogData = {
          'vehicles': [],
          'accidents': [],
          'congestion': [],
        };

        List<String> panelsType = ['vehicles', 'accidents', 'congestion'];

        for (var i = 0; i < logsDocs.length; i++) {
          for (var element in panelsType) {
            panelsLogsData[element]!['value'] += logsDocs[i][element];
            lineChartsLogData[element]!.add(
                FlSpot(i.toDouble(), (logsDocs[i][element] as int).toDouble()));
          }
        }

        for (var element in panelsType) {
          panelsLogsData[element]!['rate'] =
              logsDocs[0][element] / panelsLogsData[element]!['value'];
        }

        List<Widget> panelsList = panelsLogsData.entries.map((entry) {
          var data = entry.value;

          return BoxPanel(
            margin: EdgeInsets.symmetric(
              horizontal: kSpacingUnit.w * 2,
            ).copyWith(top: kSpacingUnit.w * 2),
            shadow: const BoxShadow(
              color: kShadowColor5,
              blurRadius: kSpacingUnit * 4,
              offset: Offset(0, kSpacingUnit / 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data['title'],
                  style: kBodyTextStyle,
                ),
                SizedBox(height: kSpacingUnit.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      data['value'].toString(),
                      style: kNumberTitleTextStyle,
                    ),
                    Text(
                      '${(data['rate'] * 100).toStringAsFixed(2)}%',
                      style: kSubheaderTextStyle.copyWith(
                          color: lineColor(data['rate']),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: kSpacingUnit.w * 2),
                Stack(
                  children: <Widget>[
                    Container(
                      height: kSpacingUnit.w / 2,
                      width: ScreenUtil().screenWidth.toDouble(),
                      decoration: BoxDecoration(
                        color: kLineColor,
                        borderRadius: BorderRadius.circular(kSpacingUnit / 4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: data['rate'],
                      child: Container(
                        height: kSpacingUnit.w / 2,
                        decoration: BoxDecoration(
                          color: lineColor(data['rate']),
                          borderRadius: BorderRadius.circular(kSpacingUnit / 4),
                          boxShadow: [
                            BoxShadow(
                              color: kShadowColor3,
                              blurRadius: kSpacingUnit.w,
                              offset: const Offset(0, kSpacingUnit / 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kSpacingUnit.w * 3),
              ],
            ),
          );
        }).toList();

        Widget boxPanel(Widget widgetChild) {
          return BoxPanel(
              margin: EdgeInsets.symmetric(
                horizontal: kSpacingUnit.w * 2,
              ).copyWith(top: kSpacingUnit.w * 2),
              shadow: const BoxShadow(
                color: kShadowColor5,
                blurRadius: kSpacingUnit * 4,
                offset: Offset(0, kSpacingUnit / 2),
              ),
              child: widgetChild);
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: AppContent(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  header,
                  accountHeading,
                  SizedBox(height: kSpacingUnit.w),
                  summaryPanel,
                  SizedBox(height: kSpacingUnit.w * 2),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        upgradeAccountBanner,
                        for (Widget panel in panelsList) panel,
                        boxPanel(TrafficLineChart(
                          vehiclesData: lineChartsLogData['vehicles']!,
                          accidentsData: lineChartsLogData['accidents']!,
                          congestionData: lineChartsLogData['congestion']!,
                        )),
                        boxPanel(const TrafficPieChart())
                      ],
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
}
