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

  String convertDateFormat(String inputDate) {
    List<String> parts = inputDate.split('/');
    if (parts.length != 3) {
      return inputDate;
    }

    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    DateTime dateTime = DateTime(year, month, day);

    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  String convertDate(String inputDate) {
    return DateFormat("dd/MM/yyyy - hh:mm:ss")
        .format(DateTime.parse(inputDate));
  }
}
