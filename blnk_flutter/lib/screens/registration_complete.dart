import 'package:blnk_flutter/blocs/info/info_bloc.dart';
import 'package:blnk_flutter/blocs/info/info_events.dart';
import 'package:blnk_flutter/methods/navigations.dart';
import 'package:blnk_flutter/screens/create_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationComplete extends StatelessWidget {
  const RegistrationComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80.0,),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 115.0,
                    height: 115.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3BAF85),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 48.0,
                    weight: 2.0,
                  ),
                ],
              ),
              const SizedBox(height: 50.0,),
              const Text(
                "Registration Complete",
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35.0,),
              const Text(
                "Congratulations! You have successfully completed the registration process. Your profile is now set up, and now you can start exploring all  features and benefits we offer",
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF777777)
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: SizedBox(
                  width: 240.0,
                  height: 48.0,
                  child: MaterialButton(
                    elevation: 6.0,
                    onPressed: (){
                      context.read<InfoBloc>().add(InfoAddNewUser());
                      navigateAndReplace(context, const CreateAccount(initialPage: 0,));
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Text(
                      'Register another user',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
