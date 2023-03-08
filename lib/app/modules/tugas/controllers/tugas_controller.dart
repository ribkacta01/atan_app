import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TugasController extends GetxController {
  //TODO: Implement TugasController

  final ImagePicker picker = ImagePicker();

  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print(image.name);
    } else {
      print(image);
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
