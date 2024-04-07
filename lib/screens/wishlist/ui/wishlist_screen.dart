import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/models/booking/wishlist_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/screens/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:mobile_home_travel/screens/wishlist/bloc/wishlist_event.dart';
import 'package:mobile_home_travel/screens/wishlist/bloc/wishlist_state.dart';
import 'package:mobile_home_travel/screens/wishlist/ui/row_wishlist.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<WishlistModel> listWishlist = [];
  String displayScreen = 'assets/images/empty_search.png';
  double widthDisplay = 350;
  double heightDisplay = 350;
  final _bloc = WishlistBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetListWishlist());
  }

  @override
  Widget build(BuildContext context) {
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
          // centerTitle: true,
          title: Text(
            "Danh sách homestay yêu thích",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(182, 0, 0, 0),
                fontSize: 20,
                fontFamily: GoogleFonts.nunito().fontFamily),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is WishlistLoading) {
              setState(() {
                widthDisplay = 50;
                heightDisplay = 50;
                displayScreen = 'assets/gifs/loading.gif';
              });
            } else if (state is GetWishlistSuccess) {
              listWishlist = state.listWishlist;
            } else if (state is WishlistEmpty) {
              setState(() {
                widthDisplay = 350;
                heightDisplay = 350;
                displayScreen = 'assets/images/empty_search.png';
              });
            } else if (state is WishlistError) {
              setState(() {
                widthDisplay = 350;
                heightDisplay = 350;
                displayScreen = 'assets/images/error_loading.png';
              });
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
            return listWishlist.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Column(
                            children: List.generate(
                              listWishlist.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: RowWishlist(
                                    wishlistModel: listWishlist[index]),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox(
                      width: widthDisplay,
                      height: heightDisplay,
                      child: Image.asset(
                        displayScreen,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
