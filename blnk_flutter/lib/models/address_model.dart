class AddressModel {
  String apt;
  String floor;
  String bld;
  String streetName;
  String landMark;
  String city;
  String area;

  AddressModel({
    required this.apt,
    required this.floor,
    required this.bld,
    required this.streetName,
    required this.landMark,
    required this.city,
    required this.area,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      apt: json['apartment'],
      floor: json['floor'],
      bld: json['building'],
      streetName: json['streetName'],
      landMark: json['landMark'],
      city: json['city'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartment': apt,
      'floor': floor,
      'building': bld,
    };
  }
}
