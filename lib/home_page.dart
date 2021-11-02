import 'states.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'centers_near_me.dart';
import 'vaccination_centers.dart';

class HomePage extends StatelessWidget {

  final TextEditingController pincodeController = TextEditingController();

  var lat;
  var long;
  bool showSpinner = false;

  HomePage({Key? key}) : super(key: key);

  Future<void> getloc() async {
    Position position = await _getGeoLocationPosition();
      lat = position.latitude;
      long = position.longitude;
    }


    Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Vaccination Center",
          style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFF344955),
        ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Get Vaccination Centers",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  color: Color(0xff1abc9c),
                ),
              ),
              const SizedBox(
                height: 60.0,
                width: 200.0,
              ),
              TextButton(
                onPressed: () {
                  Get.to(States(), arguments: ["states"]);
                  print("Locate!");
                },
                child: const Text(
                  "Centers by State",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFF5A623),
                  ),
                ),
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
              TextButton(
                onPressed: () {
                  Get.to(States(), arguments: ["districts"]);
                },
                child: const Text(
                  "Centers by District",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFFE13A20),
                  ),
                ),
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
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0))),
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal:18 ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                                child: Text(
                                  'Enter your Pincode',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: TextField(
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xff1abc9c)),
                                        borderRadius: BorderRadius.circular(25.7),
                                      ),
                                      hintText: 'Pincode'
                                  ),
                                  autofocus: true,
                                  controller: pincodeController,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(VaccinationCenter(),
                                          arguments: ["http://192.168.29.14:5000/center/pincode/${pincodeController.text.trim()}"]
                                      );
                                    },
                                    child: const Text(
                                      "Go",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF10CAC9),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                },
                child: const Text(
                  "Centers by Pincode",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF10CAC9),
                  ),
                ),
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
              TextButton(
                onPressed: ()  async {
                  await getloc();
                  Get.to(const CentersNearMe(), arguments: [lat.toString(), long.toString()]);
                },
                child: const Text(
                  "Centers Near Me",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF4A7BA7),
                  ),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
