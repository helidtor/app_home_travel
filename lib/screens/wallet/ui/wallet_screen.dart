import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/screens/transaction/transaction_row.dart';
import 'package:mobile_home_travel/screens/wallet/ui/withdraw_wallet_screen.dart';
import 'package:mobile_home_travel/screens/web_view/web_view.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/wallet/wallet_model.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_bloc.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_event.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_state.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:mobile_home_travel/widgets/input/input_field_price.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';
import 'package:mobile_home_travel/screens/wallet/ui/preset_price_wallet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String? imageDisplay;
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
        actions: [
          IconButton(
            onPressed: () {
              _bloc.add(GetListBank());
            },
            icon: const Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Colors.black,
              size: 22,
            ),
          )
        ],
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
            if (listTransaction.isEmpty) {
              imageDisplay = 'assets/images/empty_transaction.png';
            }
            isDisplay = true;
          } else if (state is WalletFailure) {
            Navigator.pop(context);
            imageDisplay = 'assets/images/error_loading.png';
            ErrorNotiProvider().showError(context, state.error);
          } else if (state is AddFundWalletSuccess) {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: state.link,
                      )),
            );
            // try {
            //   if (await canLaunchUrlString(state.link)) {
            //     await launchUrlString(state.link,
            //         mode: LaunchMode.inAppBrowserView);
            //   }
            //   // _launchAsInAppWebViewWithCustomHeaders(state.link);
            // } catch (e) {
            //   print(e);
            // }
          } else if (state is WalletFailure) {
            Navigator.pop(context);
            ErrorNotiProvider().showError(context, state.error);
          } else if (state is GetListBankSuccess) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WithdrawWalletScreen(
                        listBank: state.listBank,
                        walletModel: wallet,
                      )),
            );
          } else if (state is GetListBankFailure) {
            Navigator.pop(context);
            ErrorNotiProvider().showError(context, state.msg);
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
                                            fontFamily: GoogleFonts.tiltNeon()
                                                .fontFamily,
                                            color: Colors.white,
                                            fontSize: 20,
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
                                                  color: Colors.white
                                                      .withOpacity(0.9),
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
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                  size: 15,
                                                ),
                                              )
                                      ],
                                    ),
                                    Text(
                                      isHidden
                                          ? ' **********'
                                          : '${FormatProvider().formatPrice(wallet.balance.toString())} VNĐ',
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.tiltNeon().fontFamily,
                                        color: Colors.white,
                                        fontSize: isHidden ? 20 : 20,
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
                                                                FormatProvider()
                                                                    .formatString(
                                                                        priceController
                                                                            .text))));
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Giao dịch gần nhất',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: const Text(
                          //       'Xem tất cả',
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //         fontStyle: FontStyle.italic,
                          //         fontWeight: FontWeight.bold,
                          //         color: AppColors.primaryColor3,
                          //       ),
                          //     )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: screenHeight * 0.47,
                      width: screenWidth,
                      child: (listTransaction.isNotEmpty)
                          ? SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  // 5,
                                  listTransaction.length,
                                  (index) => TransactionRow(
                                      transactionModel: listTransaction[index]),
                                ),
                              ),
                            )
                          : Center(
                              child: (imageDisplay != null)
                                  ? SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image.asset(
                                        imageDisplay!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
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
