import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import 'color.dart';

Widget myDialog(IconData icon, String text, TextStyle textAlert) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: bluePrimary,
    child: Container(
      width: 350,
      height: 336,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: white,
            size: 110,
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: white,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
              width: 15.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: white),
              child: TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: bluePrimary),
                    ),
                  )))
        ],
      ),
    ),
  );
}

Widget DialogDoubleMessage(
  IconData icon,
  String text,
  String text2,
) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: bluePrimary,
    child: Container(
      width: 350,
      height: 336,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Icon(
              icon,
              color: white,
              size: 110,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 30,
              color: white,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Text(
            text2,
            style: TextStyle(
              fontSize: 20,
              color: white,
            ),
          ),
        ],
      ),
    ),
  );
}
