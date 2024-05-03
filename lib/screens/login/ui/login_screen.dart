import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/firebase/auth_firebase.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/login/bloc/login_bloc.dart';
import 'package:mobile_home_travel/screens/login/bloc/login_event.dart';
import 'package:mobile_home_travel/screens/login/bloc/login_state.dart';
import 'package:mobile_home_travel/screens/signup/sign_up_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:mobile_home_travel/widgets/notification/toast.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/input/round_text_field.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final bool _validatePhone = false;
  final bool _validatePassword = false;
  bool checkLogin = false;
  final _bloc = LoginBloc();
  bool isShowPassword = true;

  @override
  void initState() {
    super.initState();
    _bloc.add(CheckLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocConsumer<LoginBloc, LoginState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is LoginLoading) {
              onLoading(context);
              return;
            } else if (state is LoginSecondState) {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavigatorBar()),
              );
            } else if (state is LoginFirstState) {
              //chưa login
              Navigator.pop(context);
              checkLogin = true;
            } else if (state is LoginSuccessState) {
              //login thành công
              // Navigator.pop(context);
              //update current user logined
              // context
              //     .read<AuthenticationRepository>()
              //     .updateUser(state.userProfileModel);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavigatorBar()),
              );
              toastification.show(
                  showProgressBar: false,
                  pauseOnHover: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.green,
                  ),
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.flatColored,
                  title: const TextContent(
                    contentText: "Đăng nhập thành công!",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  description: TextContent(
                    contentText:
                        "Chào mừng ${state.userProfileModel.firstName} ${state.userProfileModel.lastName}",
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            } else if (state is LoginFailure) {
              toastification.show(
                  showProgressBar: false,
                  pauseOnHover: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.red,
                  ),
                  icon: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flatColored,
                  title: TextContent(
                    contentText: state.error,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 2500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topCenter);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(253, 255, 255, 255),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage("assets/images/logo-new.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      RoundTextField(
                        hintText: "Số điện thoại",
                        icon: "assets/icons/message_icon.png",
                        textEditingController: phoneController,
                        textInputType: TextInputType.phone,
                        errorText: _validatePhone
                            ? 'Vui lòng nhập số điện thoại!'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      RoundTextField(
                        hintText: "Mật khẩu",
                        icon: "assets/icons/lock_icon.png",
                        textInputType: TextInputType.text,
                        isObscureText: isShowPassword,
                        textEditingController: passwordController,
                        errorText: _validatePassword
                            ? 'Vui lòng nhập mật khẩu!'
                            : null,
                        rightIcon: TextButton(
                            onPressed: () {
                              setState(() {
                                isShowPassword = !isShowPassword;
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  "assets/icons/hide_pwd_icon.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  color: AppColors.grayColor,
                                ))),
                      ),
                      const SizedBox(height: 15),
                      const Text("Quên mật khẩu?",
                          style: TextStyle(
                            color: AppColors.grayColor,
                            fontSize: 14,
                          )),
                      SizedBox(height: media.height * 0.05),
                      RoundGradientButton(
                        title: "Đăng nhập",
                        onPressed: () {
                          String username = phoneController.text;
                          String password = passwordController.text;
                          _bloc.add(StartLoginEvent(
                              username: username, password: password));
                        },
                      ),
                      // const SizedBox(height: 15),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //         child: Container(
                      //       width: double.maxFinite,
                      //       height: 1,
                      //       color: AppColors.grayColor.withOpacity(0.5),
                      //     )),
                      //     const Text("  hoặc  ",
                      //         style: TextStyle(
                      //             color: AppColors.grayColor,
                      //             fontSize: 14,
                      //             fontStyle: FontStyle.italic,
                      //             fontWeight: FontWeight.w400)),
                      //     Expanded(
                      //         child: Container(
                      //       width: double.maxFinite,
                      //       height: 1,
                      //       color: AppColors.grayColor.withOpacity(0.5),
                      //     )),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 26.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {
                      //           signInWithGoogle();
                      //         },
                      //         child: Container(
                      //           width: 50,
                      //           height: 50,
                      //           alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(14),
                      //             border: Border.all(
                      //               color: AppColors.primaryColor1
                      //                   .withOpacity(0.5),
                      //               width: 1,
                      //             ),
                      //           ),
                      //           child: Image.asset(
                      //             "assets/icons/google_icon.png",
                      //             width: 20,
                      //             height: 20,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 30,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            );
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                    text: "Chưa có tài khoản? ",
                                  ),
                                  TextSpan(
                                      text: "Đăng ký ngay",
                                      style: TextStyle(
                                          color: AppColors.primaryColor1,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ]),
                          )),
                    ],
                  ),
                ),
              ),
            );
            // : SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //           color: Colors.white,
            //           margin: const EdgeInsets.only(top: 100, bottom: 50),
            //           height: 100,
            //           // child: Image.asset(
            //           //   "assets/images/loading.gif",
            //           //   fit: BoxFit.cover,
            //           // ),
            //         ),
            //       ],
            //     ),
            //   );
          }),
    );
  }
}
