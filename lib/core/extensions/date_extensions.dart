import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  String get formatted => DateFormat('dd MMM yyyy').format(this);
  String get formattedTime => DateFormat('hh:mm a').format(this);
  String get formattedDateTime => DateFormat('dd MMM yyyy, hh:mm a').format(this);
  String get formattedMonthYear => DateFormat('MMMM yyyy').format(this);
  String get formattedDay => DateFormat('EEEE').format(this);
  String get formattedShortDay => DateFormat('EEE').format(this);
  String get formattedMonth => DateFormat('MMMM').format(this);
  String get formattedShortMonth => DateFormat('MMM').format(this);

  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
  DateTime get startOfMonth => DateTime(year, month, 1);
  DateTime get endOfMonth => DateTime(year, month + 1, 0);
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1));
  DateTime get endOfWeek => add(Duration(days: 7 - weekday));

  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
  bool get isWeekday => !isWeekend;

  String get relative {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        if (diff.inMinutes == 0) return 'Just now';
        return '${diff.inMinutes}m ago';
      }
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) return 'Yesterday';
    else if (diff.inDays < 7) return '${diff.inDays}d ago';
    else if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    else if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }
}
