import 'package:flutter/material.dart';
import 'package:traffix/constants/constants.dart';

AppBar homeAppBar = AppBar(
  title: const Center(
      child: Text(
    "Truy cứu thông tin tuyến đường",
    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
  )),
  leading: PopupMenuButton(
     offset: Offset.fromDirection(2, 58),
    onSelected: (value){

    },
    icon: const Icon(Icons.menu),
    itemBuilder: (context) {
      return kAppBarMenuOptions
          .map(
            (option) => PopupMenuItem(
              value: option,
              child: SizedBox(
                width: 120,
                child: Text(option,style: const TextStyle(color: Colors.black),),
              ),
            ),
          )
          .toList();
    },
  ),
  actions: [
    IconButton(
        icon: const Icon(
          Icons.account_circle,
          size: 36,
        ),
        onPressed: () {})
  ],
);

