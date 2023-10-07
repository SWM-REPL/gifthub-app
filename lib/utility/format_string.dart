// 📦 Package imports:
import 'package:intl/intl.dart';

String currencyFormat(int number) {
  return NumberFormat('#,##0원').format(number);
}

String dateFormat(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
