import 'package:intl/intl.dart';

class FormatProvider {
  String formatNumber(String input) {
    final formatter = NumberFormat("#,###");
    final number = num.parse(input);
    return formatter.format(number);
  }

  String formatRating(String input) {
    final formatter = NumberFormat("#");
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
      case 'PAID_WITH_WALLET':
        return 'Thanh toán bằng ví';
      case 'PAID_WITH_VNPAY':
        return 'Thanh toán bằng thẻ';
      case 'REFUND':
        return 'Hoàn tiền vào ví';
      default:
        return 'Giao dịch khác';
    }
  }

  String convertTypeImage(String inputType) {
    switch (inputType) {
      case 'TOPUP':
        return 'assets/images/TOPUP.png';
      case 'PAID_WITH_WALLET':
        return 'assets/images/PAID_WITH_WALLET.png';
      case 'PAID_WITH_VNPAY':
        return 'assets/images/PAID_WITH_VNPAY.png';
      case 'REFUND':
        return 'assets/images/REFUND.png';
      default:
        return 'assets/images/OTHER.png';
    }
  }

  bool convertPlusOrMinus(String inputType) {
    switch (inputType) {
      case 'TOPUP':
        return true;
      case 'PAID_WITH_WALLET':
        return false;
      case 'REFUND':
        return true;
      case 'PAID_WITH_VNPAY':
        return false;
      default:
        return false;
    }
  }

  String convertDateOfBirth(String inputDate) {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(inputDate);
    String formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  int countDays(DateTime startDate, DateTime endDate) {
    int count = 0;
    for (DateTime date = startDate;
        (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
        date = date.add(const Duration(days: 1))) {
      if (date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday) {
        count++;
      }
    }
    return count;
  }

  int countWeekendDays(DateTime startDate, DateTime endDate) {
    int count = 0;
    if (!startDate.isAtSameMomentAs(endDate)) {
      for (DateTime date = startDate;
          (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
          date = date.add(const Duration(days: 1))) {
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          count++;
        }
      }
      return count;
    } else if (startDate.weekday == DateTime.saturday ||
        startDate.weekday == DateTime.sunday) {
      return 1;
    } else {
      return 0;
    }
  }

  int countNormalDays(DateTime startDate, DateTime endDate) {
    int count = 0;
    if (!startDate.isAtSameMomentAs(endDate)) {
      for (DateTime date = startDate;
          (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
          date = date.add(const Duration(days: 1))) {
        if (date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday) {
          count++;
        }
      }
      return count;
    } else if (startDate.weekday != DateTime.saturday &&
        startDate.weekday != DateTime.sunday) {
      return 1;
    } else {
      return 0;
    }
  }
}
