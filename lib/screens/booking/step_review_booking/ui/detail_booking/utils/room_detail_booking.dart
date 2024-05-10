// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/row_text.dart';
import 'package:mobile_home_travel/screens/room/room_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomDetailBooking extends StatefulWidget {
  int countDayInWeek;
  int countDayWeekend;
  BookingDetailModel bookingDetailModel;
  RoomDetailBooking({
    super.key,
    required this.countDayInWeek,
    required this.countDayWeekend,
    required this.bookingDetailModel,
  });

  @override
  State<RoomDetailBooking> createState() => _RoomDetailBookingState();
}

class _RoomDetailBookingState extends State<RoomDetailBooking> {
  late BookingDetailModel bookingDetailModel;
  late int countDayInWeek;
  late int countDayWeekend;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingDetailModel = widget.bookingDetailModel;
    countDayInWeek = widget.countDayInWeek;
    countDayWeekend = widget.countDayWeekend;
    print('ngày thường: $countDayInWeek \n ngày cuối tuần: $countDayWeekend');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor1.withOpacity(0.2),
              spreadRadius: 0.1,
              blurRadius: 9,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: 5,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    SharedPreferencesUtil.setIdRoom(bookingDetailModel.roomId!);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const roomDetail()),
                    );
                  },
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.primaryColor3.withOpacity(0.7),
                    size: 18,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    bookingDetailModel.room!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          subtitle: Column(
            children: [
              RowText().richText(
                  title: 'Sức chứa',
                  content: bookingDetailModel.room!.capacity!.toString(),
                  icon: Icons.person_add_alt),
              const SizedBox(
                height: 3,
              ),
              RowText().richText(
                  title: 'Số giường',
                  content: bookingDetailModel.room!.numberOfBeds!.toString(),
                  icon: Icons.bed_outlined),
              const SizedBox(
                height: 3,
              ),
              RowText().richText(
                title: 'Tổng tiền phòng',
                content:
                    '${(FormatProvider().formatPrice((bookingDetailModel.room!.price! * countDayInWeek + bookingDetailModel.room!.weekendPrice! * countDayWeekend).toString()))} đ',
                icon: Icons.monetization_on_outlined,
              ),
              const SizedBox(
                height: 3,
              ),
            ],
          ),
          children: [
            _detailPriceOfRoom(
              normalPrice: bookingDetailModel.room!.price!,
              weekendPrice: bookingDetailModel.room!.weekendPrice!,
              quantityNormalDay: countDayInWeek,
              quantityWeekendDay: countDayWeekend,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _detailPriceOfRoom({
  required int quantityNormalDay,
  required int quantityWeekendDay,
  required num normalPrice,
  required num weekendPrice,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primaryColor3, width: 0.2),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chi tiết giá phòng',
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black.withOpacity(0.65)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                (quantityNormalDay != 0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${FormatProvider().formatPrice(normalPrice.toString())} đ',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ), //giá trong tuần
                          const Expanded(flex: 1, child: Text('x')),
                          Expanded(
                            flex: 4,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: quantityNormalDay
                                        .toString(), //số ngày trong tuần
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' ngày trong tuần',
                                    style: TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${FormatProvider().formatPrice((quantityNormalDay * normalPrice).toString())} đ', //tổng giá trong tuần
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),
                (quantityWeekendDay != 0)
                    ? Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${FormatProvider().formatPrice(weekendPrice.toString())} đ',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ), //giá cuối tuần
                          const Expanded(flex: 1, child: Text('x')),
                          Expanded(
                            flex: 4,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: quantityWeekendDay
                                        .toString(), //số ngày cuối tuần
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  const TextSpan(
                                    text: ' ngày cuối tuần',
                                    style: TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${FormatProvider().formatPrice((quantityWeekendDay * weekendPrice).toString())} đ', //tổng giá cuối tuần
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
