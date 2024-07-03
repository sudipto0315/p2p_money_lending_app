import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class BorrowerCell extends StatelessWidget {
  final Map borrower;
  final VoidCallback onPressed;

  const BorrowerCell(
      {super.key, required this.borrower, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: TColor.border.withOpacity(0.1),
          ),
          color: TColor.gray60.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Image.asset(
              borrower["icon"],
              width: 45,
              height: 45,
            ),
            const Spacer(),
            Text(
              borrower["name"],
              style: TextStyle(
                  color: TColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "\$${borrower["price"]}",
              style: TextStyle(
                  color: TColor.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
