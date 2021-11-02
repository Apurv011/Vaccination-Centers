import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'center_data.dart';
import 'center_info_page.dart';

class CenterTile extends StatelessWidget {
  CenterTile({required this.centerData});

  final CenterData centerData;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.to(const CenterInfoPage(), arguments: [
              getColour(centerData.id),
              centerData.name,
              centerData.districtName,
              centerData.stateName,
              centerData.centerId,
              centerData.lat,
              centerData.lon,
              centerData.location,
              centerData.pincode
            ]);
          },
          leading: CircleAvatar(
            backgroundColor: getColour(centerData.id),
            child: Text(
              centerData.distance=="" ? centerData.name.substring(0,1) : centerData.distance + "\nkm",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  centerData.name,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                    centerData.districtName + ", " + centerData.stateName,
                  style: const TextStyle(
                      color: Colors.blueGrey
                  ),
                ),
              ],
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 9.0),
            child: Column(
              children: [
                const Text("Pincode"),
                Text(centerData.pincode),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 3.0,
          width: 370.0,
          child: Divider(
            indent: 40.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

getColour(int id) {
  Color colour;
  switch (id%10) {
    case 0:
    case 1:
      colour = const Color(0xff1abc9c);
      break;
    case 2:
      colour = const Color(0xFF04B4B3);
      break;
    case 3:
      colour = const Color(0xff079992);
      break;
    case 4:
      colour = const Color(0xffF5A623);
      break;
    case 5:
      colour = const Color(0xffFF7D50);
      break;
    case 6:
      colour = const Color(0xffff5e57);
      break;
    case 7:
      colour = const Color(0xff37966f);
      break;
    case 8:
      colour = const Color(0xff1abc9c);
      break;
    case 9:
      colour = const Color(0xfff9aa33);
      break;
    default:
      colour = const Color(0xfff8c291);
      break;
  }
  return colour;
}
