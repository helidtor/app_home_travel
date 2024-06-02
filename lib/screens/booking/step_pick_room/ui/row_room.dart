// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/screens/room/room_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';

class RowRoom extends StatefulWidget {
  RoomModel room;
  num priceRoom;
  RowRoom({
    super.key,
    required this.room,
    required this.priceRoom,
  });

  @override
  State<RowRoom> createState() => _RowRoomState();
}

class _RowRoomState extends State<RowRoom> {
  List<String> listIdPicked = [];
  late RoomModel roomEmpty;
  bool isChecked = false;
  late num priceRoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomEmpty = widget.room;
    priceRoom = widget.priceRoom;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        SharedPreferencesUtil.setIdRoom(roomEmpty.id!);
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const roomDetail()),
        );
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor3, width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  roomEmpty.name!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.65)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.person,
                      color: AppColors.primaryColor3,
                      size: 20,
                    ),
                    Text(
                      '${roomEmpty.capacity}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Row(
                  children: [
                    const Icon(
                      Icons.payments_outlined,
                      color: AppColors.primaryColor3,
                      size: 20,
                    ),
                    Text(
                      ' ${FormatProvider().formatPrice(priceRoom.toString())}₫',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                activeColor: AppColors.primaryColor3,
                shape: const CircleBorder(),
                value: isChecked,
                onChanged: (newValue) async {
                  setState(() {
                    isChecked = newValue!;
                  });
                  //save list id room picked in prefs
                  listIdPicked = SharedPreferencesUtil.getListIdPicked() ?? [];
                  if (isChecked) {
                    listIdPicked.add(roomEmpty.id!);
                  } else {
                    listIdPicked.remove(roomEmpty.id!);
                  }
                  print('List id picked current: $listIdPicked');
                  SharedPreferencesUtil.setListIdPicked(listIdPicked);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
