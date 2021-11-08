import 'package:flutter_config/flutter_config.dart';

import 'districts.dart';
import 'networking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'vaccination_centers.dart';
import 'package:geolocator/geolocator.dart';

class States extends StatefulWidget {
  const States({Key? key}) : super(key: key);

  @override
  _StatesState createState() => _StatesState();
}

class _StatesState extends State<States> {

  final List<String> states = [];

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

    var data = await networkHelper.getData("${FlutterConfig.get('SERVER_URL')}state");
    print(data);

    setState(() {
      print("AAA");
      states.clear();
      for (var i = 0; i < data['states'].length; i++) {
        states.add(data['states'][i]['state_name']);
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
          'Select State',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView.builder(
          itemCount: states.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: (){
                if(Get.arguments[0]=="states") {
                  Get.to(VaccinationCenter(), arguments: [
                    "${FlutterConfig.get('SERVER_URL')}center/state/${states[index]}"
                  ]);
                }
                else{
                  Get.to(District(), arguments: [states[index]]);
                }
                },
              title: Text(states[index]),
            );
          },
        ),
      ),
    );
  }
}



