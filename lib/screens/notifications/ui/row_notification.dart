import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/models/notification/notification_model.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/ui/homestay_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RowNotification extends StatefulWidget {
  NotificationModel notificationModel;
  RowNotification({
    super.key,
    required this.notificationModel,
  });

  @override
  State<RowNotification> createState() => _ResultState();
}

class _ResultState extends State<RowNotification> {
  late NotificationModel notificationModel;
  late bool isRead;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationModel = widget.notificationModel;
    notificationModel.status == null
        ? isRead = false
        : (notificationModel.status == 'SENT' ? isRead = false : isRead = true);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        var isSuccess = await ApiUser.readNoti(idNoti: notificationModel.id!);
        if (isSuccess == true) {
          setState(() {
            isRead = true;
          });
        }
      },
      child: Container(
        height: 112,
        width: screenSize.width * 0.95,
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: Color.fromARGB(252, 5, 3, 3),
          // ),
          color: isRead
              ? const Color.fromARGB(253, 255, 255, 255)
              : AppColors.primaryColor1.withOpacity(0.15),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.03),
          child: Row(
            children: [
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.width * 0.2,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(253, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(500)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: notificationModel.image == null
                        ? const AssetImage("assets/images/homestay_default.jpg")
                        : Image.network(notificationModel.image!).image,
                    // image: AssetImage("assets/images/homestay_default.jpg"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 10),
                child: SizedBox(
                  width: screenSize.width * 0.65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          notificationModel.content!,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight:
                                isRead ? FontWeight.normal : FontWeight.bold,
                            fontSize: 14.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'lúc ${FormatProvider().convertDateTime(notificationModel.createdDate.toString())}',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          const Spacer(),
                          isRead
                              ? const SizedBox()
                              : const Icon(
                                  Icons.circle,
                                  size: 15,
                                  color: AppColors.primaryColor1,
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
