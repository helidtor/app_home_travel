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
import 'package:mobile_home_travel/screens/booking/step_pick_room/ui/row_room.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/ui/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListRoomEmpty extends StatefulWidget {
  String dateCheckIn;
  String dateCheckOut;
  ListRoomEmpty({
    super.key,
    required this.dateCheckIn,
    required this.dateCheckOut,
  });

  @override
  State<ListRoomEmpty> createState() => _ListRoomEmptyState();
}

class _ListRoomEmptyState extends State<ListRoomEmpty> {
  String? imageDisplay;
  bool isDisplay = false;
  final _bloc = CreateBookingBloc();
  BookingHomestayModel? outputBooking;
  BookingHomestayModel inputBooking = BookingHomestayModel();
  List<RoomModel> listRoom = [];
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    inputBooking.checkInDate =
        FormatProvider().convertDateTimeFormat(widget.dateCheckIn);
    inputBooking.checkOutDate =
        FormatProvider().convertDateTimeFormat(widget.dateCheckOut);
    _bloc.add(CheckListRoom(
        checkInDate: widget.dateCheckIn, checkOutDate: widget.dateCheckOut));
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
          } else if (state is CheckListRoomSuccess) {
            Navigator.pop(context);
            setState(() {
              isDisplay = true;
            });
            listRoom = state.listRoom;
            inputBooking.touristId = state.idUser;
          } else if (state is CheckListRoomFailure) {
            Navigator.pop(context);
            setState(() {
              isDisplay = false;
              imageDisplay = 'assets/images/empty_search.png';
            });
          }
        },
        builder: (context, state) {
          return isDisplay
              ? Container(
                  alignment: Alignment.topCenter,
                  height: screenHeight * 0.77,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: List.generate(listRoom.length,
                          (index) => RowRoom(room: listRoom[index])),
                    ),
                  ),
                )
              : Center(
                  child: (imageDisplay != null)
                      ? SizedBox(
                          width: 330,
                          height: 330,
                          child: Image.asset(
                            imageDisplay!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: isDisplay
          ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: RoundGradientButton(
                title: 'Tạo đơn',
                height: 25,
                width: 110,
                onPressed: () {
                  _bloc.add(CreateBooking(bookingHomestayModel: inputBooking));
                },
              ),
            )
          : const SizedBox(),
    );
  }
}
