import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:intl/intl.dart';
import 'package:vaccination_center/home_page.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ReviewSheet extends StatelessWidget {
  String username;
  String review;
  String date;
  String centerId;
  String rating;

  final TextEditingController usernameController = TextEditingController();

  ReviewSheet(
      {Key? key,
      this.username = "username",
      this.review = "review",
      this.date = "date",
      required this.centerId,
      this.rating = "0.0"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: (20.0), left: (20.0), right: (20.0)),
            child: SizedBox(height: 0.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                hintText: "Enter your Name",
                //suffixIcon:
              ),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            "Rate the Center Service",
            style: TextStyle(fontSize: 15.0),
          ),
          const SizedBox(
            height: 10,
          ),
          RatingBar.builder(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (val) {
              rating = val.toString();
              print(rating);
            },
          ),
          const SizedBox(
            height: 40.0,
            child: Divider(
              color: Colors.black,
              indent: 30.0,
              endIndent: 30.0,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: (20.0)),
              child: TextField(
                onChanged: (rev) {
                  review = rev;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write your review here'),
              ),
            ),
          ),
          SizedBox(
            height: (40.0),
            width: (240.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                var dt = DateTime.now();
                var newFormat = DateFormat("dd-MM-yyyy");
                date = newFormat.format(dt);
                http.Response response = await http.post(
                    Uri.parse("${FlutterConfig.get('SERVER_URL')}review"),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode({
                      'center_id': centerId,
                      'username': usernameController.text.trim(),
                      'review': review,
                      'rating': rating,
                      'date': date,
                    }));
                print(response.statusCode);
                if (response.statusCode == 200) {
                  Alert(
                    context: context,
                    type: AlertType.success,
                    title: "Success",
                    desc: "Review Submitted Successfully!",
                    buttons: [
                      DialogButton(
                        color: Colors.green,
                        child: const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else {
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Error",
                    desc: "Error occurred while submitting review!",
                    buttons: [
                      DialogButton(
                        color: Colors.red,
                        child: const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                }
              },
              child: const Text(
                "Done",
                style: TextStyle(color: Colors.white, fontSize: (18.0)),
              ),
            ),
          ),
          const SizedBox(
            height: (40.0),
          )
        ],
      ),
    );
    //   Container(
    //     child: Column(
    // mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Expanded(
    //           flex: 2,
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(
    //                 horizontal: 24.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: <Widget>[
    //                 const SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 const Text(
    //                   "Rate the Center Service",
    //                   textAlign: TextAlign.center,
    //                   style:
    //                   TextStyle(fontSize: 15.0),
    //                 ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             Center(
    //               child: RatingBar.builder(
    //                 initialRating: 1,
    //                 minRating: 1,
    //                 direction: Axis.horizontal,
    //                 allowHalfRating: true,
    //                 itemCount: 5,
    //                 itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
    //                 itemBuilder: (context, _) => const Icon(
    //                   Icons.star,
    //                   color: Colors.amber,
    //                 ),
    //                 onRatingUpdate: (val) {
    //                   rating = val as String;
    //                 },
    //               ),
    //             ),
    //                 const SizedBox(
    //                   height: 60.0,
    //                 ),
    //                 TextFormField(
    //                   controller: usernameController,
    //                   decoration: const InputDecoration(
    //                     labelStyle: TextStyle(color: Colors.black),
    //                     hintText: "Enter your Name",
    //                     labelText: "Name",
    //                     floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     //suffixIcon:
    //                     focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(
    //                             Radius.circular(10.0)),
    //                         borderSide:
    //                         BorderSide(width: 1, color: Colors.black)),
    //                     border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(
    //                             Radius.circular(10.0)),
    //                         borderSide:
    //                         BorderSide(width: 1, color: Colors.black)),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 40,
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     indent: 40.0,
    //                     endIndent: 40.0,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: 20.0),
    //                   child: TextField(
    //                     onChanged: (rev) {
    //                       review = rev;
    //                     },
    //                     keyboardType: TextInputType.multiline,
    //                     maxLines: null,
    //                     decoration: const InputDecoration(
    //                         border: InputBorder.none, hintText: 'Write here'),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: (){
    //
    //           },
    //           child: Text("ABC"),
    //         )
    //       ],
    //     ),
    //   ),
  }
}
