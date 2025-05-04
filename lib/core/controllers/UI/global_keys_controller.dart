import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalKeyController extends GetxController {
  RxList<GlobalKey> posKeys;

  GlobalKeyController(int length)
:        posKeys = List.generate(length, (_) => GlobalKey()).obs;

  void updateLength(int length) {
    posKeys = List.generate(length, (_) => GlobalKey()).obs;
  }
}
