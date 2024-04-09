import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_bloc.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_event.dart';
import 'package:mobile_home_travel/screens/history_booking/bloc/history_state.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_row.dart';
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
    List<BookingHomestayModel>? listBooking;

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
              onLoading(context);
              return;
            } else if (state is GetHistorySuccess) {
              Navigator.pop(context);
              listBooking = state.listBooking;
            } else if (state is ListBookingEmpty) {
              Navigator.pop(context);
              listBooking = null;
              imageDisplay = 'assets/images/empty_list.png';
            } else if (state is HistoryFailure) {
              Navigator.pop(context);
              showError(context, state.error);
              imageDisplay = 'assets/images/error_loading.png';
            }
          },
          builder: (context, state) {
            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;
            return Column(
              children: [
                TabBar(
                  dividerColor: AppColors.primaryColor1,
                  indicatorColor: AppColors.primaryColor1,
                  isScrollable: true,
                  controller: tabController,
                  onTap: (value) {
                    switch (value) {
                      case 0:
                        _bloc.add(GetListBooking(status: 'PENDING'));
                      case 1:
                        _bloc.add(GetListBooking(status: 'DEPOSIT'));
                      case 2:
                        _bloc.add(GetListBooking(status: 'PAID'));
                      case 3:
                        _bloc.add(GetListBooking(status: 'CANCELLED'));
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
                  labelColor: Colors.black,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      (listBooking != null)
                          ? ListBooking(listBooking: listBooking!)
                          : Center(
                              child: (imageDisplay != null)
                                  ? SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image.asset(
                                        imageDisplay!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                      (listBooking != null)
                          ? ListBooking(listBooking: listBooking!)
                          : Center(
                              child: (imageDisplay != null)
                                  ? SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image.asset(
                                        imageDisplay!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                      (listBooking != null)
                          ? ListBooking(listBooking: listBooking!)
                          : Center(
                              child: (imageDisplay != null)
                                  ? SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image.asset(
                                        imageDisplay!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                      (listBooking != null)
                          ? ListBooking(listBooking: listBooking!)
                          : Center(
                              child: (imageDisplay != null)
                                  ? SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image.asset(
                                        imageDisplay!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
