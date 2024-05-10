import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/constant/myToken.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/autocomplete_map/autocomplete_map.dart';
import 'package:mobile_home_travel/screens/home/utils/destination_list.dart';
import 'package:mobile_home_travel/screens/home/utils/destination_preview.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_preview/bloc/homestay_bloc.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_preview/bloc/homestay_event.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_preview/bloc/homestay_state.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_preview/ui/homestay_preview.dart';
import 'package:mobile_home_travel/screens/login/ui/login_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomestayModel>? listHomestayRating;
  List<HomestayModel>? listHomestayNew;
  final _bloc = HomestayBloc();
  String? displayScreen;
  double widthDisplay = 270;
  double heightDisplay = 270;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllListHomestay());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomestayBloc, HomestayState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is HomestayLoading) {
              // onLoading(context);
              // return;
              setState(() {
                widthDisplay = 50;
                heightDisplay = 50;
                displayScreen = 'assets/gifs/loading.gif';
              });
            } else if (state is HomestaySuccess) {
              // Navigator.pop(context);
              listHomestayNew = state.listNew;
              listHomestayRating = state.listRating;
            } else if (state is HomestayError) {
              // Navigator.pop(context);
              widthDisplay = 270;
              heightDisplay = 270;
              displayScreen = 'assets/images/error_loading.png';
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
            return (listHomestayNew != null && listHomestayRating != null)
                ? SingleChildScrollView(
                    child: Stack(
                      children: [
                        // Màu fade
                        Container(
                          height: screenHeight * 0.25,
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primaryColor3,
                                Color.fromARGB(0, 255, 255, 255),
                                Color.fromARGB(0, 255, 255, 255),
                              ], // Thay đổi màu sắc gradient tại đây
                            ),
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.25,
                          width: screenWidth,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryColor1,
                                Color.fromARGB(0, 255, 255, 255),
                                Color.fromARGB(0, 255, 255, 255),
                              ], // Thay đổi màu sắc gradient tại đây
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                // width: 80,
                                height: 40,
                                // child: Image.asset(
                                //   'assets/images/logo-notext.png',
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryColor1
                                            .withOpacity(0.2), // Màu của bóng
                                        spreadRadius: 1, // Bán kính bóng
                                        blurRadius: 4, // Độ mờ của bóng
                                        offset: const Offset(
                                            2, 2), // Độ lệch của bóng
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),

                                    // border: Border.all(
                                    //     width: 1,
                                    //     color: AppColors.primaryColor3),
                                  ),
                                  height: 60,
                                  child: TextFormField(
                                    readOnly: true,
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AutocompleteMap(
                                                isHaveBtnClose: true,
                                              )),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Bạn muốn đi đâu?',
                                      hintStyle: const TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              194, 158, 158, 158)),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          bottom: 2,
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          color: AppColors.primaryColor1,
                                          size: 25,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 50,
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.start, // Căn chỉnh
                              //     children: [
                              //       Text(
                              //         (listHomestayRating!.isNotEmpty)
                              //             ? "Điểm đến nổi bật"
                              //             : "",
                              //         style: TextStyle(
                              //           fontSize: 20,
                              //           color: Colors.black.withOpacity(0.75),
                              //           fontWeight: FontWeight.bold,
                              //           //
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              DestinationList(),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start, // Căn chỉnh
                                  children: [
                                    Text(
                                      (listHomestayRating!.isNotEmpty)
                                          ? "Homestay hàng đầu"
                                          : "",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black.withOpacity(0.75),
                                        fontWeight: FontWeight.bold,
                                        //
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      listHomestayRating!.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: HomestayPreview(
                                            homestayModel:
                                                listHomestayRating![index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      (listHomestayNew!.isNotEmpty)
                                          ? "Homestay mới"
                                          : "",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black.withOpacity(0.75),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      listHomestayNew!.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: HomestayPreview(
                                            homestayModel:
                                                listHomestayNew![index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: (displayScreen != null)
                        ? SizedBox(
                            width: widthDisplay,
                            height: heightDisplay,
                            child: Image.asset(
                              displayScreen!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(),
                  );
          }),
    );
  }
}
