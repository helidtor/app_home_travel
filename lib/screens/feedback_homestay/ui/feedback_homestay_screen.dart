// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/models/homestay/feedback/feedback_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_bloc.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_event.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_state.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/ui/feedback_row.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class FeedbackHomestayScreen extends StatefulWidget {
  HomestayDetailModel homestayDetailModel;
  FeedbackHomestayScreen({
    super.key,
    required this.homestayDetailModel,
  });

  @override
  State<FeedbackHomestayScreen> createState() => _FeedbackHomestayScreenState();
}

class _FeedbackHomestayScreenState extends State<FeedbackHomestayScreen> {
  late HomestayDetailModel homestayDetailModel;
  final _bloc = FeedbackBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homestayDetailModel = widget.homestayDetailModel;
    if (homestayDetailModel.id != null) {
      _bloc.add(GetFeedBackHomestay(idHomestay: homestayDetailModel.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<FeedbackModel> listFeedback = [];

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        // centerTitle: true,
        title: const Text(
          "Chi tiết đánh giá",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(182, 0, 0, 0),
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<FeedbackBloc, FeedbackState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is FeedbackLoading) {
            onLoading(context);
            return;
          } else if (state is GetFeedbackSuccess) {
            Navigator.pop(context);
            listFeedback = state.listFeedback;
          } else if (state is GetFeedbackFailure) {
            Navigator.pop(context);
            showError(context, state.error);
          }
        },
        builder: (context, state) {
          return (listFeedback.isNotEmpty)
              ? Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          height: 100,
                          width: screenWidth * 0.95,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor3,
                              ),
                              color: const Color.fromARGB(253, 255, 255, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0.5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    homestayDetailModel.rating.toString(),
                                    style: const TextStyle(
                                        fontSize: 35,
                                        color: AppColors.primaryColor3),
                                  ),
                                  AnimatedRatingBar(
                                    activeFillColor: AppColors.primaryColor3,
                                    strokeColor: AppColors.primaryColor3,
                                    initialRating: double.parse(
                                        homestayDetailModel.rating.toString()),
                                    height: 45,
                                    width: 200,
                                    animationColor: Colors.red,
                                    onRatingUpdate: (rating) {
                                      debugPrint(rating.toString());
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Center(
                              child: Column(
                                children: List.generate(
                                  listFeedback.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: FeedbackRow(
                                        feedbackModel: listFeedback[index]),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      'assets/images/empty_list.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
