import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';
import 'package:p2p_money_lending_app/common_widget/primary_button.dart';
import 'package:p2p_money_lending_app/common_widget/round_textfield.dart';
import 'package:p2p_money_lending_app/common_widget/round_dropdown.dart';
import 'package:p2p_money_lending_app/view/login/user_KYC_details_view.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final TextEditingController txtFirstName = TextEditingController();
  final TextEditingController txtLastName = TextEditingController();
  final TextEditingController txtDateOfBirth = TextEditingController();
  final TextEditingController txtPhoneNumber = TextEditingController();
  final TextEditingController txtAddress = TextEditingController();

  String genderDropdownValue = 'Select'; // Define dropdownValue
  String maritalStatusDropdownValue = 'Select'; // Define dropdownValue
  String occupationDropdownValue = 'Select'; // Define dropdownValue

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
                  title: "First Name",
                  controller: txtFirstName,
                ),
                const SizedBox(height: 20),
                RoundTextField(
                  title: "Last Name",
                  controller: txtLastName,
                ),
                const SizedBox(height: 20),
                RoundDropdown(
                  title: "Gender",
                  dropdownValue: genderDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      genderDropdownValue = newValue!;
                    });
                  },
                  items: const ['Select', 'Male', 'Female', 'Others'],
                ),
                const SizedBox(height: 20),
                RoundDropdown(
                  title: "Marital Status",
                  dropdownValue: maritalStatusDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      maritalStatusDropdownValue = newValue!;
                    });
                  },
                  items: const ['Select', 'Married', 'Un-Married'],
                ),
                const SizedBox(height: 20),
                RoundTextField(
                  title: "Date of Birth",
                  controller: txtDateOfBirth,
                ),
                const SizedBox(height: 20),
                RoundTextField(
                  title: "Phone Number",
                  controller: txtPhoneNumber,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                RoundDropdown(
                  title: "Occupation",
                  dropdownValue: occupationDropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      occupationDropdownValue = newValue!;
                    });
                  },
                  items: const ['Select', 'Organised', 'Un-Organised'],
                ),
                const SizedBox(height: 20),
                RoundTextField(
                  title: "Address",
                  controller: txtAddress,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  title: "Submit",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserKYCDetailsView(),
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