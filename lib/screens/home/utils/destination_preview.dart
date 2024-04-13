// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_home_travel/screens/result_search/ui/result_search_screen.dart';

class DestinationPreview extends StatefulWidget {
  String image;
  String name;
  DestinationPreview({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  State<DestinationPreview> createState() => _DestinationPreviewState();
}

class _DestinationPreviewState extends State<DestinationPreview> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultSearchScreen(
                    stringLocation: widget.name,
                    capacity: '1',
                  )),
        );
      },
      child: Container(
        width: 150,
        height: 140,
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
          ],
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(253, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(widget.image),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
