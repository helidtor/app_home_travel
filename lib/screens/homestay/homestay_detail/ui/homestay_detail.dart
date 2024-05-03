// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/firebase/firebase_chat_provider.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/utils/row_text.dart';
import 'package:mobile_home_travel/screens/chat/ui/chat_detail/chat_detail_screen.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/ui/feedback_homestay_screen.dart';
import 'package:mobile_home_travel/screens/wishlist/ui/wishlist_screen.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:mobile_home_travel/models/homestay/general_homestay/general_amenitie_selecteds_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_general_amenitie_titles_model.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_date/pick_date.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/bloc/homestay_detail_bloc.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/bloc/homestay_detail_event.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/bloc/homestay_detail_state.dart';
import 'package:mobile_home_travel/screens/room/room_preview.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class HomeStayDetail extends StatefulWidget {
  bool isFromHome;
  HomeStayDetail({
    super.key,
    required this.isFromHome,
  });

  @override
  State<HomeStayDetail> createState() => _HomeStayDetailState();
}

class _HomeStayDetailState extends State<HomeStayDetail> {
  String? imageDisplay;
  late bool isFromHome;
  final _bloc = HomestayDetailBloc();
  bool? isWishlist;
  final controller = PageController(viewportFraction: 1); //carouse
  HomestayDetailModel? homestayDetail;
  List<String> listImagesHomestay = [];
  List<HomeStayGeneralAmenitieTitlesModel> listHomestayGeneralAmenitieTitle =
      [];
  List<GeneralAmenitieSelectedsModel> listGeneralAmenitieSelecteds = [];
  final List<Widget> emptyWidgetList = [];
  double heightDynamic = 0;
  String? idUserCurrent;

  @override
  void initState() {
    super.initState();
    isFromHome = widget.isFromHome;
    idUserCurrent = SharedPreferencesUtil.getIdUserCurrent();
    _bloc.add(GetInforDisplay());
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
            isFromHome
                ? Navigator.pop(context)
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WishlistScreen()),
                  );
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        // centerTitle: true,
        title: const Text(
          "Chi Tiết Homestay",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(182, 0, 0, 0),
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<HomestayDetailBloc, HomestayDetailState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is HomestayDetailLoading) {
            onLoading(context);
            return;
          } else if (state is GetDisplaySuccess) {
            Navigator.pop(context);
            homestayDetail = state.homestayDetailModel;
            isWishlist = state.iswishlist;
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
          } else if (state is WishlistSuccessState) {
            Navigator.pop(context);
          } else if (state is GetDisplayFailure) {
            Navigator.pop(context);
            ErrorNotiProvider().showError(context, state.error);
            imageDisplay = 'assets/images/error_loading.png';
          }
        },
        builder: (context, state) {
          return (homestayDetail != null)
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
                                  color:
                                      AppColors.primaryColor3.withOpacity(0.3),
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
                            left: 20, right: 10, top: 5, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   '${homestayDetail.acreage}m\u00b2',
                            //   style: TextStyle(
                            //
                            //       fontSize: 14,
                            //       color: const Color.fromARGB(208, 0, 0, 0)),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    (homestayDetail!.name != null)
                                        ? '${homestayDetail!.name}'
                                        : 'Đang đợi cập nhật',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily:
                                            GoogleFonts.tiltNeon().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isWishlist = !isWishlist!;
                                        print(
                                            'Trạng thái wishlist hiện tại: $isWishlist');
                                        _bloc.add(WishlistHomestay(
                                            isWishlist: isWishlist!));
                                      });
                                    },
                                    icon: isWishlist!
                                        ? const Icon(
                                            FontAwesomeIcons.solidHeart,
                                            size: 23,
                                            color: AppColors.primaryColor5,
                                          )
                                        : const Icon(
                                            FontAwesomeIcons.heart,
                                            size: 23,
                                            color: AppColors.primaryColor3,
                                          ))
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
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
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
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
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(0.35),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: (homestayDetail!.totalCapacity !=
                                            null)
                                        ? 'Sức chứa: ${homestayDetail!.totalCapacity}'
                                        : 'Sức chứa: 0',
                                    style: TextStyle(
                                      fontSize: 13,
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
                              const Text(
                                'Mô Tả',
                                style: TextStyle(
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
                                    fontFamily: GoogleFonts.inter().fontFamily,
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
                            //
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black),
                            // ),
                            //GridView general amenitie homestay
                            Container(
                              width: screenWidth,
                              height: 60.0 +
                                  listHomestayGeneralAmenitieTitle.length *
                                      20.0,
                              margin: const EdgeInsets.only(top: 10),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount:
                                    listHomestayGeneralAmenitieTitle.length,
                                itemBuilder: (context, index) {
                                  //element in list general amenitie
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (listHomestayGeneralAmenitieTitle[
                                                          index]
                                                      .generalAmenitieTitle
                                                      ?.name !=
                                                  null)
                                              ? listHomestayGeneralAmenitieTitle[
                                                      index]
                                                  .generalAmenitieTitle!
                                                  .name!
                                              : 'Tiêu đề trống',
                                          style: const TextStyle(
                                            fontSize: 13,
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
                                            children: (getNameGeneralAmenitieSelecteds(
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
                      (homestayDetail?.rating != 0 &&
                              homestayDetail?.rating != null)
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 25, bottom: 25),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Đánh giá',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${homestayDetail!.rating!.toStringAsFixed(1)}/5.0',
                                              style: const TextStyle(
                                                  fontSize: 35,
                                                  color:
                                                      AppColors.primaryColor3),
                                            ),
                                            AnimatedRatingBar(
                                              activeFillColor:
                                                  AppColors.primaryColor3,
                                              strokeColor:
                                                  AppColors.primaryColor3,
                                              initialRating: double.parse(
                                                  homestayDetail!.rating!
                                                      .floor()
                                                      .toString()),
                                              height: 45,
                                              width: 200,
                                              animationColor: Colors.red,
                                              onRatingUpdate: (rating) {
                                                debugPrint(rating.toString());
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FeedbackHomestayScreen(
                                                  isCreateFeedback: false,
                                                  homestayDetailModel:
                                                      homestayDetail!,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                      AppColors.primaryColor3,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Text(
                                                'Xem chi tiết',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors.primaryColor3,
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
                              ],
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 25, bottom: 25),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Danh Sách Phòng',
                                style: TextStyle(
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
                                        child: homestayDetail!
                                                    .rooms![index].status ==
                                                'ACTIVE'
                                            ? RoomPreview(
                                                roomModel: homestayDetail!
                                                    .rooms![index])
                                            : const SizedBox(),
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
                            left: 20, right: 20, top: 20, bottom: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Thời gian nhận & trả phòng',
                              style: TextStyle(
                                  fontSize: 15,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'NHẬN PHÒNG',
                                          style: TextStyle(
                                              color: AppColors.primaryColor3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                            'từ ${FormatProvider().convertTo24HourFormat(homestayDetail!.checkInTime.toString())}'),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'TRẢ PHÒNG',
                                        style: TextStyle(
                                            color: AppColors.primaryColor3,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                          'lúc ${FormatProvider().convertTo24HourFormat(homestayDetail!.checkOutTime.toString())}'),
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
                            const Text(
                              'Chính Sách',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text((homestayDetail!.depositRate != 0 &&
                                    homestayDetail!.depositRate != null)
                                ? '✅ Cọc trước chỉ với ${homestayDetail!.depositRate}% tổng hóa đơn'
                                : '✅ Đặt trước hoàn toàn miễn phí'),
                            Text((homestayDetail!.penaltyDate != null &&
                                    homestayDetail!.penaltyDate != 0)
                                ? '✅ Hủy đơn miễn phí trước ${homestayDetail!.penaltyDate} ngày nhận phòng'
                                : '✅ Hủy đơn miễn phí bất cứ lúc nào'),
                          ],
                        ),
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
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'bạn ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Thích Chứ',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PickDate(
                                            checkinTime:
                                                homestayDetail!.checkInTime!,
                                          )),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: (imageDisplay != null)
                      ? SizedBox(
                          width: 350,
                          height: 350,
                          child: Image.asset(
                            imageDisplay!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.2),
        child: FloatingActionButton(
          isExtended: true,
          onPressed: () async {
            var ownerProfile =
                await ApiUser.getOwner(idOwner: homestayDetail!.ownerId!);
            var userProfile = await ApiUser.getProfile();
            if (ownerProfile != null && userProfile != null) {
              UserChatModel owner =
                  UserChatModel.fromJson(ownerProfile.toMap());
              owner.phoneNumber = "";
              owner.lastTimeChat = Timestamp.now();
              FirebaseChatProvider().createUserChat(userProfile, ownerProfile);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDetailScreen(owner: owner)),
              );
            }
          },
          backgroundColor:
              AppColors.primaryColor3.withOpacity(0.5), // Icon của nút
          elevation: 10,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.chat,
            size: 28,
            color: Colors.white,
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
        // print(
        //     "Kết quả listGeneralAmenitieSelecteds: $listGeneralAmenitieSelecteds");
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
