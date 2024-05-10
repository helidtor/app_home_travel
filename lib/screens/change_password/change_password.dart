import 'package:flutter/material.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/constant/myToken.dart';
import 'package:mobile_home_travel/main.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/check_password_valid/check_password_valid.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final reNewPasswordController = TextEditingController();
  String? oldPassword;
  String? newPassword;
  String? reNewPassword;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigatorBar(
                  stt: 4,
                ),
              ),
            );
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        // centerTitle: true,
        title: const Text(
          "Đổi mật khẩu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(182, 0, 0, 0),
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black.withOpacity(0),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          oldPassword = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white, // Màu nền
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.black38),
                        ),
                        labelText: '    Nhập mật khẩu hiện tại...',
                        hintText: 'Nhập mật khẩu hiện tại...',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefix: const SizedBox(
                          width: 20,
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: AppColors.primaryColor3, width: 2)),
                      ),
                      controller: oldPasswordController,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          newPassword = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white, // Màu nền
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.black38),
                        ),
                        labelText: '    Nhập mật khẩu mới...',
                        hintText: 'Nhập mật khẩu mới...',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefix: const SizedBox(
                          width: 20,
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: AppColors.primaryColor3, width: 2)),
                      ),
                      controller: newPasswordController,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          reNewPassword = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white, // Màu nền
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.black38),
                        ),
                        labelText: '    Nhập lại mật khẩu mới...',
                        hintText: 'Nhập lại mật khẩu mới...',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefix: const SizedBox(
                          width: 20,
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: AppColors.primaryColor3, width: 2)),
                      ),
                      controller: reNewPasswordController,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            RoundGradientButton(
              title: 'Đổi mật khẩu',
              width: screenSize.width * 0.9,
              onPressed: () async {
                print('new $oldPassword $newPassword');
                if (newPassword == null ||
                    reNewPassword == null ||
                    oldPassword == null) {
                  //check không đc để trống
                  ErrorNotiProvider()
                      .ToastError(context, 'Vui lòng điền đủ các trường!');
                } else {
                  if (newPassword == reNewPassword) {
                    //check nếu mật khẩu mới không trùng khớp
                    if (CheckPasswordValid().isPasswordValid(newPassword!) ==
                            true &&
                        CheckPasswordValid().isPasswordValid(reNewPassword!) ==
                            true) {
                      //check format đúng hay không
                      var result = await ApiUser.changePassword(
                          oldPassword: oldPassword!, newPassword: newPassword!);
                      if (result == 200) {
                        await clearToken();
                        SuccessNotiProvider().ToastSuccess(context,
                            'Đổi mật khẩu thành công! Vui lòng đăng nhập lại!');
                      } else if (result == 400) {
                        ErrorNotiProvider().ToastError(
                            context, 'Mật khẩu cũ không chính xác!');
                      } else {
                        ErrorNotiProvider().ToastError(context,
                            'Đổi mật khẩu thất bại! Vui lòng thử lại sau!');
                      }
                    } else {
                      ErrorNotiProvider().ToastError(context,
                          'Mật khẩu mới phải chứa ít nhất 8 ký tự & chữ hoa & chữ thường!');
                    }
                  } else {
                    ErrorNotiProvider()
                        .ToastError(context, 'Mật khẩu mới không trùng khớp!');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

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
}
