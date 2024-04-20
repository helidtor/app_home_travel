import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';

class CancelFunctionProvider {
  void dialogCancelPending(
      BuildContext context, BookingHomestayModel bookingHomestayModel) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Lưu ý',
            style: TextStyle(
              color: AppColors.primaryColor3,
              fontSize: 20,
            ),
          ),
          content: const Text(
            'Bạn có chắc muốn\nhủy đơn này không?',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: TextButton(
              onPressed: () async {
                bookingHomestayModel.status = 'CANCELLED';
                var checkUpdateBooking = await ApiBooking.updateBooking(
                    bookingInput: bookingHomestayModel);
                print(checkUpdateBooking);
                if (checkUpdateBooking) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigatorBar(
                        stt: 3,
                      ),
                    ),
                  );
                  toastification.show(
                      showProgressBar: false,
                      pauseOnHover: false,
                      progressBarTheme: const ProgressIndicatorThemeData(
                        color: Colors.green,
                      ),
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      foregroundColor: Colors.black,
                      context: context,
                      type: ToastificationType.success,
                      style: ToastificationStyle.flatColored,
                      title: const TextContent(
                        contentText: "Hủy đơn thành công!",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      autoCloseDuration: const Duration(milliseconds: 1500),
                      animationDuration: const Duration(milliseconds: 500),
                      alignment: Alignment.topRight);
                } else {
                  Navigator.pop(context);
                  toastification.show(
                      showProgressBar: false,
                      pauseOnHover: false,
                      progressBarTheme: const ProgressIndicatorThemeData(
                        color: Colors.red,
                      ),
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.red,
                      ),
                      foregroundColor: Colors.black,
                      context: context,
                      type: ToastificationType.error,
                      style: ToastificationStyle.flatColored,
                      title: const TextContent(
                        contentText: "Hủy đơn thất bại!",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      autoCloseDuration: const Duration(milliseconds: 1500),
                      animationDuration: const Duration(milliseconds: 500),
                      alignment: Alignment.topRight);
                }
              },
              child: const Text(
                'Có',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor3,
                  fontSize: 17,
                ),
              ),
            )),
            //hủy đơn booking
            CupertinoDialogAction(
                child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Không',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor3,
                  fontSize: 17,
                ),
              ),
            )),
          ],
        );
      },
    );
  }
}
