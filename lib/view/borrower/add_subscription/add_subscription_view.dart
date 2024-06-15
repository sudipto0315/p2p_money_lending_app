import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';
import 'package:p2p_money_lending_app/common_widget/primary_button.dart';
import 'package:p2p_money_lending_app/common_widget/round_textfield.dart';

import '../../../common_widget/image_button.dart';

class AddSubScriptionView extends StatefulWidget {
  const AddSubScriptionView({super.key});

  @override
  State<AddSubScriptionView> createState() => _AddSubScriptionViewState();
}

class _AddSubScriptionViewState extends State<AddSubScriptionView> {
  TextEditingController txtDescription = TextEditingController();

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

  double amountVal = 0.09;

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
                        "Add new\n Loan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
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
              child: RoundTextField(title: "Description", titleAlign: TextAlign.center, controller: txtDescription, )

            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageButton(
                    image: "assets/img/minus.png",
                    onPressed: () {

                      amountVal -= 0.1;

                      if(amountVal < 0) {
                        amountVal = 0;
                      }

                      setState(() {
                        
                      });
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

                     const SizedBox(height: 4,),

                       Text(
                        "\$${amountVal.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
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
                      amountVal += 0.1;

                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  PrimaryButton(title: "Add this platform", onPressed: () {}),
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
