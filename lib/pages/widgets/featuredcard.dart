import 'dart:math';

import 'package:flutter/material.dart';
import 'package:traffix/pages/widgets/rating.dart';
import 'package:traffix/models/places_model.dart';
import 'package:traffix/ui/theme.dart';

class FeaturedCard extends StatefulWidget {
  PlaceModel placeModel;

  FeaturedCard({Key? key, required this.placeModel}) : super(key: key);

  @override
  FeaturedCardState createState() => FeaturedCardState();
}

class FeaturedCardState extends State<FeaturedCard> {
  late double rating;
  late String title;
  late bool favorite;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);

    return Container(
        width: size.width * 0.85,
        height: max(200, size.height * 0.32),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey.withAlpha(90)),
        child: Stack(
          children: [
            SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image(
                  image: NetworkImage(widget.placeModel.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 8, top: 8),
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.black.withAlpha(95)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 28,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.placeModel.placeTitle,
                            style: kAppTheme.textTheme.headline3,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.favorite_rounded,
                                color: kAppTheme.primaryColor,
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          'Gần đây',
                          style: TextStyle(color: Color(0xffC1FF6E)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
