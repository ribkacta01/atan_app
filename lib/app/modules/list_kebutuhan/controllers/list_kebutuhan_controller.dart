import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListKebutuhanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> list(String docName) async* {
    yield* firestore
        .collection("Perencanaan")
        .doc(docName)
        .collection('Kebutuhan')
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
