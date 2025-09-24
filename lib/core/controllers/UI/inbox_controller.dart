import 'package:get/get.dart';

// was used for the inboxes screen to simulate fetching at first
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
