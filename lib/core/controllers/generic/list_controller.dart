import 'package:get/get.dart';

class ListController<T> extends GetxController {
  RxList<T> values = <T>[].obs;

  void addList(List<T> a) {
    values.addAll(a);
  }

  void add(T a) {
    values.add(a);
  }

  void remove(T a) {
    values.remove(a);
  }
}
