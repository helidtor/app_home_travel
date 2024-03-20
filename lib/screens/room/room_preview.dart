import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/homestay_detail.dart';
import 'package:mobile_home_travel/screens/room/room_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomPreview extends StatefulWidget {
  RoomModel roomModel;
  RoomPreview({
    Key? key,
    required this.roomModel,
  }) : super(key: key);

  @override
  State<RoomPreview> createState() => _RoomPreviewState();
}

class _RoomPreviewState extends State<RoomPreview> {
  RoomModel roomModel = RoomModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomModel = widget.roomModel;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("idRoom", roomModel.id!);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const roomDetail()),
        );
      },
      child: Container(
        // height: 315,
        width: 260,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(253, 255, 255, 255),
            ),
            color: const Color.fromARGB(253, 255, 255, 255),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 260,
              height: 120,
              decoration: BoxDecoration(
                color: const Color.fromARGB(253, 255, 255, 255),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (roomModel.images!.isEmpty)
                      ? const AssetImage("assets/images/homestay_default.jpg")
                      : Image.network(roomModel.images!.first.url!).image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${FormatProvider().formatNumber((roomModel.acreage != null) ? roomModel.acreage.toString() : '0')}m\u00b2',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            (roomModel.numberOfBeds != null)
                                ? '${roomModel.numberOfBeds} giường'
                                : '',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.bed_outlined,
                            size: 18,
                            color: AppColors.primaryColor3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${roomModel.name}',
                    style: TextStyle(
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.payments_outlined,
                          size: 18,
                          color: AppColors.primaryColor3,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${FormatProvider().formatPrice((roomModel.price != null) ? roomModel.price.toString() : '0')}đ',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
