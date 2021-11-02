import 'center_data.dart';
import 'center_tile.dart';
import 'networking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'vaccination_centers.dart';

class District extends StatefulWidget {
  @override
  _DistrictState createState() => _DistrictState();
}

class _DistrictState extends State<District> {

  final List<String> districts = [];

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

    var data = await networkHelper.getData("http://192.168.29.14:5000/district/state/${Get.arguments[0]}");

    setState(() {
      districts.clear();
      for (var i = 0; i < data['districts'].length; i++) {
        districts.add(data['districts'][i]['district_name']);
      }
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF344955),
        title: const Text(
          'Select District',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child:ListView.builder(
            itemCount: districts.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: (){
                    Get.to(VaccinationCenter(), arguments: [
                      "http://192.168.29.14:5000/center/district/${districts[index]}"
                    ]);
                },
                title: Text(districts[index]),
              );
            },
          ),

        ),
      ),
    );
  }
}


