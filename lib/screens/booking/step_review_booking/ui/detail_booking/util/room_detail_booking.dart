import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/util/row_text.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class RoomDetailBooking extends StatefulWidget {
  const RoomDetailBooking({super.key});

  @override
  State<RoomDetailBooking> createState() => _RoomDetailBookingState();
}

class _RoomDetailBookingState extends State<RoomDetailBooking> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20),
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
                const Text(
                  'Phòng Vui Vẻ',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.primaryColor3.withOpacity(0.7),
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Column(
            children: [
              RowText().richText('Số giường', '2', Icons.bed_outlined),
              const SizedBox(
                height: 3,
              ),
              RowText().richText('Tổng tiền phòng', '1,000,000₫',
                  Icons.monetization_on_outlined),
              const SizedBox(
                height: 3,
              ),
            ],
          ),
          children: [
            _detailPriceOfRoom(),
          ],
        ),
      ),
    );
  }
}

Widget _detailPriceOfRoom() {
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
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black.withOpacity(0.65)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 2, child: Text('140,000')),
                    const Expanded(flex: 1, child: Text('x')),
                    Expanded(
                      flex: 4,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '2',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' ngày trong tuần',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                        flex: 2,
                        child: Text('280,000',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Expanded(flex: 2, child: Text('140,000')),
                    const Expanded(flex: 1, child: Text('x')),
                    Expanded(
                      flex: 4,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '2',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' ngày trong tuần',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                        flex: 2,
                        child: Text(
                          '280,000',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
