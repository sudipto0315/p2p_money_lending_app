import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';

import '../../common_widget/custom_arc_painter.dart';
import '../../common_widget/segment_button.dart';
import '../../common_widget/status_button.dart';
import '../../common_widget/subscription_home_row.dart';
// import '../../common_widget/upcoming_bill_row.dart';
import '../settings/settings_view.dart';
import '../subscription_info/subscription_info_view.dart';

class LenderHomeView extends StatefulWidget {
  const LenderHomeView({super.key});

  @override
  LenderHomeViewState createState() => LenderHomeViewState();
}

class LenderHomeViewState extends State<LenderHomeView> {
  bool isSubscription = true;
  List subArr = [
    {
      "name": "Borrower 1",
      "icon": "assets/img/spotify_logo.png",
      "price": "5.99"
    },
    {
      "name": "Borrower 2",
      "icon": "assets/img/youtube_logo.png",
      "price": "18.99"
    },
    {
      "name": "Borrower 3",
      "icon": "assets/img/onedrive_logo.png",
      "price": "29.99"
    },
    {
      "name": "Borrower 4",
      "icon": "assets/img/netflix_logo.png",
      "price": "15.00"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: media.width * 1.1,
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/img/home_bg.png"),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: media.width * 0.05),
                        width: media.width * 0.72,
                        height: media.width * 0.72,
                        child: CustomPaint(
                          painter: CustomArcPainter(end: 220),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingsView()));
                                },
                                icon: Image.asset("assets/img/settings.png",
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Image.asset("assets/img/app_logo.png",
                          width: media.width * 0.25, fit: BoxFit.contain),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      Text(
                        "\$1,235",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: media.width * 0.055,
                      ),
                      Text(
                        "Credit Score",
                        style: TextStyle(
                            color: TColor.gray40,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: TColor.border.withOpacity(0.15),
                            ),
                            color: TColor.gray60.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "7.1",
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: StatusButton(
                                title: "Active Loans",
                                value: "12",
                                statusColor: TColor.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Highest Loan",
                                value: "\$19.99",
                                statusColor: TColor.primary10,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Lowest Loan",
                                value: "\$5.99",
                                statusColor: TColor.secondaryG,
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentButton(
                      title: "Your Loans",
                      isActive: isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SegmentButton(
                      title: "Upcoming bills",
                      isActive: !isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            if (isSubscription)
              ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subArr.length,
                  itemBuilder: (context, index) {
                    var sObj = subArr[index] as Map? ?? {};

                    return SubScriptionHomeRow(
                      sObj: sObj,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionInfoView( sObj: sObj ) ));
                      },
                    );
                  }),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}