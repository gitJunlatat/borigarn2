import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateAction {
  static String getMonth(int month) {
    const List<String> months = ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'];
    return months[month - 1];
  }

  static DateTime getThaiCurrentDateTime() {
    DateTime now = DateTime.now();
    int thaiYear = now.year + 543;
    return DateTime(thaiYear, now.month, now.day);
  }

  static DateTime getThaiDateTime(DateTime dateTime) {
    int thaiYear = dateTime.year + 543;
    return DateTime(thaiYear, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
  }

  static String getMonthThShort(int month) {
    const List<String> months = ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'];
    return months[month - 1];
  }

  static String formatExpiredDate(DateTime dateTime) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    String formattedDate = DateFormat('d MMM yy, HH:mm น.', 'th').format(getThaiDateTime(dateTime));
    return formattedDate;
  }

  static String formatGroupEndDate(DateTime dateTime) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    String formattedDate = DateFormat('d MMM yy', 'th').format(getThaiDateTime(dateTime));
    return formattedDate;
  }

  static DateTime paidDateTime(DateTime dateTime) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    return dateTime;
  }

  static String getDateAndTimeStringFormatted(DateTime dateTime) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    String formattedDate = DateFormat('d MMM yy, HH:mm น.', 'th').format(getThaiDateTime(dateTime));
    return formattedDate;
  }

  static String getDateStringFormatted(DateTime dateTime) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    String formattedDate = DateFormat('d MMM yy', 'th').format(getThaiDateTime(dateTime));
    return formattedDate;
  }

  static String convertThaiDateToISODate(String thaiDate) {
    final months = {
      'ม.ค.': '01',
      'ก.พ.': '02',
      'มี.ค.': '03',
      'เม.ย.': '04',
      'พ.ค.': '05',
      'มิ.ย.': '06',
      'ก.ค.': '07',
      'ส.ค.': '08',
      'ก.ย.': '09',
      'ต.ค.': '10',
      'พ.ย.': '11',
      'ธ.ค.': '12',
    };

    final parts = thaiDate.split(' ');
    if (parts.length == 3) {
      final day = parts[0].padLeft(2,'0');
      final month = months[parts[1]];
      final year = '25${parts[2]}';
      final christYear = (int.parse(year) - 543).toString();
      return '$christYear-$month-$day';
    }
    return '';
  }
}
