import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/models/booking/wishlist_model.dart';
import 'package:mobile_home_travel/screens/homestay/homestay_detail/ui/homestay_detail.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RowWishlist extends StatefulWidget {
  WishlistModel wishlistModel;
  RowWishlist({
    super.key,
    required this.wishlistModel,
  });

  @override
  State<RowWishlist> createState() => _ResultState();
}

class _ResultState extends State<RowWishlist> {
  late WishlistModel wishlistModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishlistModel = widget.wishlistModel;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        SharedPreferencesUtil.setIdHomestay(wishlistModel.homeStayId!);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeStayDetail(
                    isFromHome: false,
                  )),
        );
      },
      child: Container(
        height: 130,
        width: screenSize.width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(253, 255, 255, 255),
            ),
            color: const Color.fromARGB(253, 255, 255, 255),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 120,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(253, 255, 255, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (wishlistModel.homeStay!.images!.isEmpty)
                        ? const AssetImage("assets/images/homestay_default.jpg")
                        : Image.network(
                                wishlistModel.homeStay!.images!.first.url!)
                            .image,
                    // image: AssetImage("assets/images/homestay_default.jpg"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${wishlistModel.homeStay!.name}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${FormatProvider().formatNumber((wishlistModel.homeStay!.acreage != null) ? wishlistModel.homeStay!.acreage.toString() : '0')}m\u00b2',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      // SizedBox(
                      //   width: screenSize.width * 0.2,
                      // ),
                      Text(
                        // '${wishlistModel.services?.first.serviceName}',
                        (wishlistModel.homeStay!.totalCapacity != null)
                            ? ' - ${wishlistModel.homeStay!.totalCapacity} người'
                            : '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                        color: AppColors.primaryColor3,
                      ),
                      Text(
                        '${wishlistModel.homeStay!.city}',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 15,
                        color: AppColors.primaryColor3,
                      ),
                      const Text('Ngày thêm: ',
                          style: TextStyle(fontSize: 13, color: Colors.black)),
                      Text(
                        FormatProvider()
                            .convertDate(wishlistModel.createdDate.toString()),
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
