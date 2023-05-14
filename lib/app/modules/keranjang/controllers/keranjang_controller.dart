import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> cart() async* {
    yield* firestore
        .collection("Perencanaan")
        .orderBy('date', descending: false)
        .snapshots();

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
}
