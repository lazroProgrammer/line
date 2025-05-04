import 'package:line/core/controllers/generic/object_controller.dart';

class IndexController extends ObjectController<int> {
  IndexController(super.a);

  void set(int a) {
    obj.value = a;
  }
}
