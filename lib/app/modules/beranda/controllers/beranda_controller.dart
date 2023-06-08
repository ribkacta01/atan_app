import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

class BerandaController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  DateTime? start;
  final end = DateTime.now().obs;
  final dateFormatter = DateFormat('yyyy-MM-dd');

  Stream<DocumentSnapshot<Map<String, dynamic>>> beranda() async* {
    var email = auth.currentUser!.email;
    yield* firestore.collection("users").doc(email).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugas(String dataDiv) async* {
    yield* firestore
        .collection("Tugas")
        .where('Status', isEqualTo: 'Belum Selesai')
        .where('Divisi', isEqualTo: dataDiv)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasDone(String dataDiv) async* {
    yield* firestore
        .collection("Tugas")
        .where('Status', isEqualTo: 'Selesai')
        .where('Divisi', isEqualTo: dataDiv)
        .snapshots();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
