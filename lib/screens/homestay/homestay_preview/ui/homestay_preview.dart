import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/format/format.dart';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/ui/homestay_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomestayPreview extends StatefulWidget {
  HomestayModel homestayModel;
  HomestayPreview({
    Key? key,
    required this.homestayModel,
  }) : super(key: key);

  @override
  State<HomestayPreview> createState() => _HomestayState();
}

class _HomestayState extends State<HomestayPreview> {
  HomestayModel homestayModel = HomestayModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homestayModel = widget.homestayModel;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("idHomestay", homestayModel.id!);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeStayDetail()),
        );
      },
      child: Container(
        height: 280,
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
              height: 180,
              decoration: BoxDecoration(
                color: const Color.fromARGB(253, 255, 255, 255),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: (homestayModel.images!.isEmpty)
                      ? const AssetImage("assets/images/homestay_default.jpg")
                      : Image.network(homestayModel.images!.first.url!).image,
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
                        '${FormatProvider().formatNumber((homestayModel.acreage != null) ? homestayModel.acreage.toString() : '0')}m\u00b2',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        // '${homestayModel.services?.first.serviceName}',
                        (homestayModel.totalCapacity != null)
                            ? '${homestayModel.totalCapacity} người'
                            : '',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 25,
                    child: Text(
                      (homestayModel.name != null)
                          ? '${homestayModel.name}'
                          : 'Đợi cập nhật nha bé ơi bé à bé ăn trứng gà',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: AppColors.primaryColor3,
                      ),
                      Text(
                        (homestayModel.city != null)
                            ? '${homestayModel.city}'
                            : 'Đang đợi cập nhật',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 13,
                            color: Colors.black),
                      ),
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
}
