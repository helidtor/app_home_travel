import 'package:flutter/material.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/firebase/auth_firebase.dart';
import 'package:mobile_home_travel/models/user/sign_up_user_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/input/round_text_field.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isCheck = false;
  String? dropdownValue;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final genderController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateRePassword = false;
  bool _validateGender = false;
  bool _validateDateOfBirth = false;
  UserSignUpModel userSignUpModel = UserSignUpModel();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Tạo tài khoản",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.44,
                      child: RoundTextField(
                        hintText: "Họ",
                        icon: "assets/icons/profile_icon.png",
                        textEditingController: firstNameController,
                        textInputType: TextInputType.name,
                        onChangeText: (value) {
                          setState(() {
                            userSignUpModel.firstName = value;
                          });
                        },
                        errorText:
                            _validateFirstName ? 'Vui lòng nhập họ!' : null,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.44,
                      child: RoundTextField(
                        hintText: "Tên",
                        icon: "assets/icons/profile_icon.png",
                        textEditingController: lastNameController,
                        textInputType: TextInputType.name,
                        onChangeText: (value) {
                          setState(() {
                            userSignUpModel.lastName = value;
                          });
                        },
                        errorText:
                            _validateLastName ? 'Vui lòng nhập tên!' : null,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),
                RoundTextField(
                  hintText: "Email",
                  icon: "assets/icons/message_icon.png",
                  textEditingController: emailController,
                  textInputType: TextInputType.emailAddress,
                  onChangeText: (value) {
                    setState(() {
                      userSignUpModel.email = value;
                    });
                  },
                  errorText: _validateEmail ? 'Vui lòng nhập email!' : null,
                ),
                const SizedBox(
                  height: 5,
                ),
                RoundTextField(
                  hintText: "Số điện thoại",
                  icon: "assets/icons/message_icon.png",
                  textEditingController: phoneNumberController,
                  textInputType: TextInputType.phone,
                  onChangeText: (value) {
                    setState(() {
                      userSignUpModel.phoneNumber = value;
                    });
                  },
                  errorText:
                      _validateEmail ? 'Vui lòng nhập số điện thoại!' : null,
                ),
                const SizedBox(
                  height: 5,
                ),

                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    // SizedBox(
                    //   width: screenSize.width * 0.44,
                    //   child: RoundTextField(
                    //     hintText: "Giới tính",
                    //     icon: "assets/icons/message_icon.png",
                    //     textEditingController: genderController,
                    //     textInputType: TextInputType.name,
                    //     onChangeText: (value) {
                    //       setState(() {
                    //         userSignUpModel.gender = value;
                    //       });
                    //     },
                    //     errorText:
                    //         _validateGender ? 'Vui lòng chọn giới tính!' : null,
                    //   ),
                    // ),
                    SizedBox(
                      width: screenSize.width * 0.44,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightGrayColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Giới tính',
                            hintStyle: const TextStyle(
                                fontSize: 12, color: AppColors.grayColor),
                            prefixIcon: Container(
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                'assets/icons/profile_icon.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                color: AppColors.grayColor,
                              ),
                            ),
                          ),
                          items: <String>['Nam', 'Nữ']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              if (dropdownValue == 'Nam') {
                                userSignUpModel.gender = true;
                              } else if (dropdownValue == 'Nữ') {
                                userSignUpModel.gender = false;
                              }
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.44,
                      child: RoundTextField(
                        hintText: "Ngày sinh",
                        icon: "assets/icons/message_icon.png",
                        textEditingController: dateOfBirthController,
                        textInputType: TextInputType.datetime,
                        onChangeText: (value) {
                          setState(() {
                            userSignUpModel.dateOfBirth =
                                FormatProvider().convertDateOfBirth(value);
                          });
                        },
                        errorText: _validateDateOfBirth
                            ? 'Vui lòng chọn ngày sinh!'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // * Mật khẩu
                RoundTextField(
                  hintText: "Mật khẩu",
                  icon: "assets/icons/lock_icon.png",
                  textEditingController: passwordController,
                  textInputType: TextInputType.text,
                  isObscureText: true,
                  onChangeText: (value) {
                    setState(() {
                      userSignUpModel.password = value;
                    });
                  },
                  errorText:
                      _validatePassword ? 'Vui lòng nhập mật khẩu!' : null,
                  rightIcon: TextButton(
                      onPressed: () {},
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
                const SizedBox(
                  height: 5,
                ),
                RoundTextField(
                  hintText: "Xác nhận mật khẩu",
                  icon: "assets/icons/lock_icon.png",
                  textEditingController: rePasswordController,
                  textInputType: TextInputType.text,
                  errorText: _validateRePassword
                      ? 'Vui lòng nhập lại mật khẩu!'
                      : null,
                  isObscureText: true,
                  onChangeText: (value) {
                    setState(() {
                      // userSignUpModel.confirmPassword = value;
                    });
                  },
                  rightIcon: TextButton(
                      onPressed: () {},
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        },
                        icon: Icon(
                          isCheck
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank_outlined,
                          color: AppColors.grayColor,
                        )),
                    const Expanded(
                      child: Text(
                          "Tiếp tục đồng nghĩa chấp nhận Chính sách và\nĐiều khoản",
                          style: TextStyle(
                            color: AppColors.grayColor,
                            fontSize: 12,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundGradientButton(
                  title: "Đăng ký",
                  onPressed: () async {
                    userSignUpModel.email = emailController.text;
                    userSignUpModel.phoneNumber = phoneNumberController.text;
                    userSignUpModel.password = passwordController.text;
                    userSignUpModel.lastName = lastNameController.text;
                    userSignUpModel.firstName = firstNameController.text;
                    print(userSignUpModel);
                    try {
                      var checkSignUp = await ApiUser.signup(
                          userSignUpModel: userSignUpModel);
                      if (checkSignUp == true) {
                        SuccessNotiProvider()
                            .showSuccess(context, 'Đăng ký thành công');
                        router.go(RouteName.login);
                      } else {
                        print("Đăng ký không thành công: $checkSignUp");
                        ErrorNotiProvider()
                            .showError(context, 'Đăng ký thất bại');
                      }
                    } catch (e) {
                      print("Đăng ký không thành công: $e");
                      ErrorNotiProvider()
                          .showError(context, 'Đăng ký thất bại');
                    }
                    // SignOutGoogle(); test signout google (không liên quan)
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      width: double.maxFinite,
                      height: 1,
                      color: AppColors.grayColor.withOpacity(0.5),
                    )),
                    const Text("  Hoặc  ",
                        style: TextStyle(
                            color: AppColors.grayColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    Expanded(
                        child: Container(
                      width: double.maxFinite,
                      height: 1,
                      color: AppColors.grayColor.withOpacity(0.5),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         height: 50,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(14),
                //           border: Border.all(
                //             color: AppColors.primaryColor1.withOpacity(0.5),
                //             width: 1,
                //           ),
                //         ),
                //         child: Image.asset(
                //           "assets/icons/google_icon.png",
                //           width: 20,
                //           height: 20,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // * Chuyển sang màn hình đăng nhập
                TextButton(
                    onPressed: () {
                      router.go(RouteName.login);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: "Đã có tài khoản? ",
                            ),
                            TextSpan(
                              text: "Đăng nhập ngay",
                              style: TextStyle(
                                  color: AppColors.primaryColor1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ]),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
