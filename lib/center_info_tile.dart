import 'session_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'location_page.dart';

class CenterInfoTile extends StatefulWidget {
  CenterInfoTile(
  {
    required this.color,
    required this.name,
    required this.districtName,
    required this.stateName,
    required this.centerId,
    required this.lat,
    required this.lon,
    required this.location,
    required this.pincode
});
  final Color color;
  final String name;
  final String districtName;
  final String stateName;
  final String centerId;
  final double lat;
  final double lon;
  final String location;
  final String pincode;

  @override
  _CenterInfoTileState createState() => _CenterInfoTileState();
}

class _CenterInfoTileState extends State<CenterInfoTile> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: widget.color,
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
              width: 200.0,
              child: Divider(
                color: Colors.grey,
                indent: 40.0,
                endIndent: 40.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_sharp,
                  color: widget.color,
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
              width: 200.0,
              child: Divider(
                indent: 40.0,
                endIndent: 40.0,
                color: Colors.grey,
              ),
            ),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: widget.color,
              child: Text(
                "Center ID\n" + widget.centerId.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.location,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 40.0,
              width: 200.0,
              child: Divider(
                indent: 40.0,
                endIndent: 40.0,
                color: Colors.grey,
              ),
            ),
            Text(
              "Pincode: " + widget.pincode.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0),
            ),
            Text(
              "State: " + widget.stateName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0),
            ),
            Text(
              "District: " + widget.districtName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0),
            ),
            const SizedBox(
              height: 40.0,
              width: 200.0,
              child: Divider(
                indent: 40.0,
                endIndent: 40.0,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: widget.color,
                  size: 25.0,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(LocationPage(), arguments: [widget.lat, widget.lon]);
                  },
                  child: Text(
                    "View Location",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: widget.color
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
              width: 200.0,
              child: Divider(
                indent: 40.0,
                endIndent: 40.0,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.near_me,
                  size: 30.0,
                  color: widget.color,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(SessionInfo(), arguments: [widget.centerId, widget.color]);
                  },
                  child: Text(
                    "Session Information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: widget.color),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}