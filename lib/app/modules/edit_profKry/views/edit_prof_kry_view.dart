import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/edit_prof_kry_controller.dart';

class EditProfKryView extends GetView<EditProfKryController> {
  const EditProfKryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final editC = Get.put(EditProfKryController());
    final home = Get.put(BerandaBosController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                controller.namaEdit.text = data.get('name');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: [
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  PhosphorIcons.arrowLeft,
                                  color: HexColor("#0B0C2B"),
                                ))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              "Halaman Profil Anda",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: ClipOval(
                            child: Image.network(
                              data.get('photoUrl'),
                              height: 85,
                              width: 85,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Column(
                          children: [
                            Form(
                                key: editC.namaKey.value,
                                child: Container(
                                  height: 7.h,
                                  width: 70.w,
                                  child: TextFormField(
                                    controller: controller.namaEdit,
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#BFC0D2"),
                                      filled: true,
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: HexColor("#FF0000"))),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: HexColor("#BFC0D2"))),
                                      hintText: "Nama User",
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
                                    validator: editC.namaValidator,
                                  ),
                                )),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 4.5.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                  color: HexColor("#0B0C2B"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  if (editC.namaKey.value.currentState!
                                      .validate()) {
                                    editC.edit(
                                      editC.namaEdit.text,
                                    );
                                  }
                                },
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              }),
        ));
  }
}
