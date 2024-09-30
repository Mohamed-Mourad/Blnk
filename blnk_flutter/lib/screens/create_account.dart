import 'package:blnk_flutter/methods/show_toast.dart';
import 'package:blnk_flutter/widgets/create_account_widgets/address.dart';
import 'package:blnk_flutter/widgets/create_account_widgets/confrimation.dart';
import 'package:blnk_flutter/widgets/create_account_widgets/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:blnk_flutter/widgets/page_indicator.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var boardingController = PageController();
  int currentPage = 0;

  void onNextSubmitPressed() {
    if (currentPage < pages.length - 1) {
      final formKey = (currentPage == 0)
          ? (pages[0] as PersonalInfo).formKey
          : (pages[1] as Address).formKey;
      if (formKey.currentState!.validate()) {
        boardingController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        showToast(text: "Invalid information provided; Please recheck your data.", state: ToastStates.ERROR);
      }
    } else {
      // TODO: HANDLE CONFIRMATION AND UPLOAD
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
                  fontSize: 24.0,
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
                    currentPage == pages.length - 1 ? 'Confirm' : 'Next',
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
