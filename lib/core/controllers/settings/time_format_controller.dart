import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';

const timeFormats = ["HH:mm", "hh:mm a"];
const dateFormats = ["dd/MM/yyyy", "MM/dd/yyyy", "yyyy/MM/dd"];

class TimeFormatController extends GetxController {
  late RxString dateFormat;
  late RxString timeFormat;
  static SettingsData settings = SettingsData();
  TimeFormatController() {
    dateFormat = settings.dateFormat.obs;
    timeFormat = settings.regionalTime.obs;
    if (!timeFormats.contains(timeFormat.value)) {
      timeFormat.value = timeFormats.first;
    }
    if (!dateFormats.contains(dateFormat.value)) {
      dateFormat.value = dateFormats.first;
    }
  }
  void changeDateFormat(String dateForm) {
    settings.update(dateFormatP: dateForm);
    dateFormat.value = dateForm;
  }

  void changetimeFormat(String timeForm) {
    settings.update(regionalTimeP: timeForm);
    timeFormat.value = timeForm;
  }
}
