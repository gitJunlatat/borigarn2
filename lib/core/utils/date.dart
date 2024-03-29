import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:flutter/material.dart';
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

  static String getDateStringFormatted(DateTime dateTime, LanguageType locale) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    String formattedDate = DateFormat('d MMM yy', locale.name).format(getThaiDateTime(dateTime));
    return formattedDate;
  }

  static String getDateStringFormattedPayload(DateTime dateTime) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  static String getDateTimeStringFormattedPayload(DateTime dateTime) {
    tz.initializeTimeZones();
    tz.Location timeZone = tz.getLocation('Asia/Bangkok');

    dateTime = tz.TZDateTime.from(dateTime, timeZone);
    String formattedDate = DateFormat('yyyy-MM-dd MM:HH').format(dateTime);
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


double adjustheight(double height) => heightRatio * height;
double adjustwidth(double width) => widthRatio * width;
double adjustHeightV2(double height) => (heightRatio * height) > height ? height : heightRatio * height;
double adjustWidthV2(double width) => (widthRatio * width) > width ? width : widthRatio * width;
double adjustMinHeight(double height) => (heightRatio * height) < height ? height : heightRatio * height;
double adjustMinWidth(double width) => (widthRatio * width) < width ? width : widthRatio * width;
Size size = GetSize.deviceSize();
double height = GetSize.height();
double width = GetSize.width();
double heightRatio = GetSize.heightRatio();
double widthRatio = GetSize.widthRatio();
double statusBarHeight = GetSize.statusBarHeight();

class GetSize {
  static Size deviceSize() {
    return (View.of(rootContext()!).physicalSize / View.of(rootContext()!).devicePixelRatio);
  }

  static double height() {
    return (View.of(rootContext()!).physicalSize.height / View.of(rootContext()!).devicePixelRatio);
  }

  static double width() {
    return (View.of(rootContext()!).physicalSize.width / View.of(rootContext()!).devicePixelRatio);
  }

  static double heightRatio() {
    return height() / 800; // in Design height
  }

  static double widthRatio() {
    return width() / 360; // in Design width
  }

  static double statusBarHeight() {
    return View.of(rootContext()!).viewPadding.top / View.of(rootContext()!).devicePixelRatio;
  }
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}

class SizeNotifier extends ChangeNotifier {
  double bottomPaddingHeight = 0;
  void getBottomPaddingHeight(double bottomHeight) {
    bottomPaddingHeight = bottomHeight;
    notifyListeners();
  }
}

