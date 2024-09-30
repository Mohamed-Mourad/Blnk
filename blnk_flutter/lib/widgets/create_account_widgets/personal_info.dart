import 'package:blnk_flutter/blocs/info/info_bloc.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/models/user_model.dart';
import 'package:blnk_flutter/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel? userModel;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var landlineController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userModel = context.read<InfoBloc>().userModel;

    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        if(userModel != null) {
          firstNameController.text = userModel.firstName;
          lastNameController.text = userModel.lastName;
          mobileNumberController.text = userModel.mobile;
          landlineController.text = userModel.landline;
          emailController.text = userModel.email;
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,

              child: Column(
                children: [
                  const Text(
                    "Welcome! Let's get started by gathering some basic information about you. Please fill out the following fields",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  DefaultFormField(
                    controller: firstNameController,
                    keyboard: TextInputType.name,
                    validate: (value) =>
                    value != null && value.isEmpty ? 'You must write a name' : null,
                    label: "First Name",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: lastNameController,
                    keyboard: TextInputType.name,
                    validate: (value) =>
                    value != null && value.isEmpty ? 'You must write a name' : null,
                    label: "Last Name",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: mobileNumberController,
                    keyboard: TextInputType.phone,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must write a mobile number';
                      }
                      if (value.length > 11) {
                        return 'Longer than expected';
                      }
                      if (value.length < 11) {
                        return 'Shorter than expected';
                      }
                      if (!value.startsWith('0')) {
                        return 'Invalid mobile number';
                      }
                      return null;
                    },
                    label: "Mobile Number",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: landlineController,
                    keyboard: TextInputType.phone,
                    validate: (value) =>
                    value != null && value.isEmpty ? 'You must write a landline number' : null,
                    label: "Landline",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must write an email';
                      }

                      // Regex pattern for validating email format
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return 'Email invalid';
                      }

                      return null;
                    },
                    label: "Email",
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
