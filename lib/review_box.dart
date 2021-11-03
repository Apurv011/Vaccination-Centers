import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewBox extends StatelessWidget {
  const ReviewBox(
      {
        required this.date,
        required this.username,
        required this.review,
        required this.rating
      });
  final String date;
  final String username;
  final String review;
  final String rating;

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
                      "Review By: " + username,
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
                      child: Text(
                        review,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color(0xFF37966F),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                      child: Divider(
                        color: Colors.black38,
                        endIndent: 20.0,
                      ),
                    ),
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: double.parse(rating),
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ), onRatingUpdate: (double value) { print("A"); },
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
