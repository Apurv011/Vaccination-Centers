import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_config/flutter_config.dart';
import 'package:vaccination_center/review_box.dart';
import 'session_box.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SessionAndReviewPage extends StatefulWidget {
  const SessionAndReviewPage({Key? key}) : super(key: key);

  @override
  _SessionAndReviewPageState createState() => _SessionAndReviewPageState();
}

class _SessionAndReviewPageState extends State<SessionAndReviewPage> {
  static final DateTime today = DateTime.now();
  static final DateTime reqDate = double.parse(DateFormat('HH:mm:ss').format(today).split(":")[0])<=17 ?
                              today :
                              DateTime.now().add(const Duration(days: 1));
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String date = formatter.format(reqDate);

  String centerId = "id";
  String centerName = 'name';
  String pincode = "pincode";
  String feeType = "feetype";
  String magColour = "colour";
  String sessionDate = "sessionDate";
  String time = "time";
  String vaccine = "vaccine";
  String minAge = "minAge";
  String dose1 = "Dose1";
  String dose2 = "Dose2";
  List<Widget> sessions = [];
  bool showSpinner = true;
  bool isData = false;

  @override
  void initState() {
    super.initState();
    getSessionData();
  }

  Future<void> getSessionData() async {
    if (Get.arguments[1] != "reviews") {
      http.Response response = await http.get(Uri.parse(
          "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByCenter?center_id=${Get.arguments[0]}&date=$date"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.length == 0) {
          setState(() {
            sessions.add(const SizedBox(
              height: 80.0,
            ));
            sessions.add(Image.asset(
              "images/no_data.jpg",
            ));
            sessions.add(const SizedBox(
              height: 30.0,
            ));
            sessions.add(const Text(
              "No Data Available!",
              style: TextStyle(fontSize: 20.0),
            ));
          });
        } else {
          setState(() {
            isData = true;
            centerId = data['centers']['center_id'].toString();
            centerName = data['centers']['name'];
            pincode = data['centers']['pincode'].toString();
            feeType = data['centers']['fee_type'];
            time = "From " +
                data['centers']['from'] +
                " To " +
                data['centers']['to'];
            for (int i = 0; i < data['centers']['sessions'].length; i++) {
              sessionDate = data['centers']['sessions'][i]['date'];
              vaccine = data['centers']['sessions'][i]['vaccine'];
              minAge =
                  data['centers']['sessions'][i]['min_age_limit'].toString();
              dose1 = data['centers']['sessions'][i]['available_capacity_dose1']
                  .toString();
              dose2 = data['centers']['sessions'][i]['available_capacity_dose2']
                  .toString();

              sessions.add(
                SessionBox(
                    color: Get.arguments[1],
                    dose1: dose1,
                    dose2: dose2,
                    date: sessionDate,
                    time: time,
                    vaccine: vaccine,
                    minAge: minAge),
              );
            }
          });
        }
      } else {
        print(response.statusCode);
      }
    } else {
      http.Response response = await http.get(
          Uri.parse("${FlutterConfig.get('SERVER_URL')}review/${Get.arguments[0]}"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        if (data['reviews'].length == 0) {
          setState(() {
            sessions.add(const SizedBox(
              height: 80.0,
            ));
            sessions.add(Image.asset(
              "images/no_data.jpg",
            ));
            sessions.add(const SizedBox(
              height: 30.0,
            ));
            sessions.add(const Text(
              "No Data Available!",
              style: TextStyle(fontSize: 20.0),
            ));
          });
        } else {
          setState(() {
            isData = true;
            centerName = Get.arguments[2];
            centerId = Get.arguments[0];
            for (int i = data['reviews'].length-1; i >= 0; i--) {
              sessions.add(ReviewBox(
                  username: data['reviews'][i]['username'],
                  rating: data['reviews'][i]['rating'],
                  review: data['reviews'][i]['review'],
                  date: data['reviews'][i]['date']));
            }
          });
        }
      } else {
        print(response.statusCode);
      }
    }
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          Get.arguments[1] == "reviews" ? "Reviews" : "Sessions",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF344955),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: !isData
                      ? [
                          const SizedBox(
                            height: 0.0,
                          )
                        ]
                      : [
                          Text(
                            "Center ID: " + centerId,
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "Center Name: " + centerName,
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          Get.arguments[1] != "reviews"
                              ? Text(
                                  "Pincode: " + pincode,
                                  style: const TextStyle(fontSize: 20.0),
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          Get.arguments[1] != "reviews"
                              ? Text(
                                  "Fee Type: " + feeType,
                                  style: const TextStyle(fontSize: 20.0),
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          const SizedBox(
                            height: 40.0,
                            //width: 200.0,
                            child: Divider(
                              indent: 10.0,
                              endIndent: 10.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: !isData
                    ? const SizedBox(
                        height: 0.0,
                      )
                    : Text(
                        Get.arguments[1] == "reviews" ? "Reviews" : "Sessions",
                        style: TextStyle(fontSize: 20.0),
                      ),
              ),
              Column(
                children: sessions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
