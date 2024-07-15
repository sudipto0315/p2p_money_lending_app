import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';
import 'package:p2p_money_lending_app/common_widget/primary_button.dart';
import 'package:p2p_money_lending_app/common_widget/round_textfield.dart';
import 'package:p2p_money_lending_app/services/borrower_network_service.dart';

import '../../../common_widget/image_button.dart';

class LoanRequestView extends StatefulWidget {
  final String email;
  final String role;
  const LoanRequestView({super.key, required this.email, required this.role});

  @override
  State<LoanRequestView> createState() => _LoanRequestViewState();
}

class _LoanRequestViewState extends State<LoanRequestView> {
  int? selectedTenure;
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtTenure = TextEditingController();

  List subArr = [
    {"name": "Personal Loan", "icon": "assets/img/hbo_logo.png"},
    {"name": "Medical Loan", "icon": "assets/img/spotify_logo.png"},
    {"name": "Education Loan", "icon": "assets/img/youtube_logo.png"},
    {
      "name": "Agricultural/ \nBusiness Loan",
      "icon": "assets/img/onedrive_logo.png",
    },
    {"name": "House Loan", "icon": "assets/img/netflix_logo.png"}
  ];

  @override
  void initState() {
    super.initState();
    txtAmount.text = "1000.00"; // Initial amount value
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New",
                              style:
                                  TextStyle(color: TColor.gray30, fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Add New Loan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.6,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.65,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        ),
                        itemCount: subArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var sObj = subArr[itemIndex] as Map? ?? {};

                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  sObj["icon"],
                                  width: media.width * 0.4,
                                  height: media.width * 0.4,
                                  fit: BoxFit.fitHeight,
                                ),
                                const Spacer(),
                                Text(
                                  sObj["name"],
                                  style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: RoundTextField(
                  title: "Description",
                  titleAlign: TextAlign.center,
                  controller: txtDescription,
                )),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tenure",
                    textAlign: TextAlign.center, // Moved outside of TextStyle
                    style: TextStyle(
                      color: TColor.gray50,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    height: 100, // Set a fixed height for the picker
                    decoration: BoxDecoration(
                      color: TColor.gray60.withOpacity(0.05), // Background color similar to RoundTextField
                      border: Border.all(color: TColor.gray70), // Border color
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: CupertinoPicker(
                      magnification: 1.22,
                      diameterRatio: 1.1,
                      backgroundColor: Colors.transparent, // Transparent background inside the picker
                      itemExtent: 32, // Height of each item
                      onSelectedItemChanged: (int value) {
                        setState(() {
                          selectedTenure = value + 1; // Adjust based on your list's indexing
                        });
                      },
                      children: List<Widget>.generate(24, (int index) {
                        return Center(
                          child: Text(
                            '${index + 1} months',
                            style: TextStyle(
                              color: TColor.white, // Text color similar to RoundTextField
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageButton(
                    image: "assets/img/minus.png",
                    onPressed: () {
                      double amountVal = double.tryParse(txtAmount.text) ?? 0.0;
                      amountVal -= 1000;

                      if (amountVal < 0) {
                        amountVal = 0;
                      }

                      txtAmount.text = amountVal.toStringAsFixed(2);
                      setState(() {});
                    },
                  ),

                  Column(
                    children: [
                      Text(
                        "Total amount",
                        style: TextStyle(
                            color: TColor.gray40,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: txtAmount,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '₹0.00',
                            hintStyle: TextStyle(
                                color: TColor.gray70,
                                fontSize: 40,
                                fontWeight: FontWeight.w700),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 150,
                        height: 1,
                        color: TColor.gray70,
                      )
                    ],
                  ),

                  ImageButton(
                    image: "assets/img/plus.png",
                    onPressed: () {
                      double amountVal = double.tryParse(txtAmount.text) ?? 0.0;
                      amountVal += 1000;

                      txtAmount.text = amountVal.toStringAsFixed(2);
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                  title: "Submit Loan Request",
                  onPressed: () async {
                    if(selectedTenure != null && txtAmount.text.isNotEmpty && txtDescription.text.isNotEmpty) {
                      try{
                        // Fetch BorrowerID using UserID
                        print('Email: ${widget.email}');
                        print('Role: ${widget.role}');
                        String userID = await BorrowerNetworkService().getUserIDWithEmailAndRole(widget.email, widget.role);
                        if(kDebugMode){
                          print('UserID: $userID');
                        }
                        String borrowerID = await BorrowerNetworkService().fetchBorrowerID(userID);
                        if(kDebugMode){
                          print('BorrowerID: $borrowerID');
                        }
                        // Call the submitLoanRequest method from BorrowerNetworkServ ice
                        await BorrowerNetworkService().submitLoanRequest(
                          borrowerID,
                          txtAmount.text.trim(),
                          txtDescription.text.trim(),
                          selectedTenure!,
                        );
                        // If the submission is successful, show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Loan Request submitted')),
                        );
                      } catch(e) {
                        // If the submission fails, show an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to submit loan')),
                        );
                      }
                    } else {
                      // If any of the fields are empty, show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
