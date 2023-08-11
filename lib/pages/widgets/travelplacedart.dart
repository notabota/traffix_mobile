import 'package:flutter/material.dart';
import 'package:traffix/pages/widgets/rating.dart';
import 'package:traffix/models/places_model.dart';
import 'package:traffix/ui/theme.dart';

Widget travelCard(PlaceModel placeModel) => Stack(
      children: [
        SizedBox(
          height: double.maxFinite,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: NetworkImage(placeModel.imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 12,
                icon: Icon(
                  Icons.favorite_rounded,
                  size: 20,
                  color: kAppTheme.highlightColor,
                ),
                onPressed: () {})),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withAlpha(90)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeModel.placeTitle,
                  style: kAppTheme.textTheme.subtitle1,
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
        )
      ],
    );
