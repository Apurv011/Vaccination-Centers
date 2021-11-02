class CenterData {
  String stateName;
  String districtName;
  String pincode;
  String name;
  String centerId;
  int id;
  double lon;
  double lat;
  String location;
  String distance;

  CenterData(
      {required this.stateName,
        required this.districtName,
        required this.pincode,
        required this.name,
        required this.lon,
        required this.lat,
        required this.centerId,
        required this.id,
        required this.location,
        this.distance=""
      });
}
