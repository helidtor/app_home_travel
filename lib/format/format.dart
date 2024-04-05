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

  String formatWalletToTopUp(String input) {
    final formatter = NumberFormat("#,###");
    final number = num.parse(input);
    return formatter.format(number);
  }

  String convertDateTimeFormat(String inputDate) {
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

  String convertDateTime(String inputDate) {
    return DateFormat("dd/MM/yyyy - hh:mm:ss")
        .format(DateTime.parse(inputDate));
  }

  String convertTime(String inputDate) {
    return DateFormat("hh:mm:ss").format(DateTime.parse(inputDate));
  }

  String convertDate(String inputDate) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(inputDate));
  }

  String convertDateTimeBooking(String inputDate) {
    return DateFormat("dd/MM/yy").format(DateTime.parse(inputDate));
  }

  String formatString(String input) {
    String cleanedInput = input.replaceAll(',', '');
    return cleanedInput;
  }

  String convertType(String inputType) {
    switch (inputType) {
      case 'TOPUP':
        return 'Nạp tiền vào ví';
      case 'PAID':
        return 'Thanh toán bằng ví';
      case 'PAID_WITH_CASH':
        return 'Thanh toán bằng thẻ';
      default:
        return '';
    }
  }

  String convertTypeImage(String inputType) {
    switch (inputType) {
      case 'TOPUP':
        return 'assets/images/TOPUP.png';
      case 'PAID':
        return 'assets/images/PAID.png';
      case 'PAID_WITH_CASH':
        return 'assets/images/PAID_WITH_CASH.png';
      default:
        return '';
    }
  }

  bool convertPlusOrMinus(String inputType) {
    switch (inputType) {
      case 'TOPUP':
        return true;
      case 'PAID':
        return false;
      case 'PAID_WITH_CASH':
        return false;
      default:
        return false;
    }
  }
}
