import 'package:intl/intl.dart';

class FormatProvider {
  String formatNumber(String input) {
    final formatter = NumberFormat("#,###");
    final number = num.parse(input);
    return formatter.format(number);
  }

  String formatPrice(String input) {
    final formatter = NumberFormat("#,###");
    final number = num.parse(input);
    return formatter.format(number);
  }
}
