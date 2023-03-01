import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../controllers/beranda_bos_controller.dart';

class BerandaBosView extends GetView<BerandaBosController> {
  const BerandaBosView({Key? key}) : super(key: key);
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
                      "Halo Bos",
                      style: TextStyle(
                        fontSize: 19,
                        color: HexColor("#0B0C2B"),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Lihat Update Pekerjaan Pegawai Anda",
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
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 0.000001),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 2.h,
                    ),
                    child: Material(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(right: 4.w, left: 4.w),
                          height: 38.h,
                          decoration: BoxDecoration(
                            color: HexColor("#BFC0D2"),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                                child: Image.asset(
                                  "assets/images/menjahit.png",
                                  width: 90.w,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 1.h, right: 5.w, left: 5.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ribka",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: HexColor("#0B0C2B"),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          "Divisi Jahit",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: HexColor("#0B0C2B"),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Text(
                                        "20/02/2023",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: HexColor("#0B0C2B"),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
