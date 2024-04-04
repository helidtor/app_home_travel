// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'package:mobile_home_travel/constants/keyMap.dart';
import 'package:mobile_home_travel/screens/result_search.dart/ui/result_search_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/gradient_button.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';

class AutocompleteMap extends StatefulWidget {
  bool? isHaveBtnClose;
  AutocompleteMap({
    Key? key,
    this.isHaveBtnClose,
  }) : super(key: key);

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<AutocompleteMap> {
  // ignore: non_constant_identifier_names
  List<dynamic> places = [];
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> details = [];
  CircleAnnotationManager? _circleAnnotationManager;

  MapboxMap? mapboxMap;
// ignore: non_constant_identifier_names

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }

  String searchText = "";
  String selectedText = "";
  bool isShow = false;
  bool isHidden = true;
  String capacity = '0';

  Future<void> fetchData(String input) async {
    try {
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/AutoComplete?api_key=$keyMap&input=$input');

      var response = await http.get(url);

      setState(() {
        final jsonResponse = jsonDecode(response.body);
        places = jsonResponse['predictions'] as List<dynamic>;
        _circleAnnotationManager?.deleteAll();
        isShow = true;
        isHidden = true;
      });
    } catch (e) {
      // ignore: avoid_print
      print('$e');
    }
  }

  Widget _buildListView() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final coordinate = places[index];

        return ListTile(
          horizontalTitleGap: 5,
          title: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.primaryColor3,
                size: 20,
              ),
              SizedBox(
                width: 320,
                child: Text(
                  coordinate['description'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          onTap: () async {
            setState(() {
              isShow = false;
              isHidden = false;
              //lấy địa điểm search
              selectedText = coordinate['description'];
              print("Địa điểm đã chọn: $selectedText");
              //-------------------------Tìm kiếm--------------------------------
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    titlePadding: EdgeInsets.zero,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Row(
                        children: [
                          Text(
                            'Nhập số người đi',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              color: AppColors.primaryColor3.withOpacity(0.9),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.primaryColor3.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor3,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor3,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              capacity = text;
                            });
                          },
                        ),
                        const SizedBox(height: 5),
                        RoundGradientButton(
                          title: 'Tìm kiếm',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultSearchScreen(
                                        stringLocation: selectedText,
                                        capacity: capacity,
                                      )),
                            );
                          },
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.grey),
                    ),
                  );
                },
              );
            });

            final url = Uri.parse(
                'https://rsapi.goong.io/geocode?address=${coordinate['description']}&api_key=HZHyZbGnVTYLMnnm0v4RY7RVSXlScGp9nwd7LS6l');
            var response = await http.get(url);
            final jsonResponse = jsonDecode(response.body);
            details = jsonResponse['results'] as List<dynamic>;

            mapboxMap?.annotations
                .createCircleAnnotationManager()
                .then((value) async {
              setState(() {
                _circleAnnotationManager =
                    value; // Store the reference to the circle annotation manager
              });
            });
            _searchController.text = coordinate['description'];
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 10,
          leading: (widget.isHaveBtnClose != null && widget.isHaveBtnClose!)
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.primaryColor3.withOpacity(0.7),
                  ),
                )
              : const SizedBox(),
          actions: [
            Container(
              height: 50,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                  borderRadius: BorderRadius.circular(100)),
              child: TextField(
                controller: _searchController,
                onChanged: (text) {
                  setState(() {
                    capacity = text;
                  });
                  fetchData(text);
                  isHidden = true;
                },
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: Text(
                          'Xóa',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primaryColor3.withOpacity(0.7)),
                        ),
                      ),
                    ),
                    hintText: "Nhập nơi bạn muốn đến...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.35), fontSize: 17)),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            if (isShow == true)
              Container(
                padding: const EdgeInsets.only(left: 5),
                height: 120,
                decoration: const BoxDecoration(color: Colors.white),
                child: _buildListView(),
              ),
          ],
        ),
      ),
    );
  }
}
