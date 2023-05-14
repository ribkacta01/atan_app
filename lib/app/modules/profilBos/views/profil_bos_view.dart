import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../util/Loading.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/profil_bos_controller.dart';

class ProfilBosView extends GetView<ProfilBosController> {
  const ProfilBosView({Key? key}) : super(key: key);
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
                                  "Halaman Profil Anda",
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: HexColor("#0B0C2B"),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: IconButton(
                                    onPressed: () {
                                      authC.logout();
                                    },
                                    icon: Icon(
                                      PhosphorIcons.signOut,
                                      color: HexColor("#D90000"),
                                    ))),
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
                                  height: 95,
                                  width: 95,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.EDIT_PROF_BOS);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
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
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 5),
                                    child: Icon(
                                      PhosphorIcons.pencilSimple,
                                      size: 20,
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
                                fontSize: 18,
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
                                fontSize: 15,
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
