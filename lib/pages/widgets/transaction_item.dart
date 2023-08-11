import 'package:traffix/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrafficDataList extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;
  final String date;
  final num value;

  const TrafficDataList({
    required this.icon,
    required this.description,
    required this.title,
    required this.date,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kSpacingUnit.w * 2).copyWith(bottom: 0),
      child: Row(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 6,
            width: kSpacingUnit.w * 6,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor4,
                    blurRadius: 24,
                    offset: Offset(0, kSpacingUnit.w),
                  )
                ]),
            child: Center(
              child: icon,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 1.5),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontFamily: 'Muli'),
                  children: [
                    TextSpan(
                      text: '$title\n',
                      style: kTitleTextStyle,
                    ),
                    TextSpan(
                      text: description,
                      style: kCaptionTextStyle.copyWith(height: 1.5),
                    )
                  ],
                ),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: const TextStyle(fontFamily: 'Muli'),
              children: [
                TextSpan(
                  text: '${value}\n',
                  style: kTitleTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: value.isNegative ? kRedColor : kGreenColor,
                  ),
                ),
                TextSpan(
                  text: date,
                  style: kCaptionTextStyle.copyWith(height: 1.5),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
