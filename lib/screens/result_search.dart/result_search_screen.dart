// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/homestay_preview.dart';
import 'package:mobile_home_travel/screens/navigator_bar.dart';
import 'package:mobile_home_travel/screens/result_search.dart/bloc/search_bloc.dart';
import 'package:mobile_home_travel/screens/result_search.dart/bloc/search_event.dart';
import 'package:mobile_home_travel/screens/result_search.dart/bloc/search_state.dart';
import 'package:mobile_home_travel/screens/result_search.dart/result_preview.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class ResultSearchScreen extends StatefulWidget {
  String stringLocation;
  String capacity;

  ResultSearchScreen({
    Key? key,
    required this.stringLocation,
    required this.capacity,
  }) : super(key: key);

  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  final _bloc = SearchBloc();
  int capacity = 0;
  List<HomestayModel> listHomestay = [];
  String displayScreen = 'assets/images/empty_search.png';
  double widthDisplay = 350;
  double heightDisplay = 350;
  @override
  void initState() {
    super.initState();
    String input = widget.stringLocation;
    List<String> parts = input.split(',');
    String location = parts.first.trim();
    capacity = int.parse(widget.capacity);
    _bloc.add(SearchHomestay(location: location, capacity: capacity));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey,
          toolbarHeight: kToolbarHeight + 5,
          leading: IconButton(
            onPressed: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName('/navigator'),
              );
            },
            icon: Icon(
              Icons.home_outlined,
              color: AppColors.primaryColor3.withOpacity(0.7),
              size: 30,
            ),
          ),
          actions: [
            Container(
              height: 50,
              width: screenWidth * 0.87,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                  borderRadius: BorderRadius.circular(100)),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Text(
                          widget.stringLocation,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.search,
                            color: AppColors.primaryColor3.withOpacity(0.7),
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BlocConsumer<SearchBloc, SearchState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is SearchLoading) {
              setState(() {
                widthDisplay = 50;
                heightDisplay = 50;
                displayScreen = 'assets/gifs/loading.gif';
              });
            } else if (state is SearchSuccess) {
              listHomestay = state.list;
            } else if (state is SearchEmpty) {
              setState(() {
                widthDisplay = 350;
                heightDisplay = 350;
                displayScreen = 'assets/images/empty_search.png';
              });
            } else if (state is SearchError) {
              setState(() {
                widthDisplay = 350;
                heightDisplay = 350;
                displayScreen = 'assets/images/error_loading.png';
              });
              toastification.show(
                  pauseOnHover: false,
                  showProgressBar: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.red,
                  ),
                  icon: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flatColored,
                  title: TextContent(
                    contentText: state.error,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 2500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topCenter);
            }
          },
          builder: (context, state) {
            return listHomestay.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.person,
                                color: AppColors.primaryColor3,
                              ),
                              label: Text(capacity.toString())),
                        ),
                        Center(
                          child: Column(
                            children: List.generate(
                              listHomestay.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: ResultPreview(
                                    homestayModel: listHomestay[index]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox(
                      width: widthDisplay,
                      height: heightDisplay,
                      child: Image.asset(
                        displayScreen,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
