import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  DateTime? _selectedDate;
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
                ),
                const SizedBox(
                  height: 5,
                ),

                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
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
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        width: screenSize.width * 0.44,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrayColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                FontAwesomeIcons.calendar,
                                size: 20,
                                color: AppColors.grayColor.withOpacity(0.6),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              _selectedDate == null
                                  ? const Text(
                                      'Ngày sinh',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grayColor,
                                      ),
                                    )
                                  : Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(_selectedDate!),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                            ],
                          ),
                        ),
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
                    if (_selectedDate == null) {
                      ErrorNotiProvider()
                          .ToastError(context, 'Bạn chưa chọn ngày sinh!');
                    } else {
                      if (_selectedDate!.isAfter(DateTime.now()
                          .subtract(const Duration(days: 6570)))) {
                        ErrorNotiProvider()
                            .showError(context, 'Người dùng chưa đủ 18 tuổi!');
                        return;
                      } else {
                        userSignUpModel.dateOfBirth = DateFormat('yyyy-MM-dd')
                            .format(_selectedDate!)
                            .toString();
                      }
                    }
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
                            .ToastSuccess(context, 'Đăng ký thành công');
                        router.go(RouteName.login);
                      } else {
                        print("Đăng ký không thành công: $checkSignUp");
                        ErrorNotiProvider().showError(
                            context, 'Vui lòng nhập đủ các trường dữ liệu!');
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1925),
      lastDate: DateTime.now(),
      confirmText: 'Xác nhận',
      cancelText: 'Hủy',
      helpText: 'Chọn ngày sinh',
      fieldLabelText: 'Nhập ngày sinh',
      fieldHintText: 'tháng/ngày/năm',
      errorFormatText: 'Định dạng sai',
      errorInvalidText: 'Không hợp lệ',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor1),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
