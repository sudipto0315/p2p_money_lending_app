import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';
import 'package:p2p_money_lending_app/common_widget/primary_button.dart';
import 'package:p2p_money_lending_app/common_widget/round_textfield.dart';
import 'package:p2p_money_lending_app/common_widget/round_dropdown.dart';
import 'package:p2p_money_lending_app/view/login/sign_in_view.dart';

class UserKYCDetailsView extends StatefulWidget {
  const UserKYCDetailsView({super.key});

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
                const SizedBox(height: 20),
                PrimaryButton(
                  title: "Submit",
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
    );
  }
}