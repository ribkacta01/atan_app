import 'package:atan_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/olah_data_pegawai_controller.dart';

class OlahDataPegawaiView extends GetView<OlahDataPegawaiController> {
  const OlahDataPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final home = Get.put(BerandaBosController());
    final olahC = Get.put(OlahDataPegawaiController());

    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 0.5.h),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.TAMBAH_PEGAWAI);
              },
              backgroundColor: HexColor("#0B0C2B"),
              child: Icon(PhosphorIcons.plus),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.normal),
            padding: EdgeInsets.only(
              left: 3.w,
              right: 3.w,
              top: 1.h,
            ),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: home.berandaBos(),
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
                                  fontSize: 12.sp,
                                  color: HexColor("#0B0C2B"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "Daftar Pegawai Atan Sport Apparel ",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: HexColor("#0B0C2B"),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: ClipOval(
                              child: Image.network(
                                data.get('photoUrl'),
                                width: 11.w,
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
                              controller: controller.searchController,
                              onChanged: (value) =>
                                  olahC.searchQuery.add(value),
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                suffixIcon: Icon(PhosphorIcons.magnifyingGlass),
                                iconColor: HexColor("#0B0C2B"),
                                fillColor: HexColor("#BFC0D2"),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: HexColor("#5B5B6E"), width: 2)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Cari Nama Pegawai",
                              ),
                            )),
                      ),
                      SizedBox(height: 2.5.h),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: olahC.olah(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Lottie.asset(
                                      'assets/animation/loading.json',
                                      height: 145));
                            }
                            if (snapshot.data == null ||
                                snapshot.data!.docs.length == 0) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Lottie.asset(
                                            'assets/animation/search.json',
                                            width: 28.w),
                                        // SizedBox(height: 2.h),
                                        Text("Pencarian Tidak Ditemukan",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: grey1,
                                            ))
                                      ],
                                    ),
                                  ));
                            }

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                padding:
                                    EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  // Map<String, dynamic> data =
                                  //     controller.searchResults[index];
                                  Map<String, dynamic> data =
                                      snapshot.data!.docs[index].data();

                                  var defaultImage =
                                      "https://ui-avatars.com/api/?name=${data['name']}&background=0B0C2B&color=BFC0D2&font-size=0.33";

                                  if (data.length == 0) {
                                    return Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Lottie.asset(
                                                  'assets/animation/noData.json',
                                                  width: 28.w),
                                              // SizedBox(height: 2.h),
                                              Text("Belum Ada Data Pegawai",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: grey1,
                                                  ))
                                            ],
                                          ),
                                        ));
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
                                                BorderRadius.circular(16.sp),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.8.w, bottom: 0.1.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      data["photoUrl"] != ''
                                                          ? data['photoUrl']
                                                          : defaultImage,
                                                      height: 6.h,
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
                                                          top: 2.h, right: 2),
                                                      child: Text(data['name'],
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                    ),
                                                    SizedBox(height: 1.h),
                                                    Text(data['divisi'],
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                    SizedBox(height: 1.h),
                                                    Text(data['email'],
                                                        style: TextStyle(
                                                          fontSize: 8.sp,
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(width: 3.w),
                                                IconButton(
                                                    enableFeedback: true,
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          Routes.EDIT_PEGAWAI,
                                                          arguments: data);
                                                    },
                                                    icon: Icon(
                                                      PhosphorIcons
                                                          .pencilSimpleFill,
                                                      color: white,
                                                    )),
                                                IconButton(
                                                    enableFeedback: true,
                                                    hoverColor: Colors.amber,
                                                    onPressed: () {
                                                      olahC.delKry(
                                                          data['email']);
                                                    },
                                                    icon: Icon(
                                                      PhosphorIcons.trashFill,
                                                      color: white,
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
                })));
  }
}
