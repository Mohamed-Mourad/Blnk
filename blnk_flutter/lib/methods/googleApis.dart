import 'package:blnk_flutter/models/address_model.dart';
import 'package:blnk_flutter/models/user_model.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

// Function to load OAuth credentials from JSON file
Future<Map<String, dynamic>> loadCredentials() async {
  String jsonString = await rootBundle.loadString('assets/google_oauth_credentials.json');
  return json.decode(jsonString);
}

// Initialize Google Sign-In
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'https://www.googleapis.com/auth/drive.file', // For Google Drive access
    'https://www.googleapis.com/auth/spreadsheets', // For Google Sheets access
  ],
);

// Authenticate the user and return an AutoRefreshingAuthClient
Future<AutoRefreshingAuthClient> authenticateWithGoogle() async {
  // Load the credentials
  Map<String, dynamic> credentialsMap = await loadCredentials();

  final clientId = ClientId(
    credentialsMap['client_id'], // Use the key from your JSON file
    credentialsMap['client_secret'], // Use the key from your JSON file
  );

  // Sign in the user using Google Sign-In
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  if (googleUser == null) {
    // User canceled the sign-in process
    throw Exception('Sign-in aborted by user');
  }

  // Obtain the auth details from the user
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Build the AccessCredentials from the obtained authentication details
  final credentials = AccessCredentials(
    AccessToken(
      'Bearer', googleAuth.accessToken!, DateTime.now().add(Duration(hours: 1)),
    ),
    googleAuth.idToken, // This is for later use
    ['https://www.googleapis.com/auth/drive.file', 'https://www.googleapis.com/auth/spreadsheets'],
  );

  // Create the auto-refreshing auth client
  var authClient = autoRefreshingClient(clientId, credentials, http.Client());

  return authClient;
}

// Function to upload a file to Google Drive
Future<drive.File> uploadFileToDrive(
    drive.DriveApi driveApi, File file, String fileName) async {
  if (!file.existsSync()) {
    throw Exception('File does not exist: ${file.path}');
  }

  var media = drive.Media(file.openRead(), await file.length());
  var driveFile = drive.File()..name = fileName;

  try {
    var response = await driveApi.files.create(driveFile, uploadMedia: media);
    return response;
  } catch (e) {
    throw Exception('Failed to upload file: $e');
  }
}

// Function to append user data to Google Sheets
Future<void> appendDataToSheet(
    sheets.SheetsApi sheetsApi,
    String spreadsheetId,
    String sheetName,
    UserModel userModel,
    AddressModel addressModel,
    String frontImageId,
    String backImageId
    ) async {
  var values = [
    [
      userModel.firstName,
      userModel.lastName,
      userModel.mobile,
      userModel.email,
      addressModel.streetName,
      addressModel.city,
      addressModel.area,
      frontImageId,
      backImageId,
    ]
  ];

  var request = sheets.ValueRange(
    range: '$sheetName', // Use sheetName directly
    values: values,
  );

  try {
    await sheetsApi.spreadsheets.values.append(
      request,
      spreadsheetId,
      '$sheetName!A1', // Replace with the appropriate range
      valueInputOption: 'RAW',
    );
  } catch (e) {
    throw Exception('Failed to append data to sheet: $e');
  }
}
