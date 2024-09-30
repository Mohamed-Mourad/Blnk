import 'package:blnk_flutter/widgets/city_area_selectors.dart';
import 'package:blnk_flutter/widgets/default_form_field.dart';
import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  Address({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var aptController = TextEditingController();
    var floorController = TextEditingController();
    var bldController = TextEditingController();
    var streetNameController = TextEditingController();
    var landMarkController = TextEditingController();


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
              // Row(
              //   // TODO: PUT THE DROP DOWN MENUS HERE INSTEAD OF EXPANDED FORM FIELDS
              //   children: [
              //     Expanded(
              //       child: DefaultFormField(
              //         controller: areaController,
              //         keyboard: TextInputType.number,
              //         validate: (value) =>
              //         value != null && value.isEmpty ? 'Must not be empty' : null,
              //         label: "Area",
              //       ),
              //     ),
              //     const SizedBox(width: 10.0,),
              //     Expanded(
              //       child: DefaultFormField(
              //         controller: cityController,
              //         keyboard: TextInputType.number,
              //         validate: (value) =>
              //         value != null && value.isEmpty ? 'Must not be empty' : null,
              //         label: "City",
              //       ),
              //     ),
              //   ],
              // ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: CityAreaSelectors()
                  ),
                ],
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
  }
}
