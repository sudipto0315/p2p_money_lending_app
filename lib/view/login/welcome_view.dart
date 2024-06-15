import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2p_money_lending_app/view/lender/home/home_view.dart';
import 'package:p2p_money_lending_app/view/login/sign_in_view.dart';
import 'package:p2p_money_lending_app/view/login/social_login.dart';
import 'package:p2p_money_lending_app/view/login/test_data_view.dart';
import 'package:p2p_money_lending_app/view/login/user_details_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/secondary_boutton.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "assets/img/welcome_screen.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/img/app_logo.png",
                      width: media.width * 0.5, fit: BoxFit.contain),
                  const Spacer(),
                  Text(
                    "This is a prototype app for P2P Money Lending and Borrowing",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.white, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    title: "Get started",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SocialLoginView(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SecondaryButton(
                    title: "I have an account",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInView(),
                        ),
                      );
                    },
                  ),
                  SecondaryButton(
                    title: "User Details",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserDetailsView(),
                        ),
                      );
                    },
                  ),
                  SecondaryButton(
                    title: "Test data",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestDataView(),
                        ),
                      );
                    },
                  ),
                  // Lender View (Testing Purpose)
                  SecondaryButton(
                    title: "Lender",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
