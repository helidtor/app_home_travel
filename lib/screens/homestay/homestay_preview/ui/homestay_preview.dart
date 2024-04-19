import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/ui/homestay_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomestayPreview extends StatefulWidget {
  HomestayModel homestayModel;
  HomestayPreview({
    super.key,
    required this.homestayModel,
  });

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
          MaterialPageRoute(
            builder: (context) => HomeStayDetail(
              isFromHome: true,
            ),
          ),
        );
      },
      child: Container(
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
              height: 160,
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
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        // '${homestayModel.services?.first.serviceName}',
                        (homestayModel.totalCapacity != null)
                            ? '${homestayModel.totalCapacity} người'
                            : '',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
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
                          fontSize: 18,
                          fontFamily: GoogleFonts.tiltNeon().fontFamily,
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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      (homestayModel.rating != null &&
                              homestayModel.rating != 0)
                          ? const Icon(
                              Icons.star,
                              size: 18,
                              color: AppColors.primaryColor3,
                            )
                          : const SizedBox(),
                      (homestayModel.rating != null &&
                              homestayModel.rating != 0)
                          ? Text(
                              '${homestayModel.rating!.toStringAsFixed(1)}/5',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                'Chưa có đánh giá',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
