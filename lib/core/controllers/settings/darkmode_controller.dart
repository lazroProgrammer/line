import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';

class DarkmodeController extends ToggleController {
  DarkmodeController() : super(SettingsData().darkmode);

  @override
  void toggle() {
    super.toggle();
    SettingsData.setdark(obj.value);
  }
}
