import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/Components/error_message.dart';
import 'package:shopping_app/Components/input_field.dart';
import 'package:shopping_app/Components/rounded_button.dart';
import 'package:shopping_app/Screens/Auth/otp.dart';
import 'package:shopping_app/Utils/Routes/routes_name.dart';

class PhoneNoScreen extends StatefulWidget {
  const PhoneNoScreen({super.key});

  @override
  State<PhoneNoScreen> createState() => _PhoneNoScreenState();
}

class _PhoneNoScreenState extends State<PhoneNoScreen> {
  bool loading = false;
  bool iconVisibilty = true;

  final auth = FirebaseAuth.instance;
  final fromkey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  var countryNameController = TextEditingController();
  var countryCodeController = TextEditingController();
  var phoneNumberController = TextEditingController();

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Pakistan');
    countryCodeController = TextEditingController(text: '92');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  phoneNoRestrictions() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;
    if (phoneNumber.isEmpty) {
      ErrorMessage.toastMessage("Please enter your phone number");
    } else if (phoneNumber.length < 9) {
      ErrorMessage.toastMessage(
          "The phone number you entered is too short for the country: $countryName.\n\nInclude your area code if you haven't.");
    } else if (phoneNumber.length > 10) {
      ErrorMessage.toastMessage(
          "The phone number you entered is too long for the country: $countryName");
    }

    auth.verifyPhoneNumber(
        phoneNumber: '+$countryCode$phoneNumber',
        verificationCompleted: (_) {
          setState(() {
            loading = false;
          });
        },
        verificationFailed: (e) {
          ErrorMessage.toastMessage(e.toString());
        },
        codeSent: (String verficationId, int? token) {
          ErrorMessage.toastMessage('Wating for otp');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationPage(
                        verficationId: verficationId,
                      )));
          setState(() {
            loading = false;
          });
        },
        codeAutoRetrievalTimeout: (e) {
          ErrorMessage.toastMessage(e.toString());
        });
  }

  showCountryCodePicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['ET'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).colorScheme.background,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: const TextStyle(color: Colors.blue),
        inputDecoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.blue),
          prefixIcon: Icon(
            Icons.language,
            color: Colors.blueAccent.shade700,
          ),
          hintText: 'Search Country name or code',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.2),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent.shade700,
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const Image(image: AssetImage("assets/images/phone.jpg")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.25,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(2, 1),
                                blurRadius: 4)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Form(
                              key: fromkey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                RoutesName.loginScreeen);
                                          },
                                          icon: const Icon(Icons
                                              .arrow_back_ios_new_rounded)),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          'Verify Phone Number',
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: MyTextField(
                                      onTap: showCountryCodePicker,
                                      textAlign: TextAlign.center,
                                      textController: countryNameController,
                                      keyboard: TextInputType.number,
                                      readOnly: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: MyTextField(
                                            onTap: showCountryCodePicker,
                                            textController:
                                                countryCodeController,
                                            prefixText: '+',
                                            readOnly: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: MyTextField(
                                            textController:
                                                phoneNumberController,
                                            hint: 'phone number',
                                            keyboard: TextInputType.number,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  RoundedButton(
                                    title: 'Next',
                                    color:
                                        const Color.fromARGB(116, 1, 139, 194),
                                    onPress: () {
                                      if (fromkey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        phoneNoRestrictions();
                                      }
                                    },
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
