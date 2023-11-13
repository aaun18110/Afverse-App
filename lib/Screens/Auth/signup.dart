// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Components/input_field.dart';
import 'package:shopping_app/Components/rounded_button.dart';
import 'package:shopping_app/Response/auth_res.dart';
import 'package:shopping_app/Screens/Auth/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final ValueNotifier<bool> isHidden = ValueNotifier<bool>(true);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool loading = false;
  bool iconVisibilty = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                const Image(image: AssetImage("assets/images/phone.jpg")),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 160),
                  child: Text(
                    'PLEASE CREATE A NEW ACCOUNT.',
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.22,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SingleChildScrollView(
                          child: Form(
                              key: formKey,
                              child: ValueListenableBuilder(
                                valueListenable: isHidden,
                                builder: (context, value, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Signup',
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      MyTextField(
                                        textController: nameController,
                                        obscure: false,
                                        hint: 'Enter Name',
                                        keyboard: TextInputType.text,
                                        icon: const Icon(
                                          Icons.account_box_rounded,
                                          color: Colors.black,
                                        ),
                                        fieldValidator: (val) {
                                          if (val!.isEmpty) {
                                            return 'username required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyTextField(
                                        textController: emailController,
                                        obscure: false,
                                        hint: 'Enter Email',
                                        keyboard: TextInputType.emailAddress,
                                        icon: const Icon(
                                          Icons.email,
                                          color: Colors.black,
                                        ),
                                        fieldValidator: (val) {
                                          if (val!.isEmpty) {
                                            return 'email required';
                                          } else if (!val.contains("@") ||
                                              !val.contains('.')) {
                                            return 'sample@gmail.com';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyTextField(
                                        textController: phoneController,
                                        obscure: false,
                                        hint: 'Enter Phone no',
                                        keyboard: TextInputType.emailAddress,
                                        icon: const Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                        ),
                                        fieldValidator: (val) {
                                          if (val!.isEmpty) {
                                            return 'phone required';
                                          } else if (val.length <= 13) {
                                            return '+923098500345';
                                          } else if (!val.contains("+")) {
                                            return '+ is missing';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyTextField(
                                        textController: passwordController,
                                        keyboard: TextInputType.text,
                                        obscure: isHidden.value,
                                        hint: 'Enter Password',
                                        icon: const Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        suffix: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isHidden.value = !isHidden.value;
                                            });
                                          },
                                          icon: Icon(isHidden.value
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        fieldValidator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Password Required';
                                          } else if (val.length <= 5) {
                                            return 'Maximum use 6 Character';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      RoundedButton(
                                          title: 'Sign up',
                                          color: const Color.fromARGB(
                                              116, 1, 139, 194),
                                          loading: loading,
                                          onPress: () async {
                                            print("tap");
                                            if (formKey.currentState!
                                                .validate()) {
                                              AuthResponse.userSignup(
                                                  context,
                                                  emailController.text
                                                      .toString(),
                                                  passwordController.text
                                                      .toString(),
                                                  phoneController.text
                                                      .toString(),
                                                  nameController.text
                                                      .toString());
                                            }
                                            SharedPreferences sp =
                                                await SharedPreferences
                                                    .getInstance();
                                            sp.setString('username',
                                                nameController.text.toString());
                                          }),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()));
                                          },
                                          child: RichText(
                                              text: TextSpan(
                                                  text:
                                                      "Don't have an Account?  ",
                                                  style: GoogleFonts.aleo(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                  children: [
                                                TextSpan(
                                                    text: "Login",
                                                    style: GoogleFonts.roboto(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]))),
                                    ],
                                  );
                                },
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
