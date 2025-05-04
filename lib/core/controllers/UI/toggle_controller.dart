import 'package:line/core/controllers/generic/object_controller.dart';

class ToggleController extends ObjectController<bool> {
  ToggleController(super.a);

  void toggle() {
    obj.value = !obj.value;
  }
}
