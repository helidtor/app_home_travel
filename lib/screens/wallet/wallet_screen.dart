import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/format/format.dart';
import 'package:mobile_home_travel/models/user/wallet_model.dart';
import 'package:mobile_home_travel/screens/navigator_bar.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_bloc.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_event.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_state.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _bloc = WalletBloc();
  bool isHidden = true;
  bool isDisplay = true;
  late WalletModel wallet;

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
            isDisplay = true;
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
                                horizontal: 25, vertical: 35),
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
                                        _openInputAmount();
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

  void _openInputAmount() {
    TextEditingController controller = TextEditingController();
    AlertDialog(
      title: Text('Nhập số tiền'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Nhập số tiền',
            ),
          ),
          SizedBox(height: 8),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              return [
                '100.000',
                '200.000',
                '300.000',
                '500.000',
                '1.000.000',
                // Thêm các số tiền khác vào đây
              ].where((option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              controller.text = selection;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            // Xử lý khi nhấn nút xác nhận
            Navigator.of(context).pop(controller.text);
          },
          child: Text('Xác nhận'),
        ),
      ],
    );
  }
}
