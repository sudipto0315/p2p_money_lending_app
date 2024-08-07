import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';
import 'package:p2p_money_lending_app/common_widget/primary_button.dart';
import 'package:p2p_money_lending_app/common_widget/round_textfield.dart';
import 'package:p2p_money_lending_app/view/login/sign_in_view.dart';

import '../../services/network_service.dart';

class UserKYCDetailsView extends StatefulWidget {
  final String UserID;
  const UserKYCDetailsView({super.key, required this.UserID});

  @override
  State<UserKYCDetailsView> createState() => _UserKYCDetailsViewState();
}

class _UserKYCDetailsViewState extends State<UserKYCDetailsView> {
  final TextEditingController txtAadhaarNumber = TextEditingController();
  final TextEditingController txtPANNumber = TextEditingController();
  final TextEditingController txtBankAccountNumber = TextEditingController();

  String roleForDropdownValue = 'Select'; // Define dropdownValue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundTextField(
                  title: "Aadhaar Number",
                  controller: txtAadhaarNumber,
                ),
                const SizedBox(height: 20),
                RoundTextField(
                  title: "PAN Number",
                  controller: txtPANNumber,
                ),
                const SizedBox(height: 20),
                RoundTextField(
                  title: "Bank Account Number",
                  controller: txtBankAccountNumber,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  title: "Submit",
                  onPressed: () {
                    sendKYCDetailsToServer(
                      widget.UserID,
                      txtAadhaarNumber.text,
                      txtPANNumber.text,
                      txtBankAccountNumber.text,
                    );
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
    );
  }
}
