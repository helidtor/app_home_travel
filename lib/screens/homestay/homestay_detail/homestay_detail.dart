// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/homestay_detail_model.dart';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<HomestayDetailModel?> getHomestayDetail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idHomestay = prefs.getString("idHomestay");
  var homestayDetail =
      await ApiHomestay.getDetailHomestay(idHomestay: idHomestay!);
  print('Id homestay từ prefs là: $idHomestay');
  return homestayDetail;
}

class HomeStayDetail extends StatefulWidget {
  const HomeStayDetail({super.key});

  @override
  State<HomeStayDetail> createState() => _HomeStayDetailState();
}

class _HomeStayDetailState extends State<HomeStayDetail> {
  final controller = PageController(viewportFraction: 1);
  HomestayDetailModel? homestayDetail;
  List<String> listImagesHomestay = [];
  @override
  void initState() {
    super.initState();
    _loadHomestayDetail();
  }

  Future<void> _loadHomestayDetail() async {
    final homestay = await getHomestayDetail();
    if (mounted) {
      setState(() {
        homestayDetail = homestay!;
        if (homestayDetail!.images!.isNotEmpty) {
          listImagesHomestay =
              homestayDetail!.images!.map((e) => e.url as String).toList();
          print('List sau khi trích xuất: $listImagesHomestay');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        // centerTitle: true,
        title: Text(
          "Chi Tiết Homestay",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(182, 0, 0, 0),
              fontSize: 20,
              fontFamily: GoogleFonts.nunito().fontFamily),
        ),
        backgroundColor: Colors.white,
      ),
      body: (homestayDetail != null)
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ảnh homestay
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 280,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor3.withOpacity(0.3),
                              spreadRadius: 0.1,
                              blurRadius: 6,
                              // offset: const Offset(0, 3),
                            ),
                          ],
                          //ảnh mặc định khi homestay không có ảnh
                          color: const Color.fromARGB(253, 255, 255, 255),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: (homestayDetail!.images!.isEmpty)
                                ? const AssetImage(
                                    "assets/images/homestay_default.jpg")
                                : Image.network(
                                        homestayDetail!.images!.first.url!)
                                    .image,
                          ),
                        ),
                        //carouse image homestay
                        child: PageView.builder(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: (listImagesHomestay.isEmpty)
                                ? 0
                                : listImagesHomestay.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                listImagesHomestay[index],
                                fit: BoxFit.cover,
                              );
                            }),
                      ),
                      SmoothPageIndicator(
                        controller: controller,
                        count: (listImagesHomestay.isEmpty)
                            ? 1
                            : listImagesHomestay.length,
                        effect: ScaleEffect(
                          scale: 1.4,
                          dotColor: Colors.white.withOpacity(0.4),
                          activeDotColor:
                              const Color.fromARGB(235, 255, 255, 255),
                          dotHeight: 2,
                          dotWidth: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   '${homestayDetail.acreage}m\u00b2',
                        //   style: TextStyle(
                        //       fontFamily: GoogleFonts.nunito().fontFamily,
                        //       fontSize: 14,
                        //       color: const Color.fromARGB(208, 0, 0, 0)),
                        // ),
                        Text(
                          '${homestayDetail!.name}',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 25,
                                color: AppColors.primaryColor3,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  textAlign: TextAlign.left,
                                  (homestayDetail?.commune != null &&
                                          homestayDetail?.district != null)
                                      ? '${homestayDetail!.commune}, ${homestayDetail!.district}'
                                      : 'Đang cập nhật',
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'chỉ từ ',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 17, // Kích thước chữ mặc định
                                  color: Colors.black, // Màu chữ mặc định
                                ),
                              ),
                              TextSpan(
                                text: '300k/ngày',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 18, // Kích thước chữ in đậm
                                  fontWeight: FontWeight.bold, // Chữ in đậm
                                  color: Colors.black, // Màu chữ
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 25,
                    color: AppColors.backgroundApp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiện ích chung',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ///////////////////////////////////////////// cắt từ đoạn này
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.wind_power,
                                          size: 25,
                                          color: AppColors.primaryColor3,
                                        ),
                                        Text(
                                          'Máy lạnh',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.wifi,
                                          size: 25,
                                          color: AppColors.primaryColor3,
                                        ),
                                        Text(
                                          'Wifi',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.local_parking_sharp,
                                          size: 25,
                                          color: AppColors.primaryColor3,
                                        ),
                                        Text(
                                          'Bãi đỗ xe',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ]),
                              const SizedBox(
                                width: 100,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.chalet_sharp,
                                          size: 25,
                                          color: AppColors.primaryColor3,
                                        ),
                                        // Text(
                                        //   '${homestayDetail.acreage}m\u00b2',
                                        //   style: TextStyle(
                                        //       fontFamily:
                                        //           GoogleFonts.nunito().fontFamily,
                                        //       fontSize: 16,
                                        //       color: Colors.black),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.shower,
                                          size: 25,
                                          color: AppColors.primaryColor3,
                                        ),
                                        Text(
                                          'Bồn tắm',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.electrical_services_rounded,
                                          size: 25,
                                          color: AppColors.primaryColor3,
                                        ),
                                        Text(
                                          'Dịch vụ khác',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                        /////////////////////////////////////////////
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 25,
                    color: AppColors.backgroundApp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mô tả',
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${homestayDetail!.description}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  const Divider(
                    thickness: 25,
                    color: AppColors.backgroundApp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'chỉ từ ',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 18, // Kích thước chữ mặc định
                                  color: Colors.black, // Màu chữ mặc định
                                ),
                              ),
                              TextSpan(
                                text: '300k/ngày',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 20, // Kích thước chữ in đậm
                                  fontWeight: FontWeight.bold, // Chữ in đậm
                                  color: Colors.black, // Màu chữ
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        RoundGradientButton(
                          title: 'Đặt phòng ngay',
                          width: 130,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  "assets/gifs/loading.gif",
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
