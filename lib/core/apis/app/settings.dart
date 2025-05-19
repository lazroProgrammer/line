import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  static late SharedPreferences _preferences;
  static const isLoggedKey = 'login';
  static const darkmodeKey = 'darkmode';
  static const allowNotificationKey = 'allowNotification';
  static const dailyReminderKey = 'dailyReminder';
  static const msgNotificationKey = 'msgNotification';
  static const regionalTimeKey = 'regionalTime';
  static const dateFormatKey = 'dateFormatKey';
  static const nameKey = 'nameKey';
  static const emailKey = 'emailKey';
  static const userIDKey = 'userID';

  static final SettingsData _instance = SettingsData._internal();

  late bool darkmode;
  late bool allowNotifications;
  late bool dailyReminder;
  late bool msgNotificationReminder;

  late String regionalTime;
  late String dateFormat;

  late String name;
  late String email;
  late String userID;

  factory SettingsData() => _instance;

  SettingsData._internal() {
    darkmode = getdark() ?? false;
    allowNotifications = getNotification() ?? false;
    dailyReminder = getDailyReminder() ?? false;
    msgNotificationReminder = getmsgNotificationReminder() ?? false;
    regionalTime = getRegionalTimeFormat() ?? "dd/MM/yy";
    dateFormat = getDateFormat() ?? "HH:mm";
    name = getName() ?? "None";
    email = getEmail() ?? "example@wow.com";
    userID = getUserID() ?? "";
  }

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLogin(bool logged) async {
    await _preferences.setBool(isLoggedKey, logged);
  }

  static bool? getLogin() => _preferences.getBool(isLoggedKey);

  static Future setdark(bool b) async =>
      await _preferences.setBool(darkmodeKey, b);

  static bool? getdark() => _preferences.getBool(darkmodeKey);

  static Future setNotification(bool b) async =>
      await _preferences.setBool(allowNotificationKey, b);

  static bool? getNotification() => _preferences.getBool(allowNotificationKey);

  static Future setDailyReminder(bool b) async =>
      await _preferences.setBool(dailyReminderKey, b);

  static bool? getDailyReminder() => _preferences.getBool(dailyReminderKey);

  static Future setmsgNotificationReminder(bool b) async =>
      await _preferences.setBool(msgNotificationKey, b);

  static bool? getmsgNotificationReminder() =>
      _preferences.getBool(msgNotificationKey);

  static Future setRegionalTimeFormat(String b) async =>
      await _preferences.setString(regionalTimeKey, b);

  static String? getRegionalTimeFormat() =>
      _preferences.getString(regionalTimeKey);

  static Future setDateFormat(String b) async =>
      await _preferences.setString(dateFormatKey, b);

  static String? getDateFormat() => _preferences.getString(dateFormatKey);

  static Future setName(String b) async =>
      await _preferences.setString(nameKey, b);

  static String? getName() => _preferences.getString(nameKey);

  static Future setEmail(String b) async =>
      await _preferences.setString(emailKey, b);

  static String? getEmail() => _preferences.getString(emailKey);

  static Future setUserID(String b) async =>
      await _preferences.setString(userIDKey, b);

  static String? getUserID() => _preferences.getString(userIDKey);

  void update({
    bool? darkTheme,
    bool? notifications,
    bool? dailyReminderP,
    bool? msgNotificationReminderP,
    String? regionalTimeP,
    String? dateFormatP,
    String? nameP,
    String? emailP,
    String? userIDP,
  }) {
    void updateField<T>(
      T? value,
      void Function(T) setter,
      void Function(T) assign,
    ) {
      if (value != null) {
        setter(value);
        assign(value);
      }
    }

    updateField<bool>(darkTheme, setdark, (v) => darkmode = v);
    updateField<bool>(
      notifications,
      setNotification,
      (v) => allowNotifications = v,
    );
    updateField<bool>(
      dailyReminderP,
      setDailyReminder,
      (v) => dailyReminder = v,
    );
    updateField<bool>(
      msgNotificationReminderP,
      setmsgNotificationReminder,
      (v) => msgNotificationReminder = v,
    );
    updateField<String>(
      regionalTimeP,
      setRegionalTimeFormat,
      (v) => regionalTime = v,
    );
    updateField<String>(dateFormatP, setDateFormat, (v) => dateFormat = v);
    updateField<String>(nameP, setName, (v) => name = v);
    updateField<String>(emailP, setEmail, (v) => email = v);
    updateField<String>(userIDP, setUserID, (v) => userID = v);
  }

  AppUser getUser() {
    return AppUser(id: userID, email: email, name: name);
  }
}
