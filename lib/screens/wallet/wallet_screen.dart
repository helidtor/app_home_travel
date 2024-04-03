import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/screens/wallet/transaction_row.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/models/wallet/wallet_model.dart';
import 'package:mobile_home_travel/screens/navigator_bar.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_bloc.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_event.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_state.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/input/input_field.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:mobile_home_travel/widgets/others/preset_price_wallet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _bloc = WalletBloc();
  bool isHidden = true;
  bool isDisplay = true;
  TextEditingController priceController = TextEditingController();
  late WalletModel wallet;
  List<TransactionModel> listTransaction = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetWallet());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
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
        title: const Text(
          "Thông tin ví",
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is WalletLoading) {
            onLoading(context);
            return;
          } else if (state is WalletSuccess) {
            Navigator.pop(context);
            wallet = state.walletModel;
            listTransaction = state.listTransaction;
            isDisplay = true;
          } else if (state is WalletFailure) {
            Navigator.pop(context);
            showError(context, state.error);
          } else if (state is AddFundWalletSuccess) {
            Navigator.pop(context);
            try {
              // if (await canLaunchUrlString(state.link)) {
              //   await launchUrlString(state.link,
              //       mode: LaunchMode.inAppBrowserView);
              // }
              _launchAsInAppWebViewWithCustomHeaders(state.link);
            } catch (e) {
              print(e);
            }
          } else if (state is WalletFailure) {
            Navigator.pop(context);
            showError(context, state.error);
          }
        },
        builder: (context, state) {
          return isDisplay
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: const AssetImage(
                              "assets/images/wallet_background.jpg"),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Số Dư Ví',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
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
                                                  Icons
                                                      .invert_colors_off_rounded,
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                  size: 20,
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
                                                  Icons.invert_colors,
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                  size: 20,
                                                ),
                                              )
                                      ],
                                    ),
                                    Text(
                                      isHidden
                                          ? ' ************'
                                          : '${FormatProvider().formatPrice(wallet.balance.toString())} VNĐ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isHidden ? 20 : 20,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(500),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        //hiện khung nhập giá
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: screenHeight * 0.64,
                                              width: screenWidth,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Divider(
                                                    indent: 160,
                                                    endIndent: 160,
                                                    thickness: 3,
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    child: InputField(
                                                      controller:
                                                          priceController,
                                                      heightInput:
                                                          screenHeight * 0.03,
                                                      widthInput:
                                                          screenWidth * 0.9,
                                                      hintText:
                                                          'Nhập số tiền cần nạp',
                                                    ),
                                                  ),
                                                  //bảng chọn giá sẵn để nạp
                                                  PresetPriceWallet(
                                                    priceController:
                                                        priceController,
                                                  ),
                                                  const Divider(
                                                    thickness: 10,
                                                    color:
                                                        AppColors.backgroundApp,
                                                  ),
                                                  RoundGradientButton(
                                                      textSize: 18,
                                                      width: screenWidth * 0.85,
                                                      height:
                                                          screenHeight * 0.05,
                                                      title: 'Thanh toán',
                                                      onPressed: () {
                                                        _bloc.add(AddFundWallet(
                                                            amount: double.parse(
                                                                priceController
                                                                    .text)));
                                                      })
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add_card_outlined,
                                        size: 22,
                                        color: AppColors.primaryColor3
                                            .withOpacity(0.9),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Giao dịch gần nhất',
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Xem tất cả',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor3,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.47,
                      width: screenWidth,
                      child: (listTransaction.isNotEmpty)
                          ? Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    // 5,
                                    listTransaction.length,
                                    (index) => TransactionRow(
                                        transactionModel:
                                            listTransaction[index]),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                width: 350,
                                height: 350,
                                child: Image.asset(
                                  'assets/images/error_loading.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    const Spacer(),
                  ],
                )
              : Center(
                  child: SizedBox(
                    width: 350,
                    height: 350,
                    child: Image.asset(
                      'assets/images/error_loading.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
        },
      ),
    ));
  }
}

Future<void> _launchAsInAppWebViewWithCustomHeaders(String url) async {
  if (!await launchUrlString(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw Exception('Could not launch $url');
  }
}
