// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/booking/price_room_model.dart';
import 'package:mobile_home_travel/models/homestay/policy/homestay_policy_selected_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/bloc/review_booking_bloc.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/bloc/review_booking_event.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/bloc/review_booking_state.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/detail_booking/detail_booking_screen.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/utils/checkout_booking.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking/utils/policy_dialog.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class ReviewBooking extends StatefulWidget {
  bool isAllowBack;
  bool isFromCreatePendingBooking;
  String startDate;
  String endDate;
  List<String> listIdRoom;
  UserProfileModel? userProfileModel;
  BookingHomestayModel? bookingHomestayModel;
  ReviewBooking({
    super.key,
    required this.isAllowBack,
    required this.isFromCreatePendingBooking,
    required this.startDate,
    required this.endDate,
    required this.listIdRoom,
    this.userProfileModel,
    this.bookingHomestayModel,
  });

  @override
  State<ReviewBooking> createState() => _ReviewBookingState();
}

class _ReviewBookingState extends State<ReviewBooking> {
  bool isAllowBack = false;
  bool isFromCreatePendingBooking = false;
  String? imageDisplay;
  bool isCheck = false;
  bool isDisplay = false;
  final _bloc = ReviewBookingBloc();
  BookingHomestayModel? bookingInfor;
  UserProfileModel? touristInfor;
  double widthDisplay = 270;
  double heightDisplay = 270;
  List<HomestayPolicySelectedModel> listPolicies = [];
  List<PriceRoomModel> listResultPrice = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFromCreatePendingBooking = widget.isFromCreatePendingBooking;
    if (isFromCreatePendingBooking) {
      //khi xem đơn pending lúc vừa tạo đơn xong
      setState(() {
        isAllowBack = false;
      });
      bookingInfor = widget.bookingHomestayModel;
      touristInfor = widget.userProfileModel;
      if (bookingInfor != null) {
        _bloc.add(
          GetPolicyHomestayFromPending(
            bookingInfor!.bookingDetails![0].room!.homeStayId!,
            widget.startDate,
            widget.endDate,
            widget.listIdRoom,
          ),
        );
      }
    } else {
      //khi xem đơn pending từ history
      isAllowBack = widget.isAllowBack;
      if (!isAllowBack) {
        _bloc.add(
          GetBookingPendingCreated(
            widget.startDate,
            widget.endDate,
            widget.listIdRoom,
          ),
        );
      } else {
        bookingInfor = widget.bookingHomestayModel;
        touristInfor = widget.userProfileModel;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading:
            isFromCreatePendingBooking ? true : isAllowBack,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        title: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            isAllowBack ? "Tổng quan đơn" : "Hoàn tất đơn",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.65),
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          (isFromCreatePendingBooking == true)
              ? const SizedBox()
              : (isAllowBack == false)
                  ? IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        _showAlertDialog(context);
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.primaryColor3.withOpacity(0.7),
                        size: 27,
                      ),
                    )
                  : const SizedBox(),
        ],
      ),
      body: BlocConsumer<ReviewBookingBloc, ReviewBookingState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is ReviewBookingLoading) {
            // setState(() {
            //   widthDisplay = 50;
            //   heightDisplay = 50;
            //   imageDisplay = 'assets/gifs/loading.gif';
            // });
            onLoading(context);
            return;
          } else if (state is GetBookingPendingCreatedSuccess) {
            Navigator.pop(context);
            bookingInfor = state.bookingCreated;
            listResultPrice = state.listResultPrice;
            touristInfor = state.userProfile;
          } else if (state is GetBookingPendingCreatedSuccessWithPolicy) {
            Navigator.pop(context);
            bookingInfor = state.bookingCreated;
            listResultPrice = state.listResultPrice;
            touristInfor = state.userProfile;
            listPolicies = state.listPolicies;
          } else if (state is ReviewBookingFailure) {
            Navigator.pop(context);
            ErrorNotiProvider().showError(context, state.error);
            setState(() {
              widthDisplay = 270;
              heightDisplay = 270;
              imageDisplay = 'assets/images/error_loading.png';
            });
          } else if (state is GetPolicySuccessFromPending) {
            Navigator.pop(context);
            listPolicies = state.listPolicies;
            listResultPrice = state.listResultPrice;
          } else if (state is GetPolicyFailFromPending) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return (bookingInfor != null && touristInfor != null)
              ? SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primaryColor1.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 9,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        // ảnh
                                        width: 150,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primaryColor1
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.1,
                                              blurRadius: 9,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                          color: const Color.fromARGB(
                                              253, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: (bookingInfor!
                                                    .bookingDetails![0]
                                                    .room!
                                                    .homeStay!
                                                    .images!
                                                    .isEmpty)
                                                ? const AssetImage(
                                                    "assets/images/homestay_default.jpg")
                                                : Image.network(bookingInfor!
                                                        .bookingDetails![0]
                                                        .room!
                                                        .homeStay!
                                                        .images!
                                                        .first
                                                        .url!)
                                                    .image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bookingInfor!.bookingDetails![0]
                                                  .room!.homeStay!.name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // color: AppColors.primaryColor3
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: AppColors.primaryColor3
                                                      .withOpacity(0.7),
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  (bookingInfor!.checkInDate !=
                                                          bookingInfor!
                                                              .checkOutDate)
                                                      ? '${FormatProvider().convertDateTimeBooking(bookingInfor!.checkInDate.toString())} - ${FormatProvider().convertDateTimeBooking(bookingInfor!.checkOutDate.toString())}'
                                                      : '${FormatProvider().convertDateTimeBooking(bookingInfor!.checkInDate.toString())} (1 ngày)',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: AppColors.primaryColor3
                                                      .withOpacity(0.7),
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    bookingInfor!
                                                        .bookingDetails![0]
                                                        .room!
                                                        .homeStay!
                                                        .city!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.door_back_door_outlined,
                                                  color: AppColors.primaryColor3
                                                      .withOpacity(0.7),
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  '${bookingInfor!.bookingDetails!.length} phòng',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //Đường kẻ
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: screenWidth * 0.75,
                                  child: const Divider(
                                    thickness: 0.3,
                                    color: AppColors.primaryColor3,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 17),
                                      child: Text(
                                        'Tổng cộng',
                                        style: TextStyle(
                                          fontSize: 20,
                                          // color: AppColors.primaryColor3.withOpacity(0.8),
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 17),
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: AppColors.blackColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "${FormatProvider().formatPrice(bookingInfor!.totalPrice.toString())} VNĐ\n",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text:
                                                      "đã bao gồm thuế,\ntiện ích chung",
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.grey
                                                          .withOpacity(0.7),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailBooking(
                                                listResultPrice:
                                                    listResultPrice,
                                                bookingInfor: bookingInfor!,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 25,
                                    width: screenWidth * 0.8,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            width: 0.8),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Xem chi tiết',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primaryColor1.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 9,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Thông tin cá nhân',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.person_outline,
                                      color: AppColors.primaryColor3
                                          .withOpacity(0.7),
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '${touristInfor!.lastName} ${touristInfor!.firstName}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: AppColors.primaryColor3
                                          .withOpacity(0.7),
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      touristInfor!.phoneNumber!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        isFromCreatePendingBooking
                            ? Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      activeColor: AppColors.primaryColor3,
                                      shape: const RoundedRectangleBorder(),
                                      value: isCheck,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isCheck = newValue!;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Chính sách là: $listPolicies');
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return PolicyDialog(
                                              listPolicies: listPolicies,
                                            ); // Hiển thị hộp thoại
                                          },
                                        );
                                      },
                                      child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Tiếp tục đồng nghĩa chấp nhận ',
                                              style: TextStyle(
                                                color: AppColors.grayColor,
                                                fontSize: 13.5,
                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                    'Chính sách và\nĐiều khoản của Homestay',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 87, 81, 82),
                                                  fontSize: 13,
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : !isAllowBack
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          activeColor: AppColors.primaryColor3,
                                          shape: const RoundedRectangleBorder(),
                                          value: isCheck,
                                          onChanged: (newValue) {
                                            setState(() {
                                              isCheck = newValue!;
                                            });
                                          },
                                        ),
                                        // const Expanded(
                                        //   child: Text(
                                        //       "Tiếp tục đồng nghĩa chấp nhận Chính sách và\nĐiều khoản của Homestay",
                                        //       style: TextStyle(
                                        //         color: AppColors.grayColor,
                                        //         fontSize: 12,
                                        //       )),
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            print(
                                                'Chính sách là: $listPolicies');
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return PolicyDialog(
                                                  listPolicies: listPolicies,
                                                ); // Hiển thị hộp thoại
                                              },
                                            );
                                          },
                                          child: RichText(
                                            overflow: TextOverflow.clip,
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Tiếp tục đồng nghĩa chấp nhận ',
                                                  style: TextStyle(
                                                    color: AppColors.grayColor,
                                                    fontSize: 13.5,
                                                  ),
                                                ),
                                                TextSpan(
                                                    text:
                                                        'Chính sách và\nĐiều khoản của Homestay',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 87, 81, 82),
                                                      fontSize: 13,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                        // const SizedBox(
                        //   height: 100,
                        // ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: (imageDisplay != null)
                      ? SizedBox(
                          width: widthDisplay,
                          height: heightDisplay,
                          child: Image.asset(
                            imageDisplay!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (isFromCreatePendingBooking == true)
          ? RoundGradientButton(
              circular: 10,
              width: screenWidth * 0.85,
              title: 'Xác nhận',
              onPressed: () {
                isCheck
                    ?
                    // _bloc.add(CheckoutBookingByCard(idBooking: booking.id!));
                    //hiện khung nhập giá
                    showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return CheckoutBooking(
                            bookingHomestayModel: bookingInfor!,
                            balance: touristInfor!.wallets!.first.balance!,
                          );
                        },
                      )
                    : ErrorNotiProvider()
                        .showError(context, 'Bạn chưa chấp nhận chính sách!');
              },
              textSize: 18,
            )
          : !isAllowBack //nếu không phải mở từ lịch sử đơn pending
              ? RoundGradientButton(
                  circular: 10,
                  width: screenWidth * 0.85,
                  title: 'Xác nhận',
                  onPressed: () {
                    isCheck
                        ?
                        // _bloc.add(CheckoutBookingByCard(idBooking: booking.id!));
                        //hiện khung nhập giá
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return CheckoutBooking(
                                bookingHomestayModel: bookingInfor!,
                                balance: touristInfor!.wallets!.first.balance!,
                              );
                            },
                          )
                        : ErrorNotiProvider().showError(
                            context, 'Bạn chưa chấp nhận chính sách!');
                  },
                  textSize: 18,
                )
              : const SizedBox(),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text(
              'Lưu ý',
              style: TextStyle(
                color: AppColors.primaryColor3,
                fontSize: 20,
              ),
            ),
            content: const Text(
              'Bạn có muốn lưu lại đơn đặt phòng\nđể thanh toán sau không?',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                  child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Có',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor3,
                    fontSize: 17,
                  ),
                ),
              )),
              //hủy đơn booking
              CupertinoDialogAction(
                  child: TextButton(
                onPressed: () async {
                  bookingInfor!.status = 'EXPIRED';
                  var checkUpdateBooking = await ApiBooking.updateBooking(
                      bookingInput: bookingInfor!);
                  print(checkUpdateBooking);
                  if (checkUpdateBooking) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Không',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor3,
                    fontSize: 17,
                  ),
                ),
              )),
            ],
          );
        });
  }
}
