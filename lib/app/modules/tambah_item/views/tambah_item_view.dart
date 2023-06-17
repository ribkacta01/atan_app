import 'dart:developer';

import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import '../controllers/tambah_item_controller.dart';

class TambahItemView extends GetView<TambahItemController> {
  const TambahItemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var docName = Get.arguments;
    log('$docName');
    final authC = Get.put(AuthController());
    final addC = Get.put(TambahItemController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 3.w,
              right: 3.w,
              top: 1.h,
            ),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: authC.getUserRoles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Lottie.asset('assets/animation/loading.json',
                            height: 145));
                  }
                  var data = snapshot.data!;
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.ltr,
                      children: [
                        SizedBox(height: 6.h),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(PhosphorIcons.arrowLeft)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 3.w,
                                right: 3.w,
                                top: 1.h,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Halo ${data.get('name')}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: HexColor("#0B0C2B"),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    "Perencanaan Produksi Anda Disini ",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: HexColor("#0B0C2B"),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 3.w),
                              child: ClipOval(
                                child: Image.network(
                                  data.get('photoUrl'),
                                  width: 10.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            "Tambahkan Item Kebutuhan Pesanan",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Center(
                            child: Column(children: [
                          Form(
                              key: addC.nameKey.value,
                              child: Container(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  controller: addC.namaEdit,
                                  decoration: InputDecoration(
                                    fillColor: HexColor("#BFC0D2"),
                                    filled: true,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: HexColor("#FF0000"))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: grey2)),
                                    hintText: "Nama Barang",
                                    errorStyle: TextStyle(
                                        color: Colors.white,
                                        background: Paint()
                                          ..strokeWidth = 16
                                          ..color = HexColor("#FF0000")
                                          ..style = PaintingStyle.stroke
                                          ..strokeJoin = StrokeJoin.round),
                                    helperText: ' ',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: addC.namaValidator,
                                ),
                              )),
                          SizedBox(height: 2.5.h),
                          Form(
                              key: addC.jmlKey.value,
                              child: Container(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  controller: addC.jmldit,
                                  decoration: InputDecoration(
                                    fillColor: HexColor("#BFC0D2"),
                                    filled: true,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: HexColor("#FF0000"))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: grey2)),
                                    hintText: "Jumlah Barang",
                                    errorStyle: TextStyle(
                                        color: Colors.white,
                                        background: Paint()
                                          ..strokeWidth = 16
                                          ..color = HexColor("#FF0000")
                                          ..style = PaintingStyle.stroke
                                          ..strokeJoin = StrokeJoin.round),
                                    helperText: ' ',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: addC.jmlValidator,
                                ),
                              )),
                          SizedBox(height: 2.5.h),
                          Form(
                              key: addC.ketKey.value,
                              child: Container(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  controller: addC.kettEdit,
                                  decoration: InputDecoration(
                                    fillColor: HexColor("#BFC0D2"),
                                    filled: true,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: HexColor("#FF0000"))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: grey2)),
                                    hintText: "Keterangan",
                                    errorStyle: TextStyle(
                                        color: Colors.white,
                                        background: Paint()
                                          ..strokeWidth = 16
                                          ..color = HexColor("#FF0000")
                                          ..style = PaintingStyle.stroke
                                          ..strokeJoin = StrokeJoin.round),
                                    helperText: ' ',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: addC.ketValidator,
                                ),
                              )),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            height: 4.5.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                                color: HexColor("#0B0C2B"),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                if (addC.nameKey.value.currentState!
                                        .validate() &&
                                    addC.jmlKey.value.currentState!
                                        .validate() &&
                                    addC.ketKey.value.currentState!
                                        .validate()) {
                                  addC.addItem(docName, addC.namaEdit.text,
                                      addC.jmldit.text, addC.kettEdit.text);
                                }
                              },
                              child: Text(
                                "Simpan",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                            ),
                          )
                        ]))
                      ]);
                })));
  }
}
