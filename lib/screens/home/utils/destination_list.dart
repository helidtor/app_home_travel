import 'package:flutter/material.dart';
import 'package:mobile_home_travel/screens/home/utils/destination_preview.dart';

class DestinationList extends StatefulWidget {
  DestinationList({super.key});

  @override
  State<DestinationList> createState() => _DestinationListState();
}

class _DestinationListState extends State<DestinationList> {
  List<String> listImage = [
    'assets/images/da_lat.jpg',
    'assets/images/vung_tau.jpg',
    'assets/images/da_nang.jpg',
    'assets/images/ha_long.jpg',
  ];
  List<String> listName = ['Đà Lạt', 'Vũng Tàu', 'Đà Nẵng', 'Hạ Long'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listImage.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: DestinationPreview(
                image: listImage[index],
                name: listName[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
