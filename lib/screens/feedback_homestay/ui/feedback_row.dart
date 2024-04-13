// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      height: 130,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(253, 255, 255, 255),
          ),
          color: const Color.fromARGB(253, 255, 255, 255),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 120,
              height: 110,
              decoration: BoxDecoration(
                color: const Color.fromARGB(253, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (feedbackModel.tourist!.avatar!.isEmpty)
                      ? const AssetImage("assets/images/homestay_default.jpg")
                      : Image.network(feedbackModel.tourist!.avatar!).image,
                  // image: AssetImage("assets/images/homestay_default.jpg"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${feedbackModel.tourist!.firstName} ${feedbackModel.tourist!.lastName}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.location_on,
                //       size: 15,
                //       color: AppColors.primaryColor3,
                //     ),
                //     Text(
                //       '${feedbackModel.homeStay!.city}',
                //       style: const TextStyle(fontSize: 13, color: Colors.black),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 15,
                      color: AppColors.primaryColor3,
                    ),
                    const Text('Ngày đăng: ',
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                    Text(
                      FormatProvider()
                          .convertDate(feedbackModel.createdDate.toString()),
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
