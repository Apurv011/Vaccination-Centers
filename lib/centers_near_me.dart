import 'center_tile.dart';
import 'networking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'center_data.dart';

class CentersNearMe extends StatefulWidget {
  const CentersNearMe({Key? key}) : super(key: key);

  @override
  _CentersNearMeState createState() => _CentersNearMeState();
}

class _CentersNearMeState extends State<CentersNearMe> {

  List<Widget> centerTiles = [];
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

    var data = await networkHelper.getData("http://192.168.29.14:5000/center/nearMe/${Get.arguments[0]}/${Get.arguments[1]}");

    setState(() {
      for (var i = 0; i < data['centers'].length; i++) {
        centerTiles.add(
            CenterTile(
              centerData: CenterData(
                  id: data['centers'][i]['_id'],
                  centerId: data['centers'][i]['center_id'].toString(),
                  lon: data['centers'][i]['long'].toDouble(),
                  lat: data['centers'][i]['lat'].toDouble(),
                  stateName: data['centers'][i]['state_name'],
                  districtName: data['centers'][i]['district_name'],
                  name: data['centers'][i]['name'],
                  pincode: data['centers'][i]['pincode'].toString(),
                  location: data['centers'][i]['location'],
                distance: data['centers'][i]['distance']
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
          'Select Center',
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



