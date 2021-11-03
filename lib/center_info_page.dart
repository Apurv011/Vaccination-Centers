import 'center_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterInfoPage extends StatelessWidget {
  const CenterInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vaccination Centers',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF344955),
      ),
      body: CenterInfoTile(
          color: Color(int.parse(Get.arguments[0].toString().split('(0x')[1].split(')')[0], radix: 16)),
          name: Get.arguments[1],
          districtName: Get.arguments[2],
          stateName: Get.arguments[3],
          centerId: Get.arguments[4],
          lat: Get.arguments[5],
          lon: Get.arguments[6],
          location: Get.arguments[7],
          pincode: Get.arguments[8]),
    );
  }
}
