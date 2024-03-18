import 'package:flutter/material.dart';

import 'will.pop.scope.dart';

void onLoading(context) {
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            // height: double.infinity,
          ),
          // Widget loading
          WillPS(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      "assets/gifs/loading.gif",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
