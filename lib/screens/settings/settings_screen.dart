import 'package:flutter/material.dart';
import 'package:mobile_home_travel/api/api_provider.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/models/profile_user_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/profile/profile_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/others/row_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(myToken, "token");
}

Future<UserProfileModel?> getUser() async {
  var userLogined = await ApiProvider.getProfile();
  return userLogined;
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserProfileModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final profile = await getUser();
    if (mounted) {
      setState(() {
        user = profile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tài khoản",
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
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: (user?.avatar != null)
                                ? Image.network(user!.avatar!).image
                                : const AssetImage(
                                    "assets/gifs/loading_ava.gif"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: (user?.firstName != null &&
                                    user?.lastName != null)
                                ? ('${user!.firstName} ${user!.lastName}')
                                : '...',
                            style: const TextStyle(
                              color: Color.fromARGB(205, 0, 0, 0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: (user?.email != null)
                                ? '\n${user!.email}'
                                : '\n...',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(132, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()),
                        );
                      },
                      icon: const Icon(
                        Icons.mode_edit_outlined,
                        color: AppColors.primaryColor3,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                child: Column(
                  children: [
                    RowSetting(
                      weightLine: 0,
                      textHeader: "Cài đặt",
                      textDescribe: "Tùy chỉnh ứng dụng",
                      icon: Icons.settings,
                      onPressed: () {
                        router.go(RouteName.profile);
                      },
                      iconLast: Icons.keyboard_arrow_right,
                    ),
                    const RowSetting(
                      weightLine: 1,
                      textDescribe: "Cho chúng tôi biết cảm nghĩ của bạn",
                      textHeader: "Gửi phản hồi",
                      icon: Icons.mail,
                      iconLast: Icons.keyboard_arrow_right,
                    ),
                    const RowSetting(
                      weightLine: 1,
                      textHeader: "Chính sách",
                      textDescribe: "Xem thêm chính sách",
                      icon: Icons.format_align_center_rounded,
                      iconLast: Icons.keyboard_arrow_right,
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
