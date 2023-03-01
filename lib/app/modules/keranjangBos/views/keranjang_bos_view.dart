import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/keranjang_bos_controller.dart';

class KeranjangBosView extends GetView<KeranjangBosController> {
  const KeranjangBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 0.5.h),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: HexColor("#0B0C2B"),
              child: Icon(PhosphorIcons.plus),
            ),
          ),
        ),
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
                          "Perencanaan Produksi Anda Disini ",
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
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#BFC0D2"),
                        borderRadius: BorderRadius.circular(13)),
                    height: 6.h,
                    width: 85.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Cari Pesanan...",
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: HexColor("#63636E"),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Icon(
                          PhosphorIcons.magnifyingGlass,
                          size: 25,
                          color: HexColor("#0B0C2B"),
                        ),
                      ],
                    ),
                  ),
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
                    padding: EdgeInsets.only(top: 2, bottom: 7),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Material(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // margin: EdgeInsets.only(left: 12, right: 12),
                              height: 11.h,
                              width: 304.w,
                              decoration: BoxDecoration(
                                color: HexColor("#BFC0D2"),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 0.8.w, bottom: 0.1.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 8.h,
                                      width: 8.h,
                                      child: Center(
                                        child: Icon(
                                          PhosphorIcons.dotsThreeOutlineFill,
                                          size: 35,
                                          color: HexColor("#0B0C2B"),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.5.h, right: 5),
                                          child: Text("Bapak Tulus",
                                              style: TextStyle(
                                                fontSize: 21,
                                                color: HexColor("#0B0C2B"),
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        SizedBox(height: 1.5.h),
                                        Text("20 Februari 2023",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: HexColor("#0B0C2B"),
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                    SizedBox(width: 2.w),
                                    IconButton(
                                        enableFeedback: true,
                                        hoverColor: Colors.amber,
                                        onPressed: () {},
                                        icon: Icon(
                                          PhosphorIcons.caretRight,
                                          color: HexColor("#0B0C2B"),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            )));
  }
}
