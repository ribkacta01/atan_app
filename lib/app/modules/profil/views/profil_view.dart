import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';

import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    final home = Get.put(BerandaBosController());
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        child: Scaffold(
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
                                  "Halaman Profil Anda",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: HexColor("#0B0C2B"),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  authC.logout();
                                },
                                icon: Icon(
                                  PhosphorIcons.signOut,
                                  color: HexColor("#D90000"),
                                )),
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
                                  width: 85,
                                  height: 85,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.EDIT_PROF_KRY);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 6.w),
                                    child: Text(
                                      data.get('name'),
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: HexColor("#0B0C2B"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 3.w, right: 2.w),
                                    child: Icon(
                                      PhosphorIcons.pencilSimple,
                                      size: 15.sp,
                                      color: HexColor("#0B0C2B"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              data.get('divisi'),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              data.get('email'),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: HexColor("#0B0C2B"),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                          ],
                        )
                      ],
                    );
                  }),
            )));
  }
}
