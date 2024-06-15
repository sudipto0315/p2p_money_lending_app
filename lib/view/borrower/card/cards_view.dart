import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';
import 'package:p2p_money_lending_app/view/borrower/settings/settings_view.dart';

class LoanOffer {
  final String lenderName;
  final double amount;
  final double interestRate;
  final int tenure;

  LoanOffer({
    required this.lenderName,
    required this.amount,
    required this.interestRate,
    required this.tenure,
  });
}

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  List<LoanOffer> loanOffers = [
    LoanOffer(lenderName: "Lender 1", amount: 5000, interestRate: 5.5, tenure: 12),
    LoanOffer(lenderName: "Lender 2", amount: 10000, interestRate: 4.5, tenure: 24),
    // Add more loan offers...
  ];

  SwiperController controller = SwiperController();

  Widget buildSwiper() {
    return Swiper(
      itemCount: loanOffers.length,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
        ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
        ..addTranslate([
          const Offset(-370.0, -40.0),
          Offset.zero,
          const Offset(370.0, -40.0),
        ]),
      fade: 1.0,
      onIndexChanged: (index) {
        if (kDebugMode) {
          print(index);
        }
      },
      scale: 0.8,
      itemWidth: 232.0,
      itemHeight: 350,
      controller: controller,
      layout: SwiperLayout.STACK,
      viewportFraction: 0.8,
      itemBuilder: ((context, index) {
        var loanOffer = loanOffers[index];
        return Container(
          decoration: BoxDecoration(
              color: TColor.gray70,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 4)
              ]),
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(
              "assets/img/card_blank.png",
              width: 232.0,
              height: 350,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset("assets/img/mastercard_logo.png", width: 50),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Loan Offer",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 115,
                ),
                Text(
                  loanOffer.lenderName,
                  style: TextStyle(
                      color: TColor.gray20,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  loanOffer.amount.toString(),
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${loanOffer.interestRate}% interest",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "${loanOffer.tenure} months",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ]),
        );
      }),
      autoplayDisableOnInteraction: false,
      axisDirection: AxisDirection.right,
    );
  }

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: double.infinity,
              height: 600,
              child: buildSwiper(),
            ),
            Column(
              children: [
                SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Loan Offers",
                            style:
                                TextStyle(color: TColor.gray30, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
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
                                  width: 25, height: 25, color: TColor.gray30))
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 480,
                ),

                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: TColor.gray70.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),

                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {},
                          child: DottedBorder(
                            dashPattern: const [5, 4],
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(16),
                            color: TColor.border.withOpacity(0.1),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add new offer",
                                    style: TextStyle(
                                        color: TColor.gray30,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Image.asset(
                                    "assets/img/add.png",
                                    width: 12,
                                    height: 12,
                                    color: TColor.gray30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}