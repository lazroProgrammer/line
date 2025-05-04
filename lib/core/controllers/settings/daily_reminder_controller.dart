import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';

class DailyReminderController extends ToggleController {
  DailyReminderController() : super(SettingsData().dailyReminder);

  @override
  void toggle() {
    super.toggle();
    SettingsData.setDailyReminder(obj.value);
  }
}
