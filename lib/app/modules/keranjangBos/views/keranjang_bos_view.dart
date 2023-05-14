import 'package:atan_app/app/modules/berandaBos/controllers/beranda_bos_controller.dart';
import 'package:atan_app/app/util/Loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/keranjang_bos_controller.dart';

class KeranjangBosView extends GetView<KeranjangBosController> {
  const KeranjangBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final keranjangC = Get.put(KeranjangBosController());
    final home = Get.put(BerandaBosController());
    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 0.5.h),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.TAMBAH_PEMESAN);
              },
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
            child: Expanded(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: home.berandaBos(),
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
                        SizedBox(height: 2.5.h),
                        Form(
                          child: Container(
                              height: 5.h,
                              width: 90.w,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(PhosphorIcons.magnifyingGlass),
                                  iconColor: HexColor("#0B0C2B"),
                                  fillColor: HexColor("#BFC0D2"),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: HexColor("#5B5B6E"),
                                          width: 2)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: "Cari Pesanan...",
                                ),
                              )),
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
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 15),
                              child: TextButton(
                                onPressed: () {
                                  Get.dialog(Dialog(
                                    child: Container(
                                      padding: EdgeInsets.all(1.h),
                                      height: 40.h,
                                      child: SfDateRangePicker(
                                        view: DateRangePickerView.year,
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        showActionButtons: true,
                                        onCancel: () => Get.back(),
                                        onSubmit: (obj) {},
                                      ),
                                    ),
                                  ));
                                },
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
                        StreamBuilder<
                                List<
                                    QueryDocumentSnapshot<
                                        Map<String, dynamic>>>>(
                            stream: keranjangC.keranjang(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Loading();
                              }
                              final data = snapshot.data ?? [];
                              final isLoadingMore =
                                  keranjangC.lastDocumentSnapshot.value != null;

                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 2, bottom: 10),
                                  itemCount: snapshot.data!.length + 1,
                                  controller: ScrollController()
                                    ..addListener(() {
                                      final maxScroll = keranjangC
                                              .lastDocumentSnapshot.value !=
                                          null;
                                      final currentScroll = context
                                          .findRenderObject() as RenderBox;
                                      if (maxScroll &&
                                          currentScroll.size.height -
                                                  currentScroll
                                                      .semanticBounds.bottom <=
                                              100) {
                                        print('Loading more data...');
                                        keranjangC.loadMore().then((value) {});
                                      }
                                    }),
                                  itemBuilder: (context, index) {
                                    if (index == snapshot.data!.length) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    Map<String, dynamic> data =
                                        snapshot.data![index].data();

                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 2.h),
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.LIST_KEBUTUHAN);
                                          },
                                          child: Container(
                                            // margin: EdgeInsets.only(left: 12, right: 12),
                                            height: 11.h,
                                            width: 304.w,
                                            decoration: BoxDecoration(
                                              color: HexColor("#BFC0D2"),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0.5.w, bottom: 0.1.h),
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
                                                        PhosphorIcons
                                                            .dotsThreeOutlineFill,
                                                        size: 35,
                                                        color:
                                                            HexColor("#0B0C2B"),
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
                                                                top: 2.5.h,
                                                                right: 2,
                                                                left: 2),
                                                        child: Text(
                                                            data['nama'],
                                                            style: TextStyle(
                                                              fontSize: 21,
                                                              color: HexColor(
                                                                  "#0B0C2B"),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            )),
                                                      ),
                                                      SizedBox(height: 1.5.h),
                                                      Text(data['date'],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: HexColor(
                                                                "#0B0C2B"),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  IconButton(
                                                      enableFeedback: true,
                                                      hoverColor: Colors.amber,
                                                      onPressed: () {
                                                        Get.toNamed(Routes
                                                            .LIST_KEBUTUHAN);
                                                      },
                                                      icon: Icon(
                                                        PhosphorIcons
                                                            .caretRight,
                                                        color:
                                                            HexColor("#0B0C2B"),
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
                      ],
                    );
                  }),
            )));
  }
}
