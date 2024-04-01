import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/api/api_room.dart';
import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_bloc.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_event.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/bloc/create_booking_state.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/row_room.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListRoomEmpty extends StatefulWidget {
  String dateCheckIn;
  String dateCheckOut;
  ListRoomEmpty({
    Key? key,
    required this.dateCheckIn,
    required this.dateCheckOut,
  }) : super(key: key);

  @override
  State<ListRoomEmpty> createState() => _ListRoomEmptyState();
}

class _ListRoomEmptyState extends State<ListRoomEmpty> {
  final _bloc = CreateBookingBloc();
  BookingHomestayModel? outputBooking;
  BookingHomestayModel inputBooking = BookingHomestayModel();
  List<RoomModel> listRoom = [];
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    inputBooking.checkInDate =
        FormatProvider().convertDateFormat(widget.dateCheckIn);
    inputBooking.checkOutDate =
        FormatProvider().convertDateFormat(widget.dateCheckOut);
    _loadListRoomEmpty();
  }

  Future<List<RoomModel>?> getListRoomEmpty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idHomestay = prefs.getString("idHomestay")!;
    String idUser = prefs.getString("idUserCurrent")!;
    inputBooking.touristId = idUser;
    var listRoomEmpty = await ApiRoom.getAllRoomEmptyByDate(
        homeStayId: idHomestay,
        dateCheckIn: widget.dateCheckIn,
        dateCheckOut: widget.dateCheckOut);
    print('list room trống: $listRoomEmpty');
    return listRoomEmpty;
  }

  Future<void> _loadListRoomEmpty() async {
    final list = await getListRoomEmpty();
    if (mounted) {
      setState(
        () {
          //get list images homestay
          if (list!.isNotEmpty) {
            listRoom = list;
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        // centerTitle: true,
        title: Text(
          "Chọn phòng",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.65),
              fontSize: 20,
              fontFamily: GoogleFonts.nunito().fontFamily),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close_rounded,
              color: AppColors.primaryColor3.withOpacity(0.7),
              size: 27,
            ),
          ),
        ],
      ),
      body: BlocConsumer<CreateBookingBloc, CreateBookingState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is CreateBookingLoading) {
            onLoading(context);
            return;
          } else if (state is CreateBookingSuccess) {
            Navigator.pop(context);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setStringList("listIdPicked", []);
            outputBooking = state.bookingHomestayModel;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ReviewBooking(
                        bookingHomestayModel: outputBooking!,
                      )),
            );
          } else if (state is CreateBookingFailure) {
            Navigator.pop(context);
            showError(context, state.error);
          }
        },
        builder: (context, state) {
          return listRoom.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: screenHeight * 0.77,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: List.generate(listRoom.length,
                              (index) => RowRoom(room: listRoom[index])),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: RoundGradientButton(
                        title: 'Tiếp tục',
                        height: 25,
                        width: 110,
                        onPressed: () {
                          _bloc.add(CreateBooking(
                              bookingHomestayModel: inputBooking));
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: SizedBox(
                    width: 350,
                    height: 350,
                    child: Image.asset(
                      'assets/images/empty_search.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
