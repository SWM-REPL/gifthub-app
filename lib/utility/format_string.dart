// 📦 Package imports:
import 'package:intl/intl.dart';

String currencyFormat(int? number) {
  return number == null ? '- 원' : NumberFormat('#,##0원').format(number);
}

String dateFormat(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String relativeDateFormat(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);
  if (diff.inDays > 30) {
    return '${(diff.inDays / 30).floor()}개월 전';
  } else if (diff.inDays > 7) {
    return '${(diff.inDays / 7).floor()}주 전}';
  } else if (diff.inDays > 0) {
    return '${diff.inDays}일 전';
  } else if (diff.inHours > 0) {
    return '${diff.inHours}시간 전';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes}분 전';
  } else {
    return '${diff.inSeconds}초 전';
  }
}
