abstract class InfoState {}

class InfoInitialState extends InfoState {}

class InfoPersonalDataSubmitted extends InfoState {}

class InfoAddressSubmitted extends InfoState {}

class InfoIdFrontSubmitted extends InfoState {}

class InfoIdBackSubmitted extends InfoState {}

class InfoUploadLoading extends InfoState {}

class InfoUploadSuccess extends InfoState {}

class InfoUploadError extends InfoState {
  final String error;

  InfoUploadError(this.error);
}
