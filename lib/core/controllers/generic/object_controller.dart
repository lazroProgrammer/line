import 'package:get/get.dart';

class ObjectController<T> extends GetxController {
  Rx<T> obj;
  ObjectController(T a) : obj = a.obs;

  void setValue(T a) {
    obj.value = a;
  }
}
