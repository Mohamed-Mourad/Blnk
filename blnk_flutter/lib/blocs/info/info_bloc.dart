import 'package:blnk_flutter/blocs/info/info_events.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(InfoInitialState()) {
    on<InfoSubmitPersonalData>(_onSubmitPersonalInfo);
    on<InfoSubmitAddress>(_onSubmitAddress);
  }

  UserModel? userModel;

  void _onSubmitPersonalInfo(
    InfoSubmitPersonalData event,
    Emitter<InfoState> emit,
  ) async {
    userModel?.firstName = event.firstName;
    userModel?.lastName = event.lastName;
    userModel?.mobile = event.mobile;
    userModel?.landline = event.landline;
    userModel?.email = event.email;

    emit(InfoPersonalDataSubmitted());
  }

  Future<void> _onSubmitAddress(
    InfoSubmitAddress event,
    Emitter<InfoState> emit,
  ) async {
    userModel?.address.apt = event.apt;
    userModel?.address.floor = event.floor;
    userModel?.address.bld = event.bld;

    emit(InfoAddressSubmitted());
  }

  void _onSubmitIdFront() {}

  void _onSubmitIdBack() {}

  void _onConfirm() {}
}
