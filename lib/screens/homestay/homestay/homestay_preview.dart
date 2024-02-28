// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/models/homestay_model.dart';

class HomestayPreview extends StatefulWidget {
  HomestayModel homestayModel;
  HomestayPreview({
    Key? key,
    required this.homestayModel,
  }) : super(key: key);

  @override
  State<HomestayPreview> createState() => _HomestayState();
}

class _HomestayState extends State<HomestayPreview> {
  late HomestayModel homestayModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homestayModel = widget.homestayModel;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: 350,
      width: 250,
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
      child: Column(children: [
        Container(
          width: 250,
          height: 200,
          decoration: BoxDecoration(
            color: const Color.fromARGB(253, 255, 255, 255),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: (homestayModel.imageHomes!.isEmpty)
                  ? const AssetImage("assets/images/homestay_default.jpg")
                  : Image.network(homestayModel.imageHomes!.first.imageURL!)
                      .image,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${homestayModel.acreage}',
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              // '${homestayModel.services?.first.serviceName}',
              '${homestayModel.location?.cityName}',
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${homestayModel.homeStayName}',
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${homestayModel.location?.cityName}',
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          // '${homestayModel.services?.first.price}',
          '${homestayModel.location?.cityName}',
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
