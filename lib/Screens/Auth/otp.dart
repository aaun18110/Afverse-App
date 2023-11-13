// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, dead_code
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Components/error_message.dart';
import 'package:shopping_app/Components/input_field.dart';
import 'package:shopping_app/Components/rounded_button.dart';
import 'package:shopping_app/Screens/home.dart';

class VerificationPage extends StatefulWidget {
  final String verficationId;
  const VerificationPage({
    Key? key,
    required this.verficationId,
  }) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final formKey = GlobalKey<FormState>();
  final verificationController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const Image(image: AssetImage("assets/images/signup.jpg")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.25,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(2, 1),
                                blurRadius: 4)
                          ],
                          borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80),
                                    child: MyTextField(
                                      textController: verificationController,
                                      hint: '- - - - - - ',
                                      autoFocus: true,
                                      textAlign: TextAlign.center,
                                      fontSize: 30,
                                      keyboard: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  RoundedButton(
                                      title: 'Verify OTP',
                                      color: Colors.lightBlueAccent,
                                      loading: loading,
                                      onPress: () async {
                                        if (formKey.currentState!.validate()) {
                                          if (verificationController.text
                                              .toString()
                                              .isEmpty) {
                                            ErrorMessage.toastMessage(
                                                "Enter otp");
                                          } else {
                                            final credential =
                                                PhoneAuthProvider.credential(
                                                    verificationId:
                                                        widget.verficationId,
                                                    smsCode:
                                                        verificationController
                                                            .text
                                                            .toString());
                                            try {
                                              await auth.signInWithCredential(
                                                credential,
                                              );
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const HomeScreen()));
                                            } catch (e) {
                                              ErrorMessage.toastMessage(
                                                  e.toString());
                                            }
                                          }
                                        }
                                        print("tap");
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const PhoneNoScreen()));
                                      }),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
