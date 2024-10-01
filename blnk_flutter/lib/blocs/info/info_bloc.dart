import 'dart:io';
import 'package:blnk_flutter/blocs/info/info_events.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/methods/googleApis.dart';
import 'package:blnk_flutter/models/address_model.dart';
import 'package:blnk_flutter/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(InfoInitialState()) {
    on<InfoSubmitPersonalData>(_onSubmitPersonalInfo);
    on<InfoSubmitAddress>(_onSubmitAddress);
    on<InfoAddNewUser>(_onAddNewUser);
    on<InfoSubmitIdFront>(_onSubmitIdFront);
    on<InfoSubmitIdBack>(_onSubmitIdBack);
    on<InfoUploadData>(_onConfirm);
  }

  UserModel? userModel;
  AddressModel? addressModel;

  void _onSubmitPersonalInfo(
    InfoSubmitPersonalData event,
    Emitter<InfoState> emit,
  ) async {
    userModel = UserModel(
      firstName: event.firstName,
      lastName: event.lastName,
      mobile: event.mobile,
      landline: event.landline,
      email: event.email,
    );
    emit(InfoPersonalDataSubmitted());
  }

  Future<void> _onSubmitAddress(
    InfoSubmitAddress event,
    Emitter<InfoState> emit,
  ) async {
    addressModel = AddressModel(
      apt: event.apt,
      floor: event.floor,
      bld: event.bld,
      streetName: event.streetName,
      landMark: event.landmark,
      city: event.city,
      area: event.area,
    );
    userModel?.address = addressModel;
    emit(InfoAddressSubmitted());
  }

  String idFrontImagePath = '';
  String idBackImagePath = '';

  Future<void> _onSubmitIdFront(
    InfoSubmitIdFront event,
    Emitter<InfoState> emit,
  ) async {
    idFrontImagePath = event.idFrontPath;
    emit(InfoIdFrontSubmitted());
  }

  void _onSubmitIdBack(
    InfoSubmitIdBack event,
    Emitter<InfoState> emit,
  ) async {
    idBackImagePath = event.idBackPath;
    emit(InfoIdBackSubmitted());
  }

  Future<void> _onConfirm(
      InfoUploadData event,
      Emitter<InfoState> emit,
      ) async {
    try {
      emit(InfoUploadLoading());

      // Authenticate with Google
      var authClient = await authenticateWithGoogle();

      // Initialize Google APIs
      final driveApi = drive.DriveApi(authClient);
      final sheetsApi = sheets.SheetsApi(authClient);

      // Upload the front and back images
      var frontImageFile = File(idFrontImagePath);
      var backImageFile = File(idBackImagePath);

      var frontImageResponse = await uploadFileToDrive(
          driveApi, frontImageFile, 'ID_Front_${userModel?.firstName}.jpg');
      var backImageResponse = await uploadFileToDrive(
          driveApi, backImageFile, 'ID_Back_${userModel?.firstName}.jpg');

      String frontImageId = frontImageResponse.id!;
      String backImageId = backImageResponse.id!;

      // Append data to Google Sheets
      await appendDataToSheet(
          sheetsApi,
          'your_spreadsheet_id', // replace with your spreadsheet ID
          'Users', // replace with the sheet name
          userModel!,
          addressModel!,
          frontImageId,
          backImageId
      );

      emit(InfoUploadSuccess());
    } catch (e) {
      emit(InfoUploadError(e.toString()));
    }
  }


  Future<void> _onAddNewUser(
    InfoAddNewUser event,
    Emitter<InfoState> emit,
  ) async {
    userModel = null;
    emit(InfoInitialState());
  }
}
