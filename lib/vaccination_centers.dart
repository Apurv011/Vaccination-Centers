import 'center_data.dart';
import 'center_tile.dart';
import 'networking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class VaccinationCenter extends StatefulWidget {
  const VaccinationCenter({Key? key}) : super(key: key);

  @override
  _VaccinationCenterState createState() => _VaccinationCenterState();
}

class _VaccinationCenterState extends State<VaccinationCenter> {

  List<Widget> centerTiles = [];

  var name = "Name";

  var districtName = "District Name";

  var stateName = "Maharashtra";

  var pincode = "Pincode";

  var centerId = "";

  var location = "";

  var _id = 0;

  var lat = 0.0;

  var lon = 0.0;

  bool showSpinner = true;

  @override
  // ignore: missing_return
  void initState() {
    super.initState();
    updateUI();
  }

  Future<void> updateUI() async {
    showSpinner = true;
    NetworkHelper networkHelper = NetworkHelper();

    var data = await networkHelper.getData(Get.arguments[0]);

    setState(() {
      centerTiles.clear();
      for (var i = 0; i < data['centers'].length; i++) {
        _id = data['centers'][i]['_id'];
        centerId = data['centers'][i]['center_id'].toString();
        lat = data['centers'][i]['lat'].toDouble();
        lon = data['centers'][i]['long'].toDouble();
        stateName = data['centers'][i]['state_name'];
        districtName = data['centers'][i]['district_name'];
        location = data['centers'][i]['location'];
        name = data['centers'][i]['name'];
        pincode = data['centers'][i]['pincode'].toString();

        centerTiles.add(
            CenterTile(
              centerData: new CenterData(
                  id: _id,
                  centerId: centerId,
                  lon: lon,
                  lat: lat,
                  stateName: stateName,
                  districtName: districtName,
                  name: name,
                  pincode: pincode,
                  location: location
              ),
            )
        );
        showSpinner = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF344955),
        title: const Text(
          'Vaccination Centers',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView.builder(
          itemCount: centerTiles.length,
          itemBuilder: (context, index) {
            return centerTiles[index];
          },
        ),
      ),
    );
  }
}


