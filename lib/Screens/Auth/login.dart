// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Components/input_field.dart';
import 'package:shopping_app/Components/rounded_button.dart';
import 'package:shopping_app/Components/social_auth.dart';
import 'package:shopping_app/Response/auth_res.dart';
import 'package:shopping_app/Screens/Auth/phone_no.dart';
import 'package:shopping_app/Screens/Auth/signup.dart';
import 'package:shopping_app/Utils/Routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> isHidden = ValueNotifier<bool>(true);

  final auth = FirebaseAuth.instance;
  final fromkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool iconVisibilty = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;

    final authRes = AuthResponse();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const Stack(
              children: [
                Image(image: AssetImage("assets/images/login.jpg")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.20,
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
                          horizontal: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                              key: fromkey,
                              child: ValueListenableBuilder(
                                valueListenable: isHidden,
                                builder: (context, value, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Login',
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      MyTextField(
                                        textController: emailController,
                                        keyboard: TextInputType.emailAddress,
                                        obscure: false,
                                        hint: ' Enter Email',
                                        icon: const Icon(
                                          Icons.account_box_rounded,
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
                                        height: 20,
                                      ),
                                      MyTextField(
                                        textController: passwordController,
                                        keyboard: TextInputType.text,
                                        hint: 'Enter Password',
                                        icon: const Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        obscure: isHidden.value,
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
                                            return 'password required';
                                          } else if (val.length < 6) {
                                            return 'Maximum use 6 Character';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    RoutesName.passwordScreeen);
                                              },
                                              child: const Text(
                                                  "Forgot Password?"))),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RoundedButton(
                                          title: 'Login',
                                          color: const Color.fromARGB(
                                              116, 1, 139, 194),
                                          onPress: () async {
                                            if (fromkey.currentState!
                                                .validate()) {
                                              authRes.userLogin(
                                                  emailController.text
                                                      .toString(),
                                                  passwordController.text
                                                      .toString(),
                                                  context);
                                              SharedPreferences sp =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var username =
                                                  sp.getString('username') ??
                                                      " ";
                                              sp.setString(
                                                  'email',
                                                  emailController.text
                                                      .toString());
                                              sp.setString('username',
                                                  username.toString());
                                              print(emailController.text
                                                  .toString());
                                              print(username);
                                            }
                                          }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SignupScreen()));
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
                                                    text: "Sign up",
                                                    style: GoogleFonts.roboto(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]))),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SocialButton(
                                            onPress: () {
                                              authRes.signInWithGoogle(context);
                                            },
                                            url: "assets/social/google.png",
                                          ),
                                          SocialButton(
                                            onPress: () {
                                              authRes
                                                  .signInWithFacebook(context);
                                            },
                                            url: "assets/social/facebook.png",
                                          ),
                                          SocialButton(
                                            onPress: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const PhoneNoScreen()));
                                            },
                                            url: "assets/social/phone.png",
                                          ),
                                        ],
                                      )
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
