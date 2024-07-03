import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:p2p_money_lending_app/common_widget/secondary_boutton.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/item_row.dart';

class InvestmentInfoView extends StatefulWidget {
  final Map iObj;
  const InvestmentInfoView({super.key, required this.iObj});

  @override
  State<InvestmentInfoView> createState() => _InvestmentInfoViewState();
}

class _InvestmentInfoViewState extends State<InvestmentInfoView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff282833).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child:
                Column(
                  children: [
                    Container(
                      height: media.width * 0.9,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: TColor.gray70,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Investment Info",
                                    style: TextStyle(
                                        color: TColor.gray30, fontSize: 16
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            widget.iObj["icon"],
                            width: media.width * 0.25,
                            height: media.width * 0.25,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.iObj["name"],
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "\$${widget.iObj["price"]}",
                            style: TextStyle(
                                color: TColor.gray30,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: TColor.border.withOpacity(0.1),
                              ),
                              color: TColor.gray60.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                ItemRow(
                                  title: "Lended To",
                                  value: widget.iObj["name"],
                                ),
                                const ItemRow(
                                  title: "Issue Date",
                                  value: "08.07.2023",
                                ),
                                const ItemRow(
                                  title: "Deadline",
                                  value: "08.07.2025",
                                ),
                                const ItemRow(
                                  title: "Repayment date",
                                  value: "06.02.2024",
                                ),
                                const ItemRow(
                                  title: "Reminder",
                                  value: "Never",
                                ),
                                const ItemRow(
                                  title: "ROI",
                                  value: "5 %",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SecondaryButton(title: "Return", onPressed: () {
                            Navigator.pop(context);
                          })
                        ],
                      ),
                    )
                  ],
                ),


              ),

              Container(
                margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
                height: media.width * 0.9 + 15,
                alignment: Alignment.bottomCenter,
                child: Row(children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: TColor.gray,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Expanded(
                      child: DottedBorder(
                        dashPattern: const [5, 10],
                        padding: EdgeInsets.zero,
                        strokeWidth: 1,
                        radius: const Radius.circular(16),
                        color: TColor.gray,
                        child: const SizedBox(
                          height: 0,
                        ),
                      )),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: TColor.gray,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
