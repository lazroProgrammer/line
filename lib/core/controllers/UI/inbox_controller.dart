import 'package:get/get.dart';

class InboxController extends GetxController {
  var isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 5), () {
      isLoaded.value = true;
    });
  }
}
