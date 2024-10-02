import 'dart:io';
import 'package:blnk_flutter/models/user_model.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/drive/v3.dart' as drive;


const String scriptURL  = 'https://script.google.com/macros/s/AKfycbwEEPmg3O3ODI6sX6XfHcH_ZCwomfNEKZwCpj43DFf7DdKW_BQtvK3vDfMAso6aeSIINA/exec';

//LOADING CREDENTIALS:
Future<ServiceAccountCredentials> loadCredentials() async {
  final jsonData = await rootBundle.loadString('assets/credentials/blnk-task-service-key.json');
  final jsonMap = json.decode(jsonData);
  return ServiceAccountCredentials.fromJson(jsonMap);
}

//AUTHENTICATION:
Future<AutoRefreshingAuthClient> authenticate() async {
  final credentials = await loadCredentials();
  final scopes = [drive.DriveApi.driveFileScope];
  return await clientViaServiceAccount(credentials, scopes);
}

// UPLOADING TO DRIVE:
class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

// Upload function
Future<String?> uploadToDrive({required String filePath, required String idSide}) async {
  var client = await authenticate();
  var driveApi = drive.DriveApi(client);

  drive.File fileToUpload = drive.File();
  fileToUpload.name = idSide;

  var media = drive.Media(File(filePath).openRead(), File(filePath).lengthSync());

  try {
    var response = await driveApi.files.create(
      fileToUpload,
      uploadMedia: media,
    );

    print('Uploaded: ${response.name}');

    // Set file permissions to be publicly accessible
    drive.Permission permission = drive.Permission()
      ..type = 'anyone'
      ..role = 'reader';  // "reader" allows viewing but not editing

    await driveApi.permissions.create(
      permission,
      response.id!,
      $fields: 'id',
    );

    // Retrieve the webViewLink (link to view the file)
    var uploadedFile = await driveApi.files.get(response.id!, $fields: 'webViewLink') as drive.File;
    print('File URL: ${uploadedFile.webViewLink}');

    return uploadedFile.webViewLink;
  } catch (e) {
    print('Failed to upload: $e');
    return null;
  } finally {
    client.close(); // Close the client when done
  }
}


Future<http.Response> uploadToSpreadsheet(UserModel userModel, String idFront, String idBack) async {
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

  String query = "?firstName=$firstName&lastName=$lastName&mobile=$mobile&landline=$landline&email=$email&apt=$apt&floor=$floor&bld=$bld&street=$streetName&area=$area&city=$city&landmark=$landMark&idFront=$idFront&idBack=$idBack";

  var request = Uri.parse(scriptURL + query);
  var response = await http.get(request);

  if (response.statusCode == 200) {
  } else {
    throw Exception("Failed to upload data: ${response.statusCode}");
  }

  return response;
}