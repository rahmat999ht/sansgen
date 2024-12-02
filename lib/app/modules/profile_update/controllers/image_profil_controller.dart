import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImageUpdateController extends GetxController with StateMixin<List<XFile>> {
  final count = 0.obs;
  final ImagePicker _picker = ImagePicker();
  var imageFileList = <XFile>[];

  @override
  void onInit() {
    stateSuccess(imageFileList);
    super.onInit();
  }

  @override
  void onClose() {
    change([], status: RxStatus.empty());
    super.onClose();
  }

  void increment() => count.value++;

  getImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      // log("image ${image?.length ?? "kosong"}");
      if (image != null) {
        imageFileList = [image];
        stateSuccess(imageFileList);
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void stateSuccess(List<XFile> list) {
    change(list, status: list.isEmpty ? RxStatus.empty() : RxStatus.success());
  }

  // Fungsi untuk mendapatkan format file
  String? getImageFormat() {
    if (imageFileList.isNotEmpty) {
      return path.extension(imageFileList.first.path).replaceAll('.', '');
    }
    return null;
  }
}
