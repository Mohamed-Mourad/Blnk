import 'package:blnk_flutter/blocs/info/info_bloc.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/models/user_model.dart';
import 'package:blnk_flutter/widgets/confirmation_field_label.dart';
import 'package:blnk_flutter/widgets/disabled_form_field.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<InfoBloc>().userModel;

    return BlocConsumer<InfoBloc, InfoState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: context.read<InfoBloc>().userModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const ConfirmationFieldLabel(icon: Icons.person, text: "FULL NAME"),
                  DisabledFormField(
                    initialValue: '${userModel!.firstName} ${userModel.lastName}',
                    label: "name",
                  ),
                  const SizedBox(height: 15.0,),
                  const ConfirmationFieldLabel(icon: Icons.phone, text: "PHONE NUMBERS"),
                  DisabledFormField(
                    initialValue: userModel.mobile,
                    label: "mobile",
                  ),
                  const SizedBox(height: 4.0,),
                  DisabledFormField(
                    initialValue: userModel.landline,
                    label: "landline",
                  ),
                  const SizedBox(height: 15.0,),
                  const ConfirmationFieldLabel(icon: Icons.alternate_email, text: "EMAIL ADDRESS"),
                  DisabledFormField(
                    initialValue: userModel.email,
                    label: "email",
                  ),
                  const SizedBox(height: 15.0,),
                  const ConfirmationFieldLabel(icon: Icons.location_on, text: "HOME ADDRESS"),
                  DisabledFormField(
                    initialValue: '${userModel.address?.bld} ${userModel.address?.streetName} St. ${userModel.address?.area} ${userModel.address?.city.toUpperCase()}\nfloor ${userModel.address?.floor} apartment ${userModel.address?.apt}',
                    label: "address",
                  ),
                  const SizedBox(height: 15.0,),
                  const ConfirmationFieldLabel(icon: Icons.badge_outlined, text: "NATIONAL ID"),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: Text('No user data available.')),
        );
      },
    );
  }
}
