import 'package:intl/intl.dart';

class FormatProvider {
  String formatNumber(String input) {
    final formatter = NumberFormat("#,###");
    final number = double.parse(input);
    return formatter.format(number);
  }

  String formatPrice(String input) {
    final formatter = NumberFormat("#,###");
    final number = double.parse(input);
    return formatter.format(number);
  }
}
