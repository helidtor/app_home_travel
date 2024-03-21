// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/general_amenitie_selecteds_model.dart';
import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/homestay_general_amenitie_titles_model.dart';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/homestay_preview.dart';
import 'package:mobile_home_travel/screens/room/room_preview.dart';
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
  List<HomeStayGeneralAmenitieTitlesModel> listHomestayGeneralAmenitieTitle =
      [];
  List<GeneralAmenitieSelectedsModel> listGeneralAmenitieSelecteds = [];
  final List<Widget> emptyWidgetList = [];
  double heightDynamic = 0;

  @override
  void initState() {
    super.initState();
    _loadHomestayDetail();
  }

  Future<void> _loadHomestayDetail() async {
    final homestay = await getHomestayDetail();
    if (mounted) {
      setState(() {
        //get list images homestay
        homestayDetail = homestay!;
        if (homestayDetail!.images!.isNotEmpty) {
          listImagesHomestay =
              homestayDetail!.images!.map((e) => e.url as String).toList();
          // print('List image sau khi trích xuất: $listImagesHomestay');
        }
        //get list homestay general amenitie
        if (homestayDetail!.homeStayGeneralAmenitieTitles!.isNotEmpty) {
          listHomestayGeneralAmenitieTitle =
              homestayDetail!.homeStayGeneralAmenitieTitles!.toList();
          // print('List tiêu đề tiện ích sau khi trích xuất: $listImagesHomestay');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
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
                          scale: 2,
                          dotColor: Colors.white.withOpacity(0.4),
                          activeDotColor:
                              const Color.fromARGB(235, 255, 255, 255),
                          dotHeight: 2,
                          dotWidth: 7.5,
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
                          (homestayDetail!.name != null)
                              ? '${homestayDetail!.name}'
                              : 'Đang đợi cập nhật',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 22,
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
                                text: (homestayDetail!.rooms!.isNotEmpty)
                                    ? 'Số phòng: ${homestayDetail!.rooms!.length} - '
                                    : 'Số phòng: 0 - ',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 15,
                                  color: Colors.black,
                                  // fontStyle: FontStyle.italic,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: (homestayDetail!.totalCapacity != null)
                                    ? 'Sức chứa: ${homestayDetail!.totalCapacity}'
                                    : 'Sức chứa: 0',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.35),
                                  fontWeight: FontWeight.bold,
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
                            'Mô tả',
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            (homestayDetail!.description != null)
                                ? '${homestayDetail!.description}'
                                : 'Đợi cập nhật',
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 14,
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
                        left: 20, right: 20, top: 10, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Tiện ích chung',
                        //   style: TextStyle(
                        //       fontFamily: GoogleFonts.nunito().fontFamily,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black),
                        // ),
                        //GridView general amenitie homestay
                        Container(
                          width: screenWidth,
                          height: 60.0 +
                              listHomestayGeneralAmenitieTitle.length * 20.0,
                          margin: const EdgeInsets.only(top: 10),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: listHomestayGeneralAmenitieTitle.length,
                            itemBuilder: (context, index) {
                              //element in list general amenitie
                              return Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (listHomestayGeneralAmenitieTitle[index]
                                                  .generalAmenitieTitle
                                                  ?.name !=
                                              null)
                                          ? listHomestayGeneralAmenitieTitle[
                                                  index]
                                              .generalAmenitieTitle!
                                              .name!
                                          : 'Tiêu đề trống',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        children:
                                            (getNameGeneralAmenitieSelecteds(
                                                        index) !=
                                                    null)
                                                ? getWidgetDetailAmenitieTitles(
                                                    listGeneralAmenitieSelecteds)
                                                : emptyWidgetList,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
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
                            'Danh sách phòng',
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  homestayDetail!.rooms!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: RoomPreview(
                                        roomModel:
                                            homestayDetail!.rooms![index]),
                                  ),
                                ),
                              ),
                            ),
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
                                text: 'nhận ',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'Ưu Đãi Hot',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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

  //lấy list những tiện ích chung của theo tiêu đề
  List<GeneralAmenitieSelectedsModel>? getNameGeneralAmenitieSelecteds(
      int index) {
    List<GeneralAmenitieSelectedsModel> list = [];
    if (listHomestayGeneralAmenitieTitle.isNotEmpty) {
      if (listHomestayGeneralAmenitieTitle[index]
          .generalAmenitieSelecteds!
          .isNotEmpty) {
        list = listHomestayGeneralAmenitieTitle[index]
            .generalAmenitieSelecteds!
            .map((e) => e)
            .toList();
        listGeneralAmenitieSelecteds = list;
        print(
            "Kết quả listGeneralAmenitieSelecteds: $listGeneralAmenitieSelecteds");
        return listGeneralAmenitieSelecteds;
      } else {
        return null;
      }
    }
    return null;
  }

  //trả về widget dựa theo list của hàm getNameGeneralAmenitieSelecteds()
  List<Widget> getWidgetDetailAmenitieTitles(
      List<GeneralAmenitieSelectedsModel> listGeneralAmenitieSelecteds) {
    List<Widget> listWidget = [];

    for (int i = 0; i < listGeneralAmenitieSelecteds.length; i++) {
      listWidget.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.done_outline_sharp,
              color: AppColors.primaryColor3,
              size: 11,
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
              child: Text(
                (listGeneralAmenitieSelecteds[i].generalAmenitie!.name!),
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return listWidget;
  }
}
