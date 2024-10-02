import 'package:blnk_flutter/models/user_model.dart';
import 'package:http/http.dart' as http;

const String scriptURL  = 'https://script.google.com/macros/s/AKfycbwEEPmg3O3ODI6sX6XfHcH_ZCwomfNEKZwCpj43DFf7DdKW_BQtvK3vDfMAso6aeSIINA/exec';

Future<http.Response> uploadToSpreadsheet(UserModel userModel) async {
  String firstName = userModel.firstName;
  String lastName = userModel.lastName;
  String mobile = userModel.mobile;
  String landline = userModel.landline;
  String email = userModel.email;
  String apt = userModel.address!.apt;
  String floor = userModel.address!.floor;
  String bld = userModel.address!.bld;
  String streetName = userModel.address!.streetName;
  String landMark = userModel.address!.landMark;
  String city = userModel.address!.city;
  String area = userModel.address!.area;

  String query = "?firstName=$firstName&lastName=$lastName&mobile=$mobile&landline=$landline&email=$email&apt=$apt&floor=$floor&bld=$bld&street=$streetName&area=$area&city=$city&landmark=$landMark";

  var request = Uri.parse(scriptURL + query);
  var response = await http.get(request);

  if (response.statusCode == 200) {
    print("Data uploaded successfully!");
  } else {
    throw Exception("Failed to upload data: ${response.statusCode}");
  }

  return response;
}