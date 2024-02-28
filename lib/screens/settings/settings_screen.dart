import 'package:flutter/material.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/others/row_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(myToken, "token");
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cài đặt",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.centerLeft,
        //       end: Alignment.centerRight,
        //       colors: <Color>[
        //         Color.fromARGB(255, 111, 77, 202),
        //         Color.fromARGB(235, 124, 70, 191),
        //         Color.fromARGB(255, 168, 50, 165),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(0, 158, 158, 158)
                          .withOpacity(0.4),
                      spreadRadius: 0.01,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 40, top: 15, right: 20),
                      child: Container(
                        // ảnh ava
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(253, 255, 255, 255),
                          borderRadius: BorderRadius.circular(500),
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            // image: (inforUpdate.avatarUrl != null)
                            //     ? Image.network(inforUpdate.avatarUrl!).image
                            //     : const AssetImage(
                            //         "assets/images/ava_default.png"),
                            image: AssetImage("assets/images/meo.jpg"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Trường Ngô',
                            style: TextStyle(
                              color: Color.fromARGB(205, 0, 0, 0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '\ntourist@gmail.com',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(132, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4), // Màu của đổ bóng
                      spreadRadius: 0.01, // Khoảng cách lan rộng của đổ bóng
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    RowSetting(
                      weightLine: 0,
                      textDescribe: "Xem chi tiết hồ sơ cá nhân",
                      textHeader: "Hồ sơ",
                      icon: Icons.person,
                    ),
                    RowSetting(
                      weightLine: 1,
                      textDescribe: "Cho chúng tôi biết cảm nghĩ của bạn",
                      textHeader: "Gửi phản hồi",
                      icon: Icons.mail,
                    ),
                    RowSetting(
                      weightLine: 1,
                      textHeader: "Chính sách",
                      textDescribe: "Xem thêm chính sách",
                      icon: Icons.format_align_center_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // const Text(
              //   'Tài khoản',
              //   style: TextStyle(
              //     fontSize: 25,
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4), // Màu của đổ bóng
                      spreadRadius: 0.01, // Khoảng cách lan rộng của đổ bóng
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    RowSetting(
                      weightLine: 0,
                      textHeader: "Đổi mật khẩu",
                      icon: Icons.password,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4), // Màu của đổ bóng
                      spreadRadius: 0.01, // Khoảng cách lan rộng của đổ bóng
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RowSetting(
                      onPressed: () {
                        clearToken();
                        router.go(RouteName.login);
                      },
                      weightLine: 0,
                      textHeader: "Đăng xuất",
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ),
              // const Text(
              //   'Profile',
              //   style: TextStyle(
              //     color: Colors.blue,
              //     decoration: TextDecoration.underline,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // InkWell(
              //   onTap: () {
              //     clearToken();
              //     router.go(RouteName.login);
              //   },
              //   child: const Text(
              //     'Logout',
              //     style: TextStyle(
              //       color: Colors.blue,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
