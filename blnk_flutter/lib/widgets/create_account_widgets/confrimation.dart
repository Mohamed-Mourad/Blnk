import 'package:blnk_flutter/widgets/default_form_field.dart';
import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    var aptController = TextEditingController();
    var floorController = TextEditingController();
    var bldController = TextEditingController();
    var streetNameController = TextEditingController();
    var landMarkController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
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
              const SizedBox(width: 10.0,),
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
          DefaultFormField(
            controller: landMarkController,
            keyboard: TextInputType.name,
            validate: (value) =>
            value != null && value.isEmpty ? 'Must not be empty.' : null,
            label: "Land Mark",
          ),
        ],
      ),
    );
  }
}
