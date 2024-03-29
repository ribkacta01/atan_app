import 'package:atan_app/app/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import '../controllers/edit_item_controller.dart';
import 'package:intl/intl.dart' show DateFormat;

class EditItemView extends GetView<EditItemController> {
  const EditItemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dateFormatterDefault = DateFormat('d MMMM yyyy', 'id-ID');
    final authC = Get.put(AuthController());
    final editC = Get.put(EditItemController());

    //argument dari item_pesanan_kry_view
    var doc = Get.arguments[0];
    //argument dari Perencanaan view
    var docP = Get.arguments[1];
    var docName = '${doc['id']}';
    var docNameP =
        '${docP['nama']} - ${dateFormatterDefault.format(DateTime.parse(docP['date']))}';

    editC.namaEdit.text = doc['Nama Barang'];
    editC.jmldit.text = doc['Jumlah Barang'];
    editC.kettEdit.text = doc['Keterangan'];

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
                            icon: const Icon(PhosphorIcons.arrowLeft)),
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
                                    "Perbarui Item Produksi Anda Disini ",
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
                            "Ubah Daftar Item Kebutuhan Pesanan",
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
                              key: editC.nameKey.value,
                              child: SizedBox(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  controller: editC.namaEdit,
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
                                  validator: editC.namaValidator,
                                ),
                              )),
                          SizedBox(height: 2.5.h),
                          Form(
                              key: editC.jmlKey.value,
                              child: SizedBox(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  controller: editC.jmldit,
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
                                  validator: editC.jmlValidator,
                                ),
                              )),
                          SizedBox(height: 2.5.h),
                          Form(
                              key: editC.ketKey.value,
                              child: SizedBox(
                                height: 7.h,
                                width: 82.w,
                                child: TextFormField(
                                  controller: editC.kettEdit,
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
                                  validator: editC.ketValidator,
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
                                if (editC.nameKey.value.currentState!
                                        .validate() &&
                                    editC.jmlKey.value.currentState!
                                        .validate() &&
                                    editC.ketKey.value.currentState!
                                        .validate()) {
                                  editC.edit(
                                      docName,
                                      docNameP,
                                      editC.namaEdit.text,
                                      editC.kettEdit.text,
                                      editC.jmldit.text);
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
