import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionBox extends StatelessWidget {
  const SessionBox(
      {
        required this.date,
        required this.time,
        required this.color,
        required this.vaccine,
        required this.minAge,
        required this.dose1,
        required this.dose2
      });
  final String date;
  final Color color;
  final String time;
  final String vaccine;
  final String dose1;
  final String dose2;
  final String minAge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              borderRadius: BorderRadius.all(const Radius.circular(10.0)),
              elevation: 5.0,
              color: const Color(0xFFF1F5DF),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Date: " + date,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      "Time: " + time,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                      child: Divider(
                        color: Colors.black38,
                        endIndent: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          Text(
                            "Vaccine Name: " + vaccine,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color(0xFF37966F),
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "Minimum Age: " + minAge,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color(0xFF37966F),
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "Dose 1 Availability: " + dose1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color(0xFF37966F),
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "Dose 2 Availability: " + dose2,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color(0xFF37966F),
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                      child: Divider(
                        color: Colors.black38,
                        endIndent: 20.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var url = "https://selfregistration.cowin.gov.in/";
                        if (await canLaunch(url)) {
                          await launch(
                              url,
                              forceWebView: true,
                              forceSafariVC: true,
                              enableJavaScript: true
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text(
                        "Book Now",
                        style:
                        TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                      child: Divider(
                        color: Colors.black38,
                        endIndent: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
