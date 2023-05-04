import 'package:flutter/material.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../constants/ui_color.dart';

class StatisticsHeaderWidget extends StatelessWidget {
  final String title;
  final String dropdownValue;
  final Function(String? value) onChange;
  final List<String> list;

  const StatisticsHeaderWidget(
      {Key? key,
      required this.title,
      required this.dropdownValue,
      required this.onChange,
        required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        UITitle(title, fontWeight: FontWeight.w500),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: UIColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
              underline: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide.none),
                ),
              ),
              items:
                  list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: const TextStyle(color: UIColors.white)),
                );
              }).toList(),
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down, color: UIColors.white),
              dropdownColor: UIColors.primarySecond,
              onChanged: onChange
          ),
        )
      ]),
    );
  }
}
