import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';

class MsgNotificationReminderController extends ToggleController {
  MsgNotificationReminderController()
    : super(SettingsData().msgNotificationReminder);

  @override
  void toggle() {
    super.toggle();
    SettingsData.setmsgNotificationReminder(obj.value);
  }
}
