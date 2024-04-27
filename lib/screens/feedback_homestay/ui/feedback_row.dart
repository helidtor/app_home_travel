// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/models/homestay/feedback/feedback_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

class FeedbackRow extends StatefulWidget {
  FeedbackModel feedbackModel;
  FeedbackRow({
    super.key,
    required this.feedbackModel,
  });

  @override
  State<FeedbackRow> createState() => _FeedbackRowState();
}

class _FeedbackRowState extends State<FeedbackRow> {
  late FeedbackModel feedbackModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedbackModel = widget.feedbackModel;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // height: 130,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(253, 255, 255, 255),
          ),
          color: const Color.fromARGB(253, 255, 255, 255),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(253, 255, 255, 255),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(180)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (feedbackModel.tourist!.avatar!.isEmpty)
                            ? const AssetImage(
                                "assets/images/homestay_default.jpg")
                            : Image.network(feedbackModel.tourist!.avatar!)
                                .image,
                        // image: AssetImage("assets/images/homestay_default.jpg"),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${feedbackModel.tourist!.firstName} ${feedbackModel.tourist!.lastName}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        AnimatedRatingBar(
                          activeFillColor: AppColors.primaryColor3,
                          strokeColor: AppColors.primaryColor3,
                          // initialRating: double.parse(
                          //     homestayDetailModel.rating.toString()),
                          initialRating: double.parse(
                              feedbackModel.rating!.floor().toString()),
                          height: 20,
                          width: 60,
                          animationColor: Colors.red,
                          onRatingUpdate: (rating) {
                            debugPrint(rating.toString());
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          FormatProvider().convertDateTimeFeedback(
                              feedbackModel.createdDate.toString()),
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 10),
              child: Container(
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(252, 217, 215, 215),
                  ),
                  color: Colors.black.withOpacity(0.03),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${feedbackModel.description}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
