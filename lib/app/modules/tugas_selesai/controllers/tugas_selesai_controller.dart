import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TugasSelesaiController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> tugasList() async* {
    yield* firestore.collection("Tugas").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasDiv(
      String dataPemesan) async* {
    yield* firestore
        .collection("Tugas")
        .where("Nama Pemesan", isEqualTo: dataPemesan)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasDone() async* {
    yield* firestore
        .collection("Tugas")
        .where("Status", isEqualTo: 'Selesai')
        .snapshots();
  }

  var isChanged = (-1).obs;
  var isVisible = false.obs;

  void showWidgetWithDelay() async {}
  void toggleExpanded(int index) async {
    isChanged.value = isChanged.value == index ? -1 : index;
    if (isChanged.value == index) {
      await Future.delayed(Duration(milliseconds: 250));
      isVisible.value = true;
    }
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
