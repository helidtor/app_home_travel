// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:toastification/toastification.dart';

class ResultSearchScreen extends StatefulWidget {
  String stringLocation;
  ResultSearchScreen({
    Key? key,
    required this.stringLocation,
  }) : super(key: key);

  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  final _bloc = SearchBloc();
  List<HomestayModel> listHomestay = [];

  @override
  void initState() {
    super.initState();
    String input = widget.stringLocation;
    List<String> parts = input.split(',');
    String location = parts.first.trim();
    _bloc.add(SearchHomestay(location: location));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 10,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/navigator'),
                );
              },
              icon: Icon(
                Icons.close,
                color: AppColors.primaryColor3.withOpacity(0.7),
                size: 25,
              ),
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
              child: Row(
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
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.primaryColor3.withOpacity(0.7),
                      ),
                    ),
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
              onLoading(context);
              return;
            } else if (state is SearchSuccess) {
              Navigator.pop(context);
              listHomestay = state.list;
            } else if (state is SearchEmpty) {
              Navigator.pop(context);
            } else if (state is SearchError) {
              Navigator.pop(context);
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
                    child: Center(
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
                  )
                : Center(
                    child: SizedBox(
                      width: 350,
                      height: 350,
                      child: Image.asset(
                        "assets/images/empty_search.png",
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
