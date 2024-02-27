import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/models/homestay_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_bloc.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_event.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/bloc/homestay_state.dart';
import 'package:mobile_home_travel/screens/homestay/homestay/homestay_preview.dart';
import 'package:mobile_home_travel/widgets/bar/navigation_bar.dart';
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
      bottomNavigationBar: const NavigationBarWidget(),
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
                  style: ToastificationStyle.minimal,
                  title: TextContent(
                    contentText: state.error,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 200,
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
                        height: 20,
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
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
