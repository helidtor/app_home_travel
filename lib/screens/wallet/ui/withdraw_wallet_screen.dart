// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/api/api_wallet.dart';
import 'package:mobile_home_travel/models/bank/bank_model.dart';
import 'package:mobile_home_travel/models/wallet/wallet_model.dart';
import 'package:mobile_home_travel/screens/wallet/ui/wallet_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/input/input_field_price.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';

class WithdrawWalletScreen extends StatefulWidget {
  WalletModel walletModel;
  List<BankModel> listBank;
  WithdrawWalletScreen({
    super.key,
    required this.walletModel,
    required this.listBank,
  });

  @override
  State<WithdrawWalletScreen> createState() => _WithdrawWalletScreenState();
}

class _WithdrawWalletScreenState extends State<WithdrawWalletScreen> {
  bool isHidden = true;
  List<BankModel> listBank = [];
  List<String> listNameBank = [];
  TextEditingController priceController = TextEditingController();
  String? numberBank;
  String? nameBank;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBank = widget.listBank;
    listNameBank = widget.listBank
        .map((e) => '${e.shortName} (${e.code})\n${e.name}')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenHeight = 750;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        title: const Text(
          "Rút tiền về tài khoản ngân hàng",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      const AssetImage("assets/images/wallet_background.jpg"),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Số Dư Ví',
                              style: TextStyle(
                                fontFamily: GoogleFonts.tiltNeon().fontFamily,
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            isHidden
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHidden = !isHidden;
                                        print(isHidden);
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.eyeSlash,
                                      color: Colors.white.withOpacity(0.9),
                                      size: 15,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHidden = !isHidden;
                                        print(isHidden);
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.eye,
                                      color: Colors.white.withOpacity(0.9),
                                      size: 15,
                                    ),
                                  )
                          ],
                        ),
                        Text(
                          isHidden
                              ? ' **********'
                              : '${FormatProvider().formatPrice(widget.walletModel.balance.toString())} VNĐ',
                          style: TextStyle(
                            fontFamily: GoogleFonts.tiltNeon().fontFamily,
                            color: Colors.white,
                            fontSize: isHidden ? 20 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: screenHeight * 0.7,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // InputField(
                  //   controller: priceController,
                  //   heightInput: screenHeight * 0.02,
                  //   widthInput: screenWidth * 0.9,
                  //   hintText: 'Chọn ngân hàng',
                  // ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.076,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                        width: 1.5,
                      ),
                    ),
                    child: CustomDropdown<String>.search(
                        maxlines: 2,
                        overlayHeight: screenHeight * 0.51,
                        decoration: CustomDropdownDecoration(
                          expandedBorderRadius: BorderRadius.circular(10),
                          expandedBorder: Border.all(
                            color: Colors.black.withOpacity(0.1),
                            width: 1.5,
                          ),
                        ),
                        hintText: 'Chọn ngân hàng',
                        items: listNameBank,
                        searchHintText: 'Tìm kiếm',
                        noResultFoundText: 'Không tìm thấy',
                        onChanged: (value) {
                          nameBank = value;
                        }),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.076,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                numberBank = value;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white, // Màu nền
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Colors.black.withOpacity(0.1)),
                              ),
                              labelText: 'Số tài khoản',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor3,
                                      width: 2)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InputField(
                    controller: priceController,
                    heightInput: screenHeight * 0.02,
                    widthInput: screenWidth * 0.9,
                    hintText: 'Số tiền cần rút',
                    textColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    thickness: 10,
                    color: AppColors.backgroundApp,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Các ngân hàng hỗ trợ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const Text(
                          'Dưới đây là danh sách ngân hàng hỗ trợ rút tiền về thẻ',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                listBank.length,
                                (index) => Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    child: Image.network(
                                      listBank[index].logo!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 10,
                    color: AppColors.backgroundApp,
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  RoundGradientButton(
                    textSize: 18,
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.07,
                    title: 'Rút tiền',
                    onPressed: () async {
                      print(
                          'số tiền rút là: ${double.parse(FormatProvider().formatString(priceController.text))}');
                      if (nameBank != null &&
                          numberBank != null &&
                          priceController.text.isNotEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                'Lưu ý',
                                style: TextStyle(
                                  color: AppColors.primaryColor3,
                                  fontSize: 20,
                                ),
                              ),
                              content: const Text(
                                'Bạn có chắc muốn rút tiền\nvề tài khoản này?',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: TextButton(
                                    onPressed: () async {
                                      var result =
                                          await ApiWallet.withdrawWallet(
                                        idWallet: widget.walletModel.id!,
                                        amount: double.parse(FormatProvider()
                                            .formatString(
                                                priceController.text)),
                                        bankName: nameBank!,
                                        bankNumber: numberBank!,
                                      );
                                      if (result == 'Gửi yêu cầu thành công') {
                                        SuccessNotiProvider().ToastSuccess(
                                            context, 'Rút tiền thành công');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WalletScreen(),
                                          ),
                                        );
                                      } else {
                                        ErrorNotiProvider()
                                            .ToastError(context, result!);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WalletScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Có',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor3,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                                //xóa chat
                                CupertinoDialogAction(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Không',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor3,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ErrorNotiProvider().ToastError(
                            context, 'Vui lòng nhập đủ các trường!');
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
