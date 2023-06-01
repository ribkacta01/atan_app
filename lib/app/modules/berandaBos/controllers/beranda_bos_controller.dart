import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BerandaBosController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> berandaBos() async* {
    var email = auth.currentUser!.email;
    yield* firestore.collection("users").doc(email).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasPeg() async* {
    yield* firestore
        .collection("Tugas")
        .orderBy('Tanggal Pesan', descending: true)
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
