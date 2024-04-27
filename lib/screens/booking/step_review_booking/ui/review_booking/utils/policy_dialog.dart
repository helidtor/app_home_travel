// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/homestay/policy/homestay_policy_selected_model.dart';

import 'package:mobile_home_travel/models/homestay/policy/policy_title_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class PolicyDialog extends StatefulWidget {
  List<HomestayPolicySelectedModel> listPolicies;
  PolicyDialog({
    super.key,
    required this.listPolicies,
  });

  @override
  State<PolicyDialog> createState() => _PolicyDialogState();
}

class _PolicyDialogState extends State<PolicyDialog> {
  List<HomestayPolicySelectedModel> listPolicies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.listPolicies.isNotEmpty) {
      listPolicies = widget.listPolicies;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: const Text(
        'Chính sách & Điều khoản',
        style: TextStyle(
            color: Color.fromARGB(255, 95, 62, 186),
            fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
              height: 1,
              color: AppColors.primaryColor1), // Đường kẻ giữa title và content
          const SizedBox(height: 10),
          Center(
            child: listPolicies.isNotEmpty
                ? SizedBox(
                    height: screenHeight * 0.55,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          listPolicies.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ${listPolicies[index].policyTitle!.name!}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    '✍ ${listPolicies[index].policy!.description!}',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    listPolicies[index].policy!.subDescription!,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Homestay không có ràng buộc 😉',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Đã hiểu',
            style: TextStyle(
                color: Color.fromARGB(235, 109, 55, 173),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
