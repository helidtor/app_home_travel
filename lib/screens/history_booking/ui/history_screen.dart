import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_bloc.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_event.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_state.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/list_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  String? imageDisplay;
  final _bloc = HistoryBloc();
  double widthDisplay = 270;
  double heightDisplay = 270;
  List<BookingHomestayModel>? listPendingBooking;
  List<BookingHomestayModel>? listDepositBooking;
  List<BookingHomestayModel>? listPaidBooking;
  List<BookingHomestayModel>? listCancelledBooking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _bloc.add(GetListBooking(status: 'PENDING'));
    //PENDING, DEPOSIT, CANCELLED, PAID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Các Đơn Đặt Homestay",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<HistoryBloc, HistoryState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is HistoryLoading) {
            setState(() {
              widthDisplay = 50;
              heightDisplay = 50;
              imageDisplay = 'assets/gifs/loading.gif';
            });
          } else if (state is GetHistorySuccess) {
            // Navigator.pop(context);
            switch (state.type) {
              case 'PENDING':
                listPendingBooking = state.listBooking;
                break;
              case 'DEPOSIT':
                listDepositBooking = state.listBooking;
                break;
              case 'PAID':
                listPaidBooking = state.listBooking;
                break;
              case 'CANCELLED':
                listCancelledBooking = state.listBooking;
                break;
            }
            // listBooking = state.listBooking;
            // print('Số lượng đơn: ${listBooking!.length}');
          } else if (state is ListBookingEmpty) {
            // Navigator.pop(context);
            widthDisplay = 270;
            heightDisplay = 270;
            imageDisplay = 'assets/images/empty_list.png';
            switch (state.type) {
              case 'PENDING':
                listPendingBooking = null;
                break;
              case 'DEPOSIT':
                listDepositBooking = null;
                break;
              case 'PAID':
                listPaidBooking = null;
                break;
              case 'CANCELLED':
                listCancelledBooking = null;
                break;
            }
          } else if (state is HistoryFailure) {
            // Navigator.pop(context);
            widthDisplay = 270;
            heightDisplay = 270;
            showError(context, state.error);
            imageDisplay = 'assets/images/error_loading.png';
          }
        },
        builder: (context, state) {
          // double screenWidth = MediaQuery.of(context).size.width;
          // double screenHeight = MediaQuery.of(context).size.height;
          return Column(
            children: [
              TabBar(
                dividerColor: AppColors.primaryColor1,
                indicatorColor: AppColors.primaryColor1,
                isScrollable: true,
                controller: tabController,
                tabAlignment: TabAlignment.start,
                onTap: (value) {
                  switch (value) {
                    case 0:
                      _bloc.add(GetListBooking(status: 'PENDING'));
                      break;
                    case 1:
                      _bloc.add(GetListBooking(status: 'DEPOSIT'));
                      break;
                    case 2:
                      _bloc.add(GetListBooking(status: 'PAID'));
                      break;
                    case 3:
                      _bloc.add(GetListBooking(status: 'CANCELLED'));
                      break;
                  }
                },
                tabs: const [
                  Tab(
                    text: 'Chờ xác nhận',
                  ),
                  Tab(
                    text: 'Đã đặt cọc',
                  ),
                  Tab(
                    text: 'Đã hoàn tất',
                  ),
                  Tab(
                    text: 'Đã hủy',
                  ),
                ],
                unselectedLabelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
                labelStyle: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    color: AppColors.primaryColor1,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    listBookingFunction(
                        imageDisplay: imageDisplay,
                        listBooking: listPendingBooking,
                        heightDisplay: heightDisplay,
                        widthDisplay: widthDisplay),
                    listBookingFunction(
                        imageDisplay: imageDisplay,
                        listBooking: listDepositBooking,
                        heightDisplay: heightDisplay,
                        widthDisplay: widthDisplay),
                    listBookingFunction(
                        imageDisplay: imageDisplay,
                        listBooking: listPaidBooking,
                        heightDisplay: heightDisplay,
                        widthDisplay: widthDisplay),
                    listBookingFunction(
                        imageDisplay: imageDisplay,
                        listBooking: listCancelledBooking,
                        heightDisplay: heightDisplay,
                        widthDisplay: widthDisplay),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget listBookingFunction({
  List<BookingHomestayModel>? listBooking,
  String? imageDisplay,
  double? widthDisplay,
  double? heightDisplay,
}) {
  if (listBooking != null) {
    return ListBooking(listBooking: listBooking);
  } else {
    return Center(
      child: (imageDisplay != null)
          ? SizedBox(
              width: widthDisplay,
              height: heightDisplay,
              child: Image.asset(
                imageDisplay,
                fit: BoxFit.cover,
              ),
            )
          : const SizedBox(),
    );
  }
}
