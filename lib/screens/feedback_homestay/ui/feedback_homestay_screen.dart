// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/models/homestay/feedback/feedback_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_detail_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_bloc.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_event.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/bloc/feedback_state.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/ui/feedback_row.dart';
import 'package:mobile_home_travel/screens/feedback_homestay/ui/modal_create_feedback.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class FeedbackHomestayScreen extends StatefulWidget {
  HomestayModel? homestayModel; // từ detail homestay qua
  HomestayDetailModel? homestayDetailModel; //từ lịch sử qua
  bool? isCreateFeedback;
  FeedbackHomestayScreen({
    super.key,
    this.isCreateFeedback,
    this.homestayModel,
    this.homestayDetailModel,
  });

  @override
  State<FeedbackHomestayScreen> createState() => _FeedbackHomestayScreenState();
}

class _FeedbackHomestayScreenState extends State<FeedbackHomestayScreen> {
  var homestayModel;
  final _bloc = FeedbackBloc();
  bool isCreateFeedback = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homestayModel = widget.homestayModel ?? widget.homestayDetailModel;
    if (homestayModel.id != null) {
      _bloc.add(GetFeedBackHomestay(idHomestay: homestayModel.id!));
    }
    if (widget.isCreateFeedback != null) {
      isCreateFeedback = widget.isCreateFeedback!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
        title: Text(
          (widget.homestayModel != null)
              ? 'Đánh giá ${widget.homestayModel!.name}'
              : 'Đánh giá ${widget.homestayDetailModel!.name}',
          style: const TextStyle(
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
            ErrorNotiProvider().showError(context, state.error);
          } else if (state is CreateFeedbackSuccess) {
            Navigator.pop(context);
            SuccessNotiProvider().ToastSuccess(context, 'Đánh giá thành công!');
          } else if (state is CreateFeedbackFailure) {
            Navigator.pop(context);
            ErrorNotiProvider().ToastError(context, 'Đánh giá thất bại!');
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
                          height: !isCreateFeedback
                              ? screenHeight * 0.15 //nếu không cho feedback
                              : screenHeight * 0.25,
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
                                    (homestayModel.rating != null)
                                        ? '${homestayModel.rating.toStringAsFixed(1)}/5.0'
                                        : '0.0/5.0',
                                    style: const TextStyle(
                                        fontSize: 35,
                                        color: AppColors.primaryColor3),
                                  ),
                                  AnimatedRatingBar(
                                    activeFillColor: AppColors.primaryColor3,
                                    strokeColor: AppColors.primaryColor3,
                                    // initialRating: double.parse(
                                    //     homestayModel.rating.toString()),
                                    initialRating: double.parse(homestayModel
                                        .rating!
                                        .floor()
                                        .toString()),
                                    height: 45,
                                    width: 200,
                                    animationColor: Colors.red,
                                    onRatingUpdate: (rating) {
                                      debugPrint(rating.toString());
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                '(${listFeedback.length} đánh giá)',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.primaryColor3),
                              ),
                              isCreateFeedback
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ModalCreateFeedback(
                                                homestayId:
                                                    (widget.homestayDetailModel !=
                                                            null)
                                                        ? (widget
                                                            .homestayDetailModel!
                                                            .rooms![0]
                                                            .homeStay!
                                                            .id!)
                                                        : homestayModel.id,
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: AppColors.primaryColor3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
                                            'Viết đánh giá',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.primaryColor3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: !isCreateFeedback
                            ? screenHeight * 0.65 //nếu không cho feedback
                            : screenHeight * 0.58,
                        child: SingleChildScrollView(
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
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          height: !isCreateFeedback
                              ? screenHeight * 0.15 //nếu không cho feedback
                              : screenHeight * 0.25,
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
                                    (homestayModel.rating != null)
                                        ? '${homestayModel.rating.toStringAsFixed(1)}/5.0'
                                        : '0.0/5.0',
                                    style: const TextStyle(
                                        fontSize: 35,
                                        color: AppColors.primaryColor3),
                                  ),
                                  AnimatedRatingBar(
                                    activeFillColor: AppColors.primaryColor3,
                                    strokeColor: AppColors.primaryColor3,
                                    // initialRating: double.parse(
                                    //     homestayModel.rating.toString()),
                                    initialRating: double.parse(homestayModel
                                        .rating!
                                        .floor()
                                        .toString()),
                                    height: 45,
                                    width: 200,
                                    animationColor: Colors.red,
                                    onRatingUpdate: (rating) {
                                      debugPrint(rating.toString());
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                listFeedback.isNotEmpty
                                    ? '(${listFeedback.length} đánh giá)'
                                    : '(0 đánh giá)',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.primaryColor3),
                              ),
                              isCreateFeedback
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ModalCreateFeedback(
                                                homestayId:
                                                    (widget.homestayDetailModel !=
                                                            null)
                                                        ? (widget
                                                            .homestayDetailModel!
                                                            .rooms![0]
                                                            .homeStay!
                                                            .id!)
                                                        : homestayModel.id,
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: AppColors.primaryColor3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
                                            'Viết đánh giá',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.primaryColor3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Image.asset(
                              'assets/images/feedback_empty1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            'Chưa có đánh giá!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
