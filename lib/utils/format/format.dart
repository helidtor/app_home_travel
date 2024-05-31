import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FormatProvider {
  String formatNumber(String input) {
    // final formatter = NumberFormat("#,###");
    var formatter = NumberFormat.decimalPattern('vi_VN');
    final number = num.parse(input);
    return formatter.format(number);
  }

  String formatRating(String input) {
    final formatter = NumberFormat("#");
    final number = num.parse(input);
    return formatter.format(number);
  }

  String formatPrice(String input) {
    // final formatter = NumberFormat("#,###");
    var formatter = NumberFormat.decimalPattern('vi_VN');
    final number = num.parse(input);
    return formatter.format(number);
  }

  String formatWalletToTopUp(String input) {
    // final formatter = NumberFormat("#,###");
    var formatter = NumberFormat.decimalPattern('vi_VN');
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
    return DateFormat("dd/MM/yyyy - HH:mm:ss")
        .format(DateTime.parse(inputDate));
  }

  String convertDateTimeFeedback(String inputDate) {
    return DateFormat("dd/MM/yyyy - HH:mm:ss a")
        .format(DateTime.parse(inputDate));
  }

  String convertTime(String inputDate) {
    return DateFormat("hh:mm:ss").format(DateTime.parse(inputDate));
  }

  String convertDate(String inputDate) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(inputDate));
  }

  String convertDateMonth(String inputDate) {
    return DateFormat("dd/MM").format(DateTime.parse(inputDate));
  }

  String convertDateTimeBooking(String inputDate) {
    return DateFormat("dd/MM/yy").format(DateTime.parse(inputDate));
  }

  String formatString(String input) {
    String cleanedInput = input.replaceAll('.', '');
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
      case 'WITHDRAW':
        return 'Rút tiền';
      default:
        return 'Giao dịch khác';
    }
  }

  bool? convertSourceMoney(String inputType) {
    switch (inputType) {
      case 'TOPUP':
        return false;
      case 'PAID_WITH_WALLET':
        return true;
      case 'PAID_WITH_VNPAY':
        return false;
      case 'REFUND':
        return null;
      case 'WITHDRAW':
        return true;
      default:
        return null;
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
      case 'WITHDRAW':
        return 'assets/images/OTHER.png';
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
      case 'WITHDRAW':
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

  DateTime convertOriginalDate(DateTime inputDate) {
    DateTime originalDateTime = inputDate;
    DateTime newDateTime = DateTime(
      originalDateTime.year,
      originalDateTime.month,
      originalDateTime.day,
    );
    // print('sau khi convert: $newDateTime');
    return newDateTime;
  }

  int countDays(DateTime startDate, DateTime endDate) {
    int count = 0;
    //convert về giờ phút giây = 0 để so sánh isBefore
    DateTime dateStart = convertOriginalDate(startDate);
    DateTime dateEnd = convertOriginalDate(endDate);

    for (DateTime date = dateStart;
        (date.isBefore(dateEnd));
        date = date.add(const Duration(days: 1))) {
      count++;
      // print(
      //     'lần thứ $count  ngày ${FormatProvider().convertDate(date.toString())}');
    }
    // print('tổng số ngày là $count');
    return count;
  }

  int countWeekendDays(DateTime startDate, DateTime endDate) {
    int count = 0;
    if (!startDate.isAtSameMomentAs(endDate)) {
      for (DateTime date = startDate;
          (date.isBefore(endDate));
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
    // print('bbbbbb $endDate $startDate');
    int count = 0;
    if (!startDate.isAtSameMomentAs(endDate)) {
      for (DateTime date = startDate;
          (date.isBefore(endDate));
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

  String convertTo24HourFormat(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedTime =
        DateFormat('hh:mm a').format(dateTime); //định dạng giờ:phút sáng/chiều
    return formattedTime;
  }

  DateTime convertStringToDateTime(String dateString) {
    // Định dạng của chuỗi đầu vào
    final inputFormat = DateFormat('hh:mm a - dd/MM/yyyy');
    // Parse chuỗi thành DateTime
    final dateTime = inputFormat.parse(dateString);
    // print('time sau khi convert từ chuỗi thành date: $dateTime');
    return dateTime;
  }

  DateTime convertTimeEarlierOneHour(String dateString) {
    // Parse chuỗi thành DateTime
    final dateTime = DateTime.parse(dateString);
    // Trừ đi một giờ
    final modifiedDateTime = dateTime.subtract(const Duration(hours: 1));
    print('modifiedDateTime là $modifiedDateTime');
    return modifiedDateTime;
  }

  String formatDateChat(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formatter = DateFormat('dd/MM H:mm a');
    return formatter.format(dateTime);
  }
}
