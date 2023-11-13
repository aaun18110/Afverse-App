import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/Components/input_field.dart';
import 'package:shopping_app/Components/rounded_button.dart';
import 'package:shopping_app/Utils/Routes/routes_name.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final fromkey = GlobalKey<FormState>();
  final forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(116, 1, 139, 194).withOpacity(20),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/verify.png'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.30,
                  ),
                  Expanded(
                    flex: 2,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                            'Forgot Password',
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: MyTextField(
                                      hint: 'Enter Email',
                                      icon: const Icon(
                                        Icons.email_rounded,
                                        color: Colors.black,
                                      ),
                                      textController: forgotPasswordController,
                                      keyboard: TextInputType.number,
                                      readOnly: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  RoundedButton(
                                    title: 'Send',
                                    color:
                                        const Color.fromARGB(116, 1, 139, 194),
                                    onPress: () {
                                      if (fromkey.currentState!.validate()) {}
                                    },
                                  )
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
