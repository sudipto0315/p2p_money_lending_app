import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/view/login/sign_in_view.dart';
import 'package:p2p_money_lending_app/view/login/user_details_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/secondary_boutton.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              height: media.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/img/app_logo.png",
                      width: media.width * 0.5, fit: BoxFit.contain),
                  const Spacer(),
                  RoundTextField(
                    title: "E-mail address",
                    controller: txtEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundTextField(
                    title: "Password",
                    controller: txtPassword,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: TColor.gray70,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: TColor.gray70,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: TColor.gray70,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: TColor.gray70,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Use 8 or more characters with a mix of letters,\nnumbers & symbols.",
                        style: TextStyle(color: TColor.gray50, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    title: "Get started, it's free!",
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: txtEmail.text,
                                password: txtPassword.text);
                        User? user = userCredential.user;
                        if (user != null && !user.emailVerified) {
                          await user.sendEmailVerification();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Verification email sent. Please check your email.'),
                            ),
                          );
                          // Navigate to SignInView after sending the verification email
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserDetailsView(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        String message = 'An error occurred. Please try again.';
                        if (e.code == 'weak-password') {
                          message = 'The password provided is too weak.';
                        } else if (e.code == 'email-already-in-use') {
                          message =
                              'The account already exists for that email.';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                  ),
                  const Spacer(),
                  Text(
                    "Do you have already an account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.white, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecondaryButton(
                    title: "Sign in",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
