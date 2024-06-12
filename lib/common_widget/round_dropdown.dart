import 'package:flutter/material.dart';

import '../common/color_extension.dart';
class RoundDropdown extends StatelessWidget {
  final String title;
  final String dropdownValue;
  final ValueChanged<String?> onChanged;
  final List<String> items;

  const RoundDropdown({
    super.key,
    required this.title,
    required this.dropdownValue,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: TColor.gray50, fontSize: 12),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: TColor.gray60.withOpacity(0.05),
              border: Border.all(color: TColor.gray70),
              borderRadius: BorderRadius.circular(15)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}