// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/api/api_booking.dart';
import 'package:mobile_home_travel/api/api_homestay.dart';

import 'package:mobile_home_travel/models/homestay/feedback/feedback_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/gradient_button.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';

class ModalCreateFeedback extends StatefulWidget {
  String homestayId;
  ModalCreateFeedback({
    super.key,
    required this.homestayId,
  });

  @override
  State<ModalCreateFeedback> createState() => _ModalCreateFeedbackState();
}

class _ModalCreateFeedbackState extends State<ModalCreateFeedback> {
  FeedbackModel feedbackModel = FeedbackModel();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Dialog.fullscreen(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                const Text(
                  'Cho chúng tôi biết',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Trải nghiệm của bạn',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: AnimatedRatingBar(
                    activeFillColor: AppColors.primaryColor3,
                    strokeColor: AppColors.primaryColor3,
                    // initialRating: double.parse(
                    //     homestayModel.rating.toString()),
                    initialRating: 0,
                    height: 100,
                    width: 300,
                    animationColor: Colors.red,
                    onRatingUpdate: (rating) {
                      feedbackModel.rating = rating;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Viết đánh giá',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.top,
                  minLines: 3,
                  maxLines: 5,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor3,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Nhập đánh giá...",
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  onChanged: (text) {
                    feedbackModel.description = text;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundGradientButton(
                  textSize: 20,
                  title: 'Tạo',
                  circular: 10,
                  onPressed: () async {
                    feedbackModel.homeStayId = widget.homestayId;
                    print('đánh giá là: $feedbackModel');
                    var isCreated = await ApiHomestay.createFeedbackHomestay(
                        feedbackModel: feedbackModel);
                    if (isCreated == true) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      SuccessNotiProvider()
                          .ToastSuccess(context, 'Đánh giá thành công!');
                    } else {
                      Navigator.pop(context);
                      ErrorNotiProvider()
                          .ToastError(context, 'Đánh giá thất bại!');
                    }
                  },
                ),
                RoundGradientButton(
                  textSize: 20,
                  colorText: Colors.black.withOpacity(0.4),
                  color: Colors.grey[300],
                  title: 'Hủy',
                  circular: 10,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
