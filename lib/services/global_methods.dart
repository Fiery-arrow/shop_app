import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> showDialogs(
      BuildContext context, String title, String subTitle, Function fct) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Image.network(
                    "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg",
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(title),
                ),
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  fct();
                  Navigator.pop(ctx);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  Future<void> authErrorHandle(
      BuildContext context, String subTitle) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Image.network(
                    "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg",
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text("Error occurred"),
                ),
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

}
