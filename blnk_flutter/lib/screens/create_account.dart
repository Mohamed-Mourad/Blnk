import 'package:blnk_flutter/blocs/info/info_bloc.dart';
import 'package:blnk_flutter/blocs/info/info_events.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/methods/navigations.dart';
import 'package:blnk_flutter/methods/show_toast.dart';
import 'package:blnk_flutter/screens/id_capture.dart';
import 'package:blnk_flutter/screens/registration_complete.dart';
import 'package:blnk_flutter/widgets/create_account_widgets/address.dart';
import 'package:blnk_flutter/widgets/create_account_widgets/confrimation.dart';
import 'package:blnk_flutter/widgets/create_account_widgets/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:blnk_flutter/widgets/page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccount extends StatefulWidget {
  final int initialPage;

  const CreateAccount({
    super.key,
    required this.initialPage,
  });

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late PageController boardingController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController with the initialPage passed to the widget
    boardingController = PageController(initialPage: widget.initialPage);
    currentPage = widget.initialPage;  // Set currentPage to the initialPage
  }

  void onNextSubmitPressed() {
    if (currentPage < pages.length - 1) {
      final formKey = (currentPage == 0)
          ? (pages[0] as PersonalInfo).formKey
          : (pages[1] as Address).formKey;
      if (formKey.currentState!.validate()) {
        if(currentPage == 0) {
          var firstName = (pages[0] as PersonalInfo).firstNameController.text;
          var lastName = (pages[0] as PersonalInfo).lastNameController.text;
          var mobile = (pages[0] as PersonalInfo).mobileNumberController.text;
          var landline = (pages[0] as PersonalInfo).landlineController.text;
          var email = (pages[0] as PersonalInfo).emailController.text;
          context.read<InfoBloc>().add(
              InfoSubmitPersonalData(
                  firstName: firstName,
                  lastName: lastName,
                  mobile: mobile,
                  landline: landline,
                  email: email,
              ),
          );
          boardingController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        if(currentPage == 1) {
          var apt = (pages[1] as Address).aptController.text;
          var floor = (pages[1] as Address).floorController.text;
          var bld = (pages[1] as Address).bldController.text;
          var streetName = (pages[1] as Address).streetNameController.text;
          var landMark = (pages[1] as Address).landMarkController.text;
          var city = (pages[1] as Address).selectedCity!;
          var area = (pages[1] as Address).selectedArea!;
          context.read<InfoBloc>().add(
            InfoSubmitAddress(
                apt: apt,
                floor: floor,
                bld: bld,
                streetName: streetName,
                landmark: landMark,
                city: city,
                area: area,
            ),
          );
          navigateAndReplace(context, IdCapture(subtitle: "Front", capturedSide: "Front",));
        }
      } else {
        showToast(text: "Invalid information provided; Please recheck your data.", state: ToastStates.ERROR);
      }
    } else {
      navigateAndReplace(context, const RegistrationComplete());
    }
  }

  List<Widget> pages = [
    PersonalInfo(),
    Address(),
    const Confirmation(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: AppBar(
              title: const Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: currentPage > 0
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        boardingController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    )
                  : null,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            PageIndicator(currentPage: currentPage + 1),
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) => pages[index],
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SizedBox(
                width: 240.0,
                height: 48.0,
                child: MaterialButton(
                  elevation: 6.0,
                  onPressed: onNextSubmitPressed,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    currentPage == pages.length - 1 ? 'Submit' : 'Next',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
