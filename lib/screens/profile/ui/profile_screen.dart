import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_home_travel/api/api_user.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/screens/profile/bloc/profile_bloc.dart';
import 'package:mobile_home_travel/screens/profile/bloc/profile_event.dart';
import 'package:mobile_home_travel/screens/profile/bloc/profile_state.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/input/field_profile.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? selectedImage;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _bloc = ProfileBloc();
  bool isShow = false;
  UserProfileModel? inforUpdate;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                        )),
              );
            },
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          centerTitle: true,
          title: const Text(
            "Chi Tiết Tài Khoản",
            style: TextStyle(
                color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is ProfileStateLoading) {
                onLoading(context);
                return;
              } else if (state is ProfileStateSuccess) {
                Navigator.pop(context);
                inforUpdate = state.userProfileModel;
                isShow = true;
              } else if (state is UpdateProfileSuccess) {
                Navigator.pop(context);
                toastification.show(
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
                    style: ToastificationStyle.minimal,
                    title: const TextContent(
                      contentText: "Cập nhật thành công!",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    autoCloseDuration: const Duration(milliseconds: 1500),
                    animationDuration: const Duration(milliseconds: 500),
                    alignment: Alignment.topRight);
              } else if (state is ProfileStateFailure) {
                Navigator.pop(context);
                toastification.show(
                    pauseOnHover: false,
                    showProgressBar: false,
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
              }
            },
            builder: (context, state) {
              return isShow
                  ? SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  pickImage();
                                },
                                child: Container(
                                  // ảnh ava
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        253, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(500),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            194, 172, 146, 243),
                                        width: 4),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: (inforUpdate?.avatar != null)
                                          ? Image.network(inforUpdate!.avatar!)
                                              .image
                                          : const AssetImage(
                                              "assets/gifs/loading_ava.gif"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              FieldProfile(
                                icon: Icons.phone,
                                label: 'SĐT',
                                controller: phoneController,
                                widthInput: 0.8,
                                readOnly: false,
                                content: inforUpdate?.phoneNumber ?? "...",
                                onChangeText: (value) {
                                  setState(() {
                                    inforUpdate?.phoneNumber = value;
                                  });
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FieldProfile(
                                    icon: Icons.person,
                                    label: 'Họ',
                                    controller: firstNameController,
                                    widthInput: 0.38,
                                    readOnly: false,
                                    content: inforUpdate?.firstName ?? "...",
                                    onChangeText: (value) {
                                      setState(() {
                                        inforUpdate?.firstName = value;
                                      });
                                    },
                                  ),
                                  FieldProfile(
                                    icon: Icons.person,
                                    label: 'Tên',
                                    controller: lastNameController,
                                    widthInput: 0.38,
                                    readOnly: false,
                                    content: inforUpdate?.lastName ?? "...",
                                    onChangeText: (value) {
                                      setState(() {
                                        inforUpdate?.lastName = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              FieldProfile(
                                icon: Icons.email,
                                label: 'Email',
                                widthInput: 0.8,
                                readOnly: true,
                                content: inforUpdate?.email ?? "...",
                              ),
                              RoundGradientButton(
                                width: screenWidth * 0.8,
                                title: "Lưu",
                                onPressed: () {
                                  _bloc.add(UpdateProfileEvent(
                                      id: inforUpdate!.id!,
                                      userProfileModel: inforUpdate!));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 100, bottom: 50),
                            height: 100,
                            // child: Image.asset(
                            //   "assets/images/loading-71.gif",
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ],
                      ),
                    );
            }));
  }

// Hàm xử lý khi chọn ảnh
  void handleImageSelection() async {
    if (selectedImage != null) {
      var result = await ApiUser.uploadImage(
        selectedImage!,
        selectedImage!.path,
      );
      if (result != null) {
        inforUpdate?.avatar = result;
        _bloc.add(UpdateProfileEvent(
            id: inforUpdate!.id!, userProfileModel: inforUpdate!));
      }
    }
  }

  Future pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
      handleImageSelection();
    });
  }
}
