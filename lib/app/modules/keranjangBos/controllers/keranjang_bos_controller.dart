import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class KeranjangBosController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var lastDocumentSnapshot = Rxn<QueryDocumentSnapshot>();
  final collection = FirebaseFirestore.instance.collection('Perencanaan');

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> keranjang() {
    return collection.orderBy('date').limit(5).snapshots().map(
          (snapshot) => snapshot.docs,
        );
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> olahSearch;

  final TextEditingController searchController = TextEditingController();
  final BehaviorSubject<String> searchQuery = BehaviorSubject<String>();

  // RxString searchQuery = ''.obs;

  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  var isSearching = false.obs;

  Future<void> loadMore() async {
    final snapshot = await collection
        .orderBy('date')
        .startAfterDocument(lastDocumentSnapshot.value!)
        .limit(5)
        .get();
    lastDocumentSnapshot.value = snapshot.docs.lastOrNull;
  }

  // final limit = 5.obs;
  // final lastDocumentSnapshot = Rxn<QueryDocumentSnapshot>();

  // Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> keranjang() async* {
  //   yield* firestore
  //       .collection("Perencanaan")
  //       .orderBy('date', descending: true)
  //       .limit(limit.value)
  //       .snapshots()
  //       .map((snapshot) {
  //     lastDocumentSnapshot.value =
  //         snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
  //     return snapshot.docs;
  //   });
  // }

  // void loadMore() {
  //    limit.value += 5;
  //  }

  // final count = 0.obs;
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

  // void increment() => count.value++;
}
