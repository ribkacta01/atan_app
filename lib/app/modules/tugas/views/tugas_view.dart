import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/tugas_controller.dart';

class TugasView extends GetView<TugasController> {
  const TugasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo Ribka",
                      style: TextStyle(
                        fontSize: 19,
                        color: HexColor("#0B0C2B"),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Lihat Update Pekerjaan Anda",
                      style: TextStyle(
                        fontSize: 19,
                        color: HexColor("#0B0C2B"),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    PhosphorIcons.userCircle,
                    size: 45,
                    color: HexColor("#0B0C2B"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.5.h),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#0B0C2B"),
                        borderRadius: BorderRadius.circular(20)),
                    height: 3.5.h,
                    width: 9.h,
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Terbaru",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor("#0B0C2B"),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
              width: 200.h,
            ),
          ],
        ),
      ),
    );
  }
}
