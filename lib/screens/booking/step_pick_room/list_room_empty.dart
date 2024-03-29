// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/api/api_room.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/row_room.dart';
import 'package:mobile_home_travel/screens/booking/step_review_booking/review_booking.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
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
  List<RoomModel> listRoom = [];
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    _loadListRoomEmpty();
  }

  Future<List<RoomModel>?> getListRoomEmpty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idHomestay = prefs.getString("idHomestay")!;
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
      body: listRoom.isNotEmpty
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReviewBooking()),
                      );
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
            ),
    );
  }
}
