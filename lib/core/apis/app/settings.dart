import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  static late SharedPreferences _preferences;
  static const isLoggedKey = 'login';

  static const darkmodeKey = 'darkmode';

  static const allowNotificationKey = 'allowNotification';
  static const dailyReminderKey = 'dailyReminder';
  static const msgNotificationKey = 'msgNotification';

  static const currencyKey = 'preferedCurrency';
  static const regionalTimeKey = 'regionalTime';
  static const dateFormatKey = 'dateFormatKey';

  static final SettingsData _instance = SettingsData._internal();
  late bool darkmode;

  late bool allowNotifications;
  late bool dailyReminder;
  late bool msgNotificationReminder;

  late String prefferedCurrency;
  late String regionalTime;
  late String dateFormat;
  final String localId = "setting";

  factory SettingsData() {
    return _instance;
  }

  // TODO: change currency init
  SettingsData._internal() {
    darkmode = getdark() ?? false;
    allowNotifications = getNotification() ?? false;
    dailyReminder = getDailyReminder() ?? false;
    prefferedCurrency = getCurrency() ?? "\$";
    msgNotificationReminder = getmsgNotificationReminder() ?? false;
    regionalTime = getRegionalTimeFormat() ?? "dd/MM/yy";
    dateFormat = getDateFormat() ?? "HH:mm";
  }

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLogin(bool logged) async {
    await _preferences.setBool(isLoggedKey, logged);
  }

  static bool? getLogin() => _preferences.getBool(isLoggedKey);

  static Future setdark(bool b) async {
    await _preferences.setBool(darkmodeKey, b);
  }

  static bool? getdark() => _preferences.getBool(darkmodeKey);

  static Future setCurrency(String b) async {
    await _preferences.setString(currencyKey, b);
  }

  static String? getCurrency() => _preferences.getString(currencyKey);

  static Future setNotification(bool b) async {
    await _preferences.setBool(allowNotificationKey, b);
  }

  static bool? getNotification() => _preferences.getBool(allowNotificationKey);

  static Future setDailyReminder(bool b) async {
    await _preferences.setBool(dailyReminderKey, b);
  }

  static bool? getDailyReminder() => _preferences.getBool(dailyReminderKey);

  static Future setmsgNotificationReminder(bool b) async {
    await _preferences.setBool(msgNotificationKey, b);
  }

  static bool? getmsgNotificationReminder() =>
      _preferences.getBool(msgNotificationKey);

  static Future setRegionalTimeFormat(String b) async {
    await _preferences.setString(regionalTimeKey, b);
  }

  static String? getRegionalTimeFormat() =>
      _preferences.getString(regionalTimeKey);

  static Future setDateFormat(String b) async {
    await _preferences.setString(dateFormatKey, b);
  }

  static String? getDateFormat() => _preferences.getString(dateFormatKey);

  void update({
    bool? darkTheme,
    bool? notifications,
    bool? dailyReminderP,
    bool? msgNotificationReminderP,
    String? currencyP,
    String? regionalTimeP,
    String? dateFormatP,
  }) {
    if (darkTheme != null) {
      setdark(darkTheme);
      darkmode = darkTheme;
    }
    if (notifications != null) {
      setNotification(notifications);
      allowNotifications = notifications;
    }
    if (dailyReminderP != null) {
      setDailyReminder(dailyReminderP);
      dailyReminder = dailyReminderP;
    }
    if (msgNotificationReminderP != null) {
      setmsgNotificationReminder(msgNotificationReminderP);
      msgNotificationReminder = msgNotificationReminderP;
    }
    if (currencyP != null) {
      setCurrency(currencyP);
      prefferedCurrency = currencyP;
    }
    if (regionalTimeP != null) {
      setRegionalTimeFormat(regionalTimeP);
      regionalTime = regionalTimeP;
    }
    if (dateFormatP != null) {
      setDateFormat(dateFormatP);
      dateFormat = dateFormatP;
    }
  }
}
