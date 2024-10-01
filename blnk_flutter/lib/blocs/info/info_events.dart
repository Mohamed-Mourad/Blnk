abstract class InfoEvent {}

class InfoSubmitPersonalData extends InfoEvent {
  final String firstName;
  final String lastName;
  final String mobile;
  final String landline;
  final String email;

  InfoSubmitPersonalData({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.landline,
    required this.email,
  });
}

class InfoSubmitAddress extends InfoEvent {
  final String apt;
  final String floor;
  final String bld;
  final String streetName;
  final String landmark;
  final String city;
  final String area;

  InfoSubmitAddress({
    required this.apt,
    required this.floor,
    required this.bld,
    required this.streetName,
    required this.landmark,
    required this.city,
    required this.area,
  });
}

class InfoAddNewUser extends InfoEvent {}

class InfoSubmitIdFront extends InfoEvent {
  final String idFrontPath;

  InfoSubmitIdFront({
    required this.idFrontPath,
});
}

class InfoSubmitIdBack extends InfoEvent {
  final String idBackPath;

  InfoSubmitIdBack({
    required this.idBackPath,
  });
}

class InfoUploadData extends InfoEvent {}
