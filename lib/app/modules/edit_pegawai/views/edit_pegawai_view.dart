import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import '../../berandaBos/controllers/beranda_bos_controller.dart';
import '../controllers/edit_pegawai_controller.dart';

class EditPegawaiView extends GetView<EditPegawaiController> {
  const EditPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final editpgC = Get.put(EditPegawaiController());

    final home = Get.put(BerandaBosController());
    final indexData = Get.arguments;

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
                controller.namaEdit.text = indexData['name'];
                controller.emailEdit.text = indexData['email'];
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
                                  "Edit Data Pegawai ",
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
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Text(
                          "Ubah Data Pegawai",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: HexColor("#0B0C2B"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Center(
                        child: Form(
                          key: controller.namaKey.value,
                          child: Container(
                            height: 7.h,
                            width: 82.w,
                            child: TextFormField(
                              controller: editpgC.namaEdit,
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
                                hintText: "Nama Pegawai",
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
                              validator: editpgC.namaValidator,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Center(
                        child: Form(
                          key: controller.emailKey.value,
                          child: Container(
                            height: 7.h,
                            width: 82.w,
                            child: TextFormField(
                              controller: controller.emailEdit,
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
                                hintText: "Email Pegawai",
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
                              validator: editpgC.emailValidator,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Center(
                        child: Form(
                            child: Container(
                                height: 7.h,
                                width: 82.w,
                                child: DropdownSearch<String>(
                                  clearButtonProps: ClearButtonProps(
                                      isVisible: true,
                                      color: HexColor("#0B0C2B")),
                                  items: const [
                                    'Divisi Jahit',
                                    'Divisi Cetak',
                                    'Divisi Desain',
                                    'Divisi QA & Packing'
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      editpgC.divEdit.text = value;
                                    }
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      fillColor: HexColor("#BFC0D2"),
                                      filled: true,
                                      hintText: "Nama Divisi",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: HexColor("#5B5B6E"))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              width: 1, color: grey2)),
                                    ),
                                  ),
                                  popupProps: PopupProps.menu(
                                      fit: FlexFit.loose,
                                      menuProps: MenuProps(
                                        borderRadius: BorderRadius.circular(12),
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                      containerBuilder: (context, popupWidget) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 1.h)),
                                            Flexible(
                                                child: Container(
                                              child: popupWidget,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: HexColor("#BFC0D2"),
                                                    width: 0.3.w,
                                                  )),
                                            ))
                                          ],
                                        );
                                      },
                                      scrollbarProps: const ScrollbarProps(
                                          trackVisibility: true,
                                          trackColor: Colors.black),
                                      constraints: BoxConstraints(
                                        maxHeight: 20.h,
                                      )),
                                ))),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Center(
                        child: Container(
                          height: 4.5.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                              color: HexColor("#0B0C2B"),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              if (editpgC.namaKey.value.currentState!
                                      .validate() &&
                                  editpgC.emailKey.value.currentState!
                                      .validate()) {
                                editpgC.editPeg(
                                    indexData['email'],
                                    editpgC.namaEdit.text,
                                    editpgC.emailEdit.text,
                                    editpgC.divEdit.text);
                              }
                            },
                            child: Text(
                              "Simpan",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                    ]);
              }),
        ));
  }
}
