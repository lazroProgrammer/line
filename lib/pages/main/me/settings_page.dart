import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';
import 'package:line/core/controllers/settings/daily_reminder_controller.dart';
import 'package:line/core/controllers/settings/msg_notification_reminder.dart';
import 'package:line/core/controllers/settings/time_format_controller.dart';
import 'package:line/pages/main/me/settings/terms_of_use.dart';
import 'package:line/widgets/settings/settings_group.dart';
import 'package:path_provider/path_provider.dart';

final exampleDate = DateTime(2019, 3, 18, 13, 20);

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final GlobalKey key2 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ToggleController darkmode = Get.find(tag: "dark");
    final DailyReminderController dailyReminderC = Get.put(
      DailyReminderController(),
    );
    final MsgNotificationReminderController msgNotificationReminderC = Get.put(
      MsgNotificationReminderController(),
    );
    final TimeFormatController timeFormatController = Get.put(
      TimeFormatController(),
    );

    // final TransactionsController trController = Get.find(tag: "transactions");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: ListView(
          children: [
            SettingGroup(icon: Icons.tune, label: "General"),
            Divider(),
            Obx(() {
              final dark = darkmode.obj.value;
              return SwitchListTile(
                value: dark,
                title: const Text('Darkmode'),
                onChanged: (bool value) {
                  darkmode.toggle();
                },
                secondary: const Icon(Icons.dark_mode, size: 30),
              );
            }),
            ExpansionTile(
              title: const Text('Notifications'),
              leading: const Icon(Icons.notifications, size: 30),
              children: <Widget>[
                Obx(() {
                  final dailyReminder = dailyReminderC.obj.value;
                  return SwitchListTile(
                    value: dailyReminder,
                    title: const Text('daily reminder'),
                    onChanged: (bool value) {
                      // dailyReminderC.toggle();
                      // if (value) {
                      //   NotificationApi().showNotification(
                      //       title: "money shark",
                      //       body: "Notification allowed",
                      //       payload: "payload");
                      // }
                    },
                    secondary: const Icon(Icons.calendar_month),
                  );
                }),
                Obx(() {
                  final msgNotificationReminder =
                      msgNotificationReminderC.obj.value;
                  return SwitchListTile(
                    value: msgNotificationReminder,
                    title: const Text('deadline reminder'),
                    onChanged: (bool value) {
                      msgNotificationReminderC.toggle();
                    },
                    secondary: const Icon(Icons.calendar_month),
                  );
                }),
              ],
            ),
            ExpansionTile(
              title: const Text('Region Settings'),
              leading: const Icon(Icons.location_city, size: 30),
              children: <Widget>[
                ListTile(
                  title: Text("Language"),
                  leading: const Icon(Icons.language),
                  onTap: () {},
                  // trailing: DropdownButton<String>(
                  //   value: selectedCountry.value,
                  //   onChanged: (String? newValue) {
                  //     if (newValue != null) {
                  //       ref.read(countryNotifier.notifier).setCountry(
                  //           ProductHandler.countriesList.indexOf(newValue));
                  //     }
                  //     selectedCountry.value = newValue;
                  //   },
                  //   items: ProductHandler.countriesList
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  // ),
                ),
                Obx(() {
                  final selectedDate = timeFormatController.dateFormat;
                  final selectedTime = timeFormatController.timeFormat;
                  return Column(
                    children: [
                      ListTile(
                        title: Text("date format"),
                        leading: const Icon(Icons.date_range),
                        trailing: DropdownButton<String>(
                          value: selectedDate.value,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              timeFormatController.changeDateFormat(newValue);
                            }
                          },
                          items:
                              dateFormats.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      ),
                      ListTile(
                        title: Text("regional time"),
                        leading: const Icon(Icons.access_time),
                        trailing: DropdownButton<String>(
                          value: selectedTime.value,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              timeFormatController.changetimeFormat(newValue);
                            }
                          },
                          items:
                              timeFormats.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 10,
                        ),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: 18),
                            children: [
                              TextSpan(
                                text: "18 march 2019 13:20",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: " will be shown like this: "),
                              TextSpan(
                                text: DateFormat(
                                  "${selectedDate.value} ${selectedTime.value}",
                                ).format(exampleDate),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      (darkmode.obj.value)
                                          ? Colors.green
                                          : Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),

            SizedBox(height: 10),
            SettingGroup(icon: Icons.security, label: "Data and security"),
            const Divider(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: ListTile(
                leading: const Icon(Icons.delete, color: Colors.red, size: 24),
                title: const Text(
                  'Delete all data',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  // QuickAlert.show(
                  //   context: context,
                  //   type: QuickAlertType.confirm,
                  //   title: "Are you sure?",
                  //   text: "Do you want to delete all Transactions?",
                  //   onCancelBtnTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   onConfirmBtnTap: () async {
                  //     // TransactionsController transactionsController = Get.find(
                  //     //   tag: "transactions",
                  //     // );
                  //     // int result =
                  //     //     await transactionsController.deleteAllTransactions();
                  //     // if (result != -1) {
                  //     //   Fluttertoast.showToast(
                  //     //     msg: "Transactions successfully deleted",
                  //     //   );
                  //     // } else {
                  //     //   Fluttertoast.showToast(
                  //     //     msg: "An Error occured, Try another time",
                  //     //   );
                  //     // }
                  //     if (context.mounted) {
                  //       Navigator.pop(context);
                  //     }
                  //   },
                  // );
                },
              ),
            ),
            SizedBox(height: 10),
            SettingGroup(icon: Icons.help_outline, label: "about and support"),
            Divider(),
            // ListTile(
            //   leading: const Icon(Icons.info),
            //   // title: Text(AppLocalizations.of(context)!.solve_common_issues),
            //   title: Text("solve common issues"),
            //   onTap: () {},
            // ),
            ListTile(
              leading: const Icon(Icons.feedback, size: 30),
              title: Text("Feedback"),
              onTap: () {
                // BetterFeedback.of(Get.context!).show((feedback) async {
                //   await Future.delayed(Duration(milliseconds: 500));

                //   // draft an email and send to developer
                //   final screenshotFilePath = await writeImageToStorage(
                //     feedback.screenshot,
                //   );

                //   final Email email = Email(
                //     body: feedback.text,
                //     subject: 'App Feedback',
                //     recipients: [dotenv.env["FEEDBACK_EMAIL"] ?? ""],
                //     attachmentPaths: [screenshotFilePath],
                //     isHTML: false,
                //   );
                //   await FlutterEmailSender.send(email);
                //   Fluttertoast.showToast(
                //     timeInSecForIosWeb: 3,
                //     msg:
                //         "open and close the feedback overlay to return to normal state, sorry about that",
                //   );
                // });
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report, size: 30),
              title: Text("bug report"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.text_snippet, size: 30),
              title: Text("terms of use"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TermsOfUsePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
