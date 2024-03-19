import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/homestay_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class ResultPreview extends StatefulWidget {
  HomestayModel homestayModel;
  ResultPreview({
    Key? key,
    required this.homestayModel,
  }) : super(key: key);

  @override
  State<ResultPreview> createState() => _ResultState();
}

class _ResultState extends State<ResultPreview> {
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
        MaterialPageRoute(builder: (context) => const HomeStayDetail()),
      ),
      child: Container(
        height: 310,
        width: screenSize.width * 0.9,
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
              width: screenSize.width * 0.9,
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
              padding: const EdgeInsets.only(left: 12, top: 8, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${homestayModel.acreage}m\u00b2',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        // '${homestayModel.services?.first.serviceName}',
                        (homestayModel.totalCapacity != null)
                            ? '${homestayModel.totalCapacity} người'
                            : '',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 14,
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
                        fontSize: 22,
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
                        size: 22,
                        color: AppColors.primaryColor3,
                      ),
                      Text(
                        '${homestayModel.city}',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 15,
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
