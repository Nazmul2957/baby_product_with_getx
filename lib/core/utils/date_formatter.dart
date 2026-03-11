// lib/core/utils/date_formatter.dart

import 'package:intl/intl.dart';

class DateFormatter {

  static String formatDate(DateTime date) {
    return DateFormat("dd MMM yyyy").format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat("dd MMM yyyy, hh:mm a").format(date);
  }
}