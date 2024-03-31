import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';

class ReviewBooking extends StatefulWidget {
  const ReviewBooking({super.key});

  @override
  State<ReviewBooking> createState() => _ReviewBookingState();
}

class _ReviewBookingState extends State<ReviewBooking> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        // centerTitle: true,
        title: Text(
          "Hoàn tất đặt phòng",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.65),
              fontSize: 20,
              fontFamily: GoogleFonts.nunito().fontFamily),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close_rounded,
              color: AppColors.primaryColor3.withOpacity(0.7),
              size: 27,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor1.withOpacity(0.2),
                        spreadRadius: 0.1,
                        blurRadius: 9,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.2), width: 1)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 20,
                                top: 20,
                              ),
                              // ảnh
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor1
                                        .withOpacity(0.2),
                                    spreadRadius: 0.1,
                                    blurRadius: 9,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: const Color.fromARGB(253, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/image4.jpg"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Yoko Homestay 2',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: AppColors.primaryColor3
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 17,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: AppColors.primaryColor3
                                            .withOpacity(0.7),
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'T3, 02/04 - T6, 06/04',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.primaryColor3
                                            .withOpacity(0.7),
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Đà Lạt',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.door_back_door_outlined,
                                        color: AppColors.primaryColor3
                                            .withOpacity(0.7),
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '2 phòng',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      //Đường kẻ
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: screenWidth * 0.75,
                        child: const Divider(
                          thickness: 0.3,
                          color: AppColors.primaryColor3,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17),
                            child: Text(
                              'Tổng cộng',
                              style: TextStyle(
                                fontSize: 20,
                                // color: AppColors.primaryColor3.withOpacity(0.8),
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    const TextSpan(
                                        text: "515.000 VNĐ\n",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            "đã bao gồm thuế,\ntiện ích chung",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey.withOpacity(0.7),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500)),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.4),
                                  width: 0.8),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Xem chi tiết',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 15,
                ),
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor1.withOpacity(0.2),
                        spreadRadius: 0.1,
                        blurRadius: 9,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.2), width: 1)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin cá nhân',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.person_outline,
                            color: AppColors.primaryColor3.withOpacity(0.7),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Ngô Trường',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.phone,
                            color: AppColors.primaryColor3.withOpacity(0.7),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '0349879945',
                            style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 10),
              //   width: screenWidth * 0.85,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //           color: AppColors.primaryColor1.withOpacity(0.2),
              //           spreadRadius: 0.1,
              //           blurRadius: 9,
              //           offset: const Offset(0, 5),
              //         ),
              //       ],
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(
              //           color: Colors.black.withOpacity(0.2), width: 1)),
              // ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColor3,
                      shape: const RoundedRectangleBorder(),
                      value: isCheck,
                      onChanged: (newValue) {
                        setState(() {
                          isCheck = newValue!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                          "Tiếp tục đồng nghĩa chấp nhận Chính sách và\nĐiều khoản của Homestay",
                          style: TextStyle(
                            color: AppColors.grayColor,
                            fontSize: 12,
                          )),
                    )
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 100,
              // ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RoundGradientButton(
        circular: 10,
        width: screenWidth * 0.9,
        title: 'Đặt và Thanh Toán',
        onPressed: () {},
        textSize: 18,
      ),
    );
  }
}
