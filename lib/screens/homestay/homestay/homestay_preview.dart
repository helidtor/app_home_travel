// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/homestay_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

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
  late HomestayModel homestayModel;

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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeStayDetail(
                  homestayModel: homestayModel,
                )),
      ),
      child: Container(
        height: 350,
        width: 250,
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
            //image đợi thêm api
            Container(
              width: 250,
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromARGB(253, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  // image: (homestayModel.image!.isEmpty)
                  //     ? const AssetImage("assets/images/homestay_default.jpg")
                  //     : Image.network(homestayModel.image!.first).image,
                  image: AssetImage("assets/images/homestay_default.jpg"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${homestayModel.acreage}m\u00b2',
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
                        '${homestayModel.totalCapacity} người',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${homestayModel.name}',
                    style: TextStyle(
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
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
                        '${homestayModel.city}',
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
