import 'package:intl/intl.dart';

String formatedTime(String format, DateTime t) {
  return DateFormat(format).format(t);
}
