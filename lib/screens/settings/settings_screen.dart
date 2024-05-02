import 'package:flutter/material.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/main.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/login/ui/login_screen.dart';
import 'package:mobile_home_travel/screens/notifications/ui/notification_screen.dart';
import 'package:mobile_home_travel/screens/profile/ui/profile_screen.dart';
import 'package:mobile_home_travel/screens/wallet/ui/wallet_screen.dart';
import 'package:mobile_home_travel/screens/wishlist/ui/wishlist_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';
import 'package:mobile_home_travel/widgets/others/row_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearToken() async {
  var isUnSubcribe = await ApiUser.unsubcribeNotification();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (isUnSubcribe == false) {
    print('Chưa unsubcribe noti');
  }
  prefs.remove(myToken);
  prefs.remove("idUserCurrent");
  navigatorKey.currentState?.pushNamed('/login');
}

Future<UserProfileModel?> getUser() async {
  var userLogined = await ApiUser.getProfile();
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
        automaticallyImplyLeading: false,
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
                          bottom: 15, left: 40, top: 15, right: 15),
                      child: Container(
                        // ảnh ava
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(253, 255, 255, 255),
                          borderRadius: BorderRadius.circular(500),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (user?.avatar != null)
                                ? Image.network(user!.avatar!).image
                                : const AssetImage(
                                    "assets/gifs/loading_ava.gif"),
                          ),
                        ),
                      ),
                    ),
                    (user?.firstName != null &&
                            user?.lastName != null &&
                            user?.email != null)
                        ? SizedBox(
                            width: screenSize.width * 0.52,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user!.firstName} ${user!.lastName}',
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Color.fromARGB(205, 0, 0, 0),
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${user!.email}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(95, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 40,
                            child: Image.asset(
                              'assets/gifs/loading_text.gif',
                              fit: BoxFit.cover,
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
                      textHeader: "Ví của tôi",
                      textDescribe: "Quản lý ví của bạn",
                      icon: Icons.local_atm_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalletScreen()),
                        );
                      },
                      iconLast: Icons.keyboard_arrow_right,
                    ),
                    // RowSetting(
                    //   weightLine: 1,
                    //   textHeader: "Cài đặt",
                    //   textDescribe: "Tùy chỉnh ứng dụng",
                    //   icon: Icons.settings,
                    //   onPressed: () {
                    //     router.go(RouteName.profile);
                    //   },
                    //   iconLast: Icons.keyboard_arrow_right,
                    // ),
                    RowSetting(
                      weightLine: 1,
                      textDescribe: "Xem những homestay bạn đã thích",
                      textHeader: "Homestay yêu thích",
                      icon: Icons.save_outlined,
                      iconLast: Icons.keyboard_arrow_right,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WishlistScreen()),
                        );
                      },
                    ),
                    RowSetting(
                      weightLine: 1,
                      textHeader: "Thông báo",
                      textDescribe: "Xem tất cả thông báo",
                      icon: Icons.notifications_active_outlined,
                      iconLast: Icons.keyboard_arrow_right,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationScreen()),
                        );
                      },
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const LoginScreen()),
                        // );
                        SuccessNotiProvider()
                            .ToastSuccess(context, 'Đăng xuất thành công!');
                      },
                      weightLine: 0,
                      textHeader: "Đăng xuất",
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
