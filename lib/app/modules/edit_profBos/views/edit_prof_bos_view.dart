import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../util/Loading.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/edit_prof_bos_controller.dart';

class EditProfBosView extends GetView<EditProfBosController> {
  const EditProfBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final editBosC = Get.put(EditProfBosController());
    final home = Get.put(BerandaBosController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 6,
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: home.berandaBos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
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
                              fontSize: 19,
                              color: HexColor("#0B0C2B"),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Halaman Profil Anda",
                            style: TextStyle(
                              fontSize: 19,
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
                        height: 6.h,
                      ),
                      Form(
                          key: editBosC.namaKey.value,
                          child: Container(
                            height: 7.h,
                            width: 70.w,
                            child: TextFormField(
                              controller: controller.namaEdit,
                              decoration: InputDecoration(
                                fillColor: HexColor("#BFC0D2"),
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: HexColor("#FF0000"))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: HexColor("#BFC0D2"))),
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
                              validator: editBosC.namaValidator,
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
                            if (editBosC.namaKey.value.currentState!
                                .validate()) {
                              editBosC.editNama(
                                editBosC.namaEdit.text,
                              );
                            }
                          },
                          child: Text(
                            "Simpan",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
