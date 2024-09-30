import 'package:blnk_flutter/blocs/info/info_bloc.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/models/address_model.dart';
import 'package:blnk_flutter/widgets/city_area_selectors.dart';
import 'package:blnk_flutter/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Address extends StatelessWidget {
  Address({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddressModel? addressModel;
  var aptController = TextEditingController();
  var floorController = TextEditingController();
  var bldController = TextEditingController();
  var streetNameController = TextEditingController();
  var landMarkController = TextEditingController();
  String? selectedCity;
  String? selectedArea;

  @override
  Widget build(BuildContext context) {
    var addressModel = context.read<InfoBloc>().userModel?.address;

    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        if(addressModel != null) {
          aptController.text = addressModel.apt;
          floorController.text = addressModel.floor;
          bldController.text = addressModel.bld;
          streetNameController.text = addressModel.streetName;
          landMarkController.text = addressModel.landMark;
          selectedCity = addressModel.city;
          selectedArea = addressModel.area;
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,

              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DefaultFormField(
                          controller: aptController,
                          keyboard: TextInputType.number,
                          validate: (value) =>
                          value != null && value.isEmpty ? 'Must not be empty' : null,
                          label: "Apartment",
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        child: DefaultFormField(
                          controller: floorController,
                          keyboard: TextInputType.number,
                          validate: (value) =>
                          value != null && value.isEmpty ? 'Must not be empty' : null,
                          label: "Floor",
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        child: DefaultFormField(
                          controller: bldController,
                          keyboard: TextInputType.number,
                          validate: (value) =>
                          value != null && value.isEmpty ? 'Must not be empty' : null,
                          label: "Building",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: streetNameController,
                    keyboard: TextInputType.name,
                    validate: (value) =>
                    value != null && value.isEmpty ? 'Must not be empty.' : null,
                    label: "Street Name",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CityAreaSelectors(
                    initialCity: selectedCity == "" ? null : selectedCity,
                    initialArea: selectedArea == "" ? null : selectedArea,
                    onCityChanged: (city) {
                      selectedCity = city;
                    },
                    onAreaChanged: (area) {
                      selectedArea = area;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: landMarkController,
                    keyboard: TextInputType.name,
                    validate: (value) =>
                    value != null && value.isEmpty ? 'Must not be empty.' : null,
                    label: "Land Mark",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
