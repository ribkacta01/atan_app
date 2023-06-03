import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:atan_app/app/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../util/Loading.dart';
import '../controllers/list_kebutuhan_controller.dart';

class ListKebutuhanView extends GetView<ListKebutuhanController> {
  const ListKebutuhanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var doc = Get.arguments;
    var docName = '${doc['nama']} - ${doc['date']}';

    final authC = Get.put(AuthController());
    final listC = Get.put(ListKebutuhanController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 6,
            ),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: authC.getUserRoles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading();
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
                                left: 17,
                                right: 20,
                                top: 6,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Halo ${data.get('name')}",
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: ClipOval(
                                child: Image.network(
                                  data.get('photoUrl'),
                                  height: 45,
                                  width: 45,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Padding(
                          padding: EdgeInsets.only(left: 17),
                          child: Text(
                            "Daftar Kebutuhan Pesanan",
                            style: TextStyle(
                              fontSize: 22,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: listC.list(docName),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Loading();
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 2, bottom: 7),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> data =
                                        snapshot.data!.docs[index].data();
                                    var docNameItem =
                                        '${data['Nama Barang']} - ${data['Keterangan']}';
                                    if (snapshot.data == null ||
                                        snapshot.data!.docs.length == 0) {
                                      return Center(
                                        child: Text('Data Kosong'),
                                      );
                                    }
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
                                              color: randomize(),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0.8.w,
                                                  bottom: 0.1.h,
                                                  right: 0.8.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    height: 8.h,
                                                    width: 8.h,
                                                    child: Center(
                                                      child: Icon(
                                                        PhosphorIcons.checkBold,
                                                        size: 35,
                                                        color: bluePrimary,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1.5.h,
                                                                right: 5,
                                                                bottom: 1),
                                                        child: Text(
                                                            data['Nama Barang'],
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            )),
                                                      ),
                                                      SizedBox(height: 1.h),
                                                      Text(data['Keterangan'],
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      SizedBox(height: 1.h),
                                                      Text(
                                                          data['Jumlah Barang'],
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  IconButton(
                                                      enableFeedback: true,
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        PhosphorIcons
                                                            .pencilSimpleFill,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ]);
                })));
  }
}
