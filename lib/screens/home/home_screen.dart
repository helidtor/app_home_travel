import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/models/homestay_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_bloc.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_event.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_state.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/homestay_preview.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomestayModel> listHomestay = [];
  final _bloc = HomestayBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllListHomestay());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomestayBloc, HomestayState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is HomestayLoading) {
              onLoading(context);
              return;
            } else if (state is HomestaySuccess) {
              Navigator.pop(context);
              listHomestay = state.list;
            } else if (state is HomestayError) {
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
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Bạn muốn đi đâu?',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                                gapPadding: 5.0,
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
                          mainAxisAlignment:
                              MainAxisAlignment.start, // Căn chỉnh
                          children: [
                            Text(
                              (listHomestay.length > 1) ? "Nổi bật" : "",
                              style: const TextStyle(
                                fontSize: 27,
                                color: Colors.black,
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
                              listHomestay.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: HomestayPreview(
                                    homestayModel: listHomestay[index]),
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
                              (listHomestay.length > 1) ? "Xu hướng" : "",
                              style: const TextStyle(
                                fontSize: 27,
                                color: Colors.black,
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
                              listHomestay.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: HomestayPreview(
                                    homestayModel: listHomestay[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: Row(
                      //     mainAxisAlignment:
                      //         MainAxisAlignment.start, // Căn chỉn
                      //     children: [
                      //       Text(
                      //         (listHomestay.length > 1) ? "Xu hướng" : "",
                      //         style: const TextStyle(
                      //           fontSize: 27,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // GridView.count(
                      //   crossAxisCount: 2, // Số cột
                      //   children: List.generate(4, (index) {
                      //     // Tạo danh sách hình ảnh
                      //     return GridTile(
                      //       child: Image.asset(
                      //         'assets/images/image$index.jpg', // Thay đổi tên tập tin hình ảnh tùy thuộc vào tên thực tế của bạn
                      //         fit: BoxFit.cover,
                      //       ),
                      //     );
                      //   }),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
