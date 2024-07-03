import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/icon_item_row.dart';
import '../../login/sign_in_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset("assets/img/back.png",
                            width: 25, height: 25, color: TColor.gray30))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(color: TColor.gray30, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/u1.png",
                  width: 70,
                  height: 70,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Name Goes Here",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser?.email??"anonymous.example.com",
                  style: TextStyle(
                      color: TColor.gray30,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 8),
                    child: Text(
                      "General",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColor.border.withOpacity(0.1),
                      ),
                      color: TColor.gray60.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person, color: TColor.gray20),
                          title: Text("Personal Information", style: TextStyle(color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        ListTile(
                          leading: Icon(Icons.email, color: TColor.gray20),
                          title: Text("Notifications & Emails", style: TextStyle(color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        ListTile(
                          leading: Icon(Icons.security, color: TColor.gray20),
                          title: Text("Privacy & Security", style: TextStyle(color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        SwitchListTile(
                          value: isActive,
                          onChanged: (newVal) {
                            setState(() {
                              isActive = newVal;
                            });
                          },
                          title: Text("AutoPay", style: TextStyle(color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          secondary: Icon(Icons.payment, color: TColor.gray20),
                        ),
                        ListTile(
                          leading: Icon(Icons.lock, color: TColor.gray20),
                          title: Text("Lock App", style: TextStyle(color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          subtitle: Text("Biometric", style: TextStyle(color: TColor.gray30, fontSize: 12, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    child: Text(
                      "Support",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColor.border.withOpacity(0.1),
                      ),
                      color: TColor.gray60.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.info, color: TColor.gray20),
                          title: Text("About", style: TextStyle(color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          subtitle: Text("About Us", style: TextStyle(color: TColor.gray30, fontSize: 12, fontWeight: FontWeight.w500)),
                        ),
                        ListTile(
                          leading: Icon(Icons.help, color: TColor.gray20),
                          title: Text("Help & Feedback", style: TextStyle(color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          subtitle: Text("Help Center", style: TextStyle(color: TColor.gray30, fontSize: 12, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    child: Text(
                      "Appearance",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TColor.border.withOpacity(0.1),
                      ),
                      color: TColor.gray60.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        IconItemRow(
                          title: "App icon",
                          icon: "assets/img/app_icon.png",
                          value: "Default",
                        ),
                        IconItemRow(
                          title: "Theme",
                          icon: "assets/img/light_theme.png",
                          value: "Dark",
                        ),
                        IconItemRow(
                          title: "Font",
                          icon: "assets/img/font.png",
                          value: "Inter",
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    child: Text(
                      "Account",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                      child:ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red, backgroundColor: Colors.white, // Text and icon color
                          side: const BorderSide(color: Colors.red, width: 2), // Border color and width
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Border radius
                          ),
                        ),
                        icon: const Icon(Icons.logout), // Logout symbol
                        label: const Text('Logout'), // Text
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInView(),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error signing out. Try again.'),
                              ),
                            );
                          }
                        },
                      )
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
