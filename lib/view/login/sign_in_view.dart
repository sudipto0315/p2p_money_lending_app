import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/view/login/sign_up_view.dart';
import 'package:p2p_money_lending_app/view/borrower/main_tab/main_tab_view.dart';
import 'package:p2p_money_lending_app/view/lender/main_tab/main_tab_view.dart';
import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/round_dropdown.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/secondary_boutton.dart';

import '../../services/network_service.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isRemember = false;
  String roleForDropdownValue = 'Select';

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/img/app_logo.png",
                  width: media.width * 0.5, fit: BoxFit.contain),
              const Spacer(),
              RoundDropdown(
                title: "Select Role",
                dropdownValue: roleForDropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    roleForDropdownValue = newValue!;
                  });
                },
                items: const ['Select', 'Borrower', 'Lender'],
              ),
              RoundTextField(
                title: "Login",
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
                height: 8,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isRemember = !isRemember;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isRemember
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank_rounded,
                          size: 25,
                          color: TColor.gray50,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(color: TColor.gray50, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password",
                      style: TextStyle(color: TColor.gray50, fontSize: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              PrimaryButton(
                title: "Sign In",
                onPressed: () async {
                  if (roleForDropdownValue == 'Select') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Select a Valid Role'),
                      ),
                    );
                    return;
                  }
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: txtEmail.text,
                        password: txtPassword.text
                    );
                    User? user = userCredential.user;
                    if (user != null && !user.emailVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please verify your email before signing in.'),
                        ),
                      );
                    } else {
                      // Check if the user exists in the Users table
                      List<String> roles = await getUserRole(txtEmail.text);
                      if (!roles.contains(roleForDropdownValue)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid role selected.'),
                          ),
                        );
                        return;
                      }
                      if (roleForDropdownValue == 'Lender') {
                        // Navigate to the Lender's MainTabView if the user is a lender
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LenderMainTabView(email: txtEmail.text, role: roleForDropdownValue),
                          ),
                        );
                      } else if (roleForDropdownValue == 'Borrower') {
                        // Navigate to the Borrower's MainTabView if the user is a borrower
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BorrowerMainTabView(email: txtEmail.text, role: roleForDropdownValue),
                          ),
                        );
                      }
                    }
                  } on FirebaseAuthException catch (e) {
                    String message = 'An error occurred. Please try again.';
                    if (e.code == 'user-not-found') {
                      message = 'No user found for that email.';
                    } else if (e.code == 'wrong-password') {
                      message = 'Wrong password provided for that user.';
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
                "if you don't have an account yet?",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              SecondaryButton(
                title: "Sign up",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
