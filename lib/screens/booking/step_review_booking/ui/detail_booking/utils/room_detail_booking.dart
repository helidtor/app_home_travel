// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile_home_travel/models/booking/booking_detail_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/row_text.dart';
import 'package:mobile_home_travel/screens/room/room_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';

class RoomDetailBooking extends StatefulWidget {
  BookingDetailModel bookingDetailModel;
  List<BookingDetailModel> detailPriceRoom;
  RoomDetailBooking({
    super.key,
    required this.bookingDetailModel,
    required this.detailPriceRoom,
  });

  @override
  State<RoomDetailBooking> createState() => _RoomDetailBookingState();
}

class _RoomDetailBookingState extends State<RoomDetailBooking> {
  late BookingDetailModel bookingDetailModel;
  late List<BookingDetailModel> detailPriceRoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingDetailModel = widget.bookingDetailModel;
    detailPriceRoom = widget.detailPriceRoom;
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
                    '${(FormatProvider().formatPrice(detailPriceRoom.first.totalPrice.toString()))} đ',
                icon: Icons.monetization_on_outlined,
              ),
              const SizedBox(
                height: 3,
              ),
            ],
          ),
          children: [],
        ),
      ),
    );
  }
}
