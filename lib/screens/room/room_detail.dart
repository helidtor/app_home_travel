// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/api/api_room.dart';
import 'package:mobile_home_travel/models/homestay/room/room_amenitie_selecteds_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_amenitie_titles_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<RoomModel?> getRoomDetail() async {
  String? idRoom = SharedPreferencesUtil.getIdRoom();
  var roomDetail = await ApiRoom.getRoomDetail(idRoom: idRoom!);
  print('Id room từ prefs là: $idRoom');
  return roomDetail;
}

class roomDetail extends StatefulWidget {
  const roomDetail({super.key});

  @override
  State<roomDetail> createState() => _roomDetailState();
}

class _roomDetailState extends State<roomDetail> {
  final controller = PageController(viewportFraction: 1);
  RoomModel? roomDetail;
  List<String> listImagesHomestay = [];
  List<RoomAmenitieTitlesModel> listRoomAmenitieTitle = [];
  List<RoomAmenitieSelectedsModel> listRoomAmenitieSelecteds = [];
  final List<Widget> emptyWidgetList = [];

  @override
  void initState() {
    super.initState();
    _loadroomDetail();
  }

  Future<void> _loadroomDetail() async {
    var homestay = await getRoomDetail();
    if (mounted) {
      setState(() {
        if (homestay != null) {
          roomDetail = homestay;
          if (roomDetail != null) {
            print('Chi tiết phòng là: $roomDetail');
            if (roomDetail!.roomAmenitieTitles != null) {
              listRoomAmenitieTitle = roomDetail!.roomAmenitieTitles!;
            }
          }
          if (roomDetail!.images!.isNotEmpty) {
            listImagesHomestay =
                roomDetail!.images!.map((e) => e.url as String).toList();
            // print('List sau khi trích xuất: $listImagesHomestay');
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
        title: const Text(
          "Chi Tiết Phòng",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(182, 0, 0, 0),
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: (roomDetail != null)
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
                            image: (roomDetail!.images!.isEmpty)
                                ? const AssetImage(
                                    "assets/images/homestay_default.jpg")
                                : Image.network(roomDetail!.images!.first.url!)
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
                        //   '${roomDetail.acreage}m\u00b2',
                        //   style: TextStyle(
                        //
                        //       fontSize: 14,
                        //       color: const Color.fromARGB(208, 0, 0, 0)),
                        // ),
                        Text(
                          '${roomDetail!.name}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: (roomDetail!.numberOfBeds != null)
                                    ? 'Số giường: ${roomDetail!.numberOfBeds!} - '
                                    : 'Không có giường',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.35),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: (roomDetail!.acreage != null)
                                    ? 'Diện tích: ${(roomDetail!.acreage)!.truncate()}m\u00b2 '
                                    : '',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.35),
                                ),
                              ),
                              TextSpan(
                                text: (roomDetail!.numberOfBeds != null)
                                    ? '- Sức chứa: ${(roomDetail!.numberOfBeds!) * 2} người'
                                    : '',
                                style: TextStyle(
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
                        left: 20, right: 20, top: 20, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Giá niêm yết',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Ngày thường',
                                      style: TextStyle(
                                          color: AppColors.primaryColor3,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        '${FormatProvider().formatPrice(roomDetail!.price.toString())}vnđ 🔥'),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cuối tuần',
                                    style: TextStyle(
                                        color: AppColors.primaryColor3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                      '${FormatProvider().formatPrice(roomDetail!.weekendPrice.toString())}vnđ 🔥'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  // const Divider(
                  //   thickness: 25,
                  //   color: AppColors.backgroundApp,
                  // ),
                  // const Padding(
                  //   padding: EdgeInsets.only(
                  //       left: 20, right: 20, top: 25, bottom: 25),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Tiện ích phòng',
                  //         style: TextStyle(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.black),
                  //       ),
                  //       ///////////////////////////////////////////// cắt từ đoạn này
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(vertical: 20),
                  //         child: Row(
                  //           children: [
                  //             Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.wind_power,
                  //                         size: 25,
                  //                         color: AppColors.primaryColor3,
                  //                       ),
                  //                       Text(
                  //                         'Máy lạnh',
                  //                         style: TextStyle(
                  //                             fontSize: 16,
                  //                             color: Colors.black),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(
                  //                     height: 15,
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.wifi,
                  //                         size: 25,
                  //                         color: AppColors.primaryColor3,
                  //                       ),
                  //                       Text(
                  //                         'Wifi',
                  //                         style: TextStyle(
                  //                             fontSize: 16,
                  //                             color: Colors.black),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(
                  //                     height: 15,
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.local_parking_sharp,
                  //                         size: 25,
                  //                         color: AppColors.primaryColor3,
                  //                       ),
                  //                       Text(
                  //                         'Bãi đỗ xe',
                  //                         style: TextStyle(
                  //                             fontSize: 16,
                  //                             color: Colors.black),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ]),
                  //             SizedBox(
                  //               width: 100,
                  //             ),
                  //             Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.chalet_sharp,
                  //                         size: 25,
                  //                         color: AppColors.primaryColor3,
                  //                       ),
                  //                       // Text(
                  //                       //   '${roomDetail.acreage}m\u00b2',
                  //                       //   style: TextStyle(
                  //                       //       fontSize: 16,
                  //                       //       color: Colors.black),
                  //                       // ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(
                  //                     height: 15,
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.shower,
                  //                         size: 25,
                  //                         color: AppColors.primaryColor3,
                  //                       ),
                  //                       Text(
                  //                         'Bồn tắm',
                  //                         style: TextStyle(
                  //                             fontSize: 16,
                  //                             color: Colors.black),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(
                  //                     height: 15,
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.electrical_services_rounded,
                  //                         size: 25,
                  //                         color: AppColors.primaryColor3,
                  //                       ),
                  //                       Text(
                  //                         'Dịch vụ khác',
                  //                         style: TextStyle(
                  //                             fontSize: 16,
                  //                             color: Colors.black),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ]),
                  //           ],
                  //         ),
                  //       ),
                  //       /////////////////////////////////////////////
                  //     ],
                  //   ),
                  // ),
                  // const Divider(
                  //   thickness: 25,
                  //   color: AppColors.backgroundApp,
                  // ),
                  const Divider(
                    thickness: 25,
                    color: AppColors.backgroundApp,
                  ),
                  listRoomAmenitieTitle.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   'Tiện ích chung',
                              //   style: TextStyle(
                              //
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.black),
                              // ),
                              //GridView general amenitie homestay
                              Container(
                                width: screenWidth,
                                height:
                                    60.0 + listRoomAmenitieTitle.length * 20.0,
                                margin: const EdgeInsets.only(top: 10),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: listRoomAmenitieTitle.length,
                                  itemBuilder: (context, index) {
                                    //element in list general amenitie
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (listRoomAmenitieTitle[index]
                                                        .amenitieTitle
                                                        ?.name !=
                                                    null)
                                                ? listRoomAmenitieTitle[index]
                                                    .amenitieTitle!
                                                    .name!
                                                : 'Tiêu đề trống',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              children: (getNameRoomAmenitieSelecteds(
                                                          index) !=
                                                      null)
                                                  ? getWidgetDetailAmenitieTitles(
                                                      listRoomAmenitieSelecteds)
                                                  : emptyWidgetList,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  const Divider(
                    thickness: 25,
                    color: AppColors.backgroundApp,
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
  List<RoomAmenitieSelectedsModel>? getNameRoomAmenitieSelecteds(int index) {
    List<RoomAmenitieSelectedsModel> list = [];
    if (listRoomAmenitieTitle.isNotEmpty) {
      if (listRoomAmenitieTitle[index].roomAmenitieSelecteds!.isNotEmpty) {
        list = listRoomAmenitieTitle[index]
            .roomAmenitieSelecteds!
            .map((e) => e)
            .toList();
        listRoomAmenitieSelecteds = list;
        // print(
        //     "Kết quả listRoomAmenitieSelecteds: $listRoomAmenitieSelecteds");
        return listRoomAmenitieSelecteds;
      } else {
        return null;
      }
    }
    return null;
  }

  //trả về widget dựa theo list của hàm getNameGeneralAmenitieSelecteds()
  List<Widget> getWidgetDetailAmenitieTitles(
      List<RoomAmenitieSelectedsModel> listRoomAmenitieSelecteds) {
    List<Widget> listWidget = [];

    for (int i = 0; i < listRoomAmenitieSelecteds.length; i++) {
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
                (listRoomAmenitieSelecteds[i].amenitie!.name!),
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
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
