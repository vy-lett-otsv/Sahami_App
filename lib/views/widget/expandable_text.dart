import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = DimensManager.dimens.setHeight(100);

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt(), widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? UIText(firstHalf)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIText(hiddenText
                    ? ("$firstHalf...")
                    : (firstHalf + secondHalf),),
                SizedBox(height: DimensManager.dimens.setHeight(10),),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: hiddenText ?  Row(
                    children: [
                      UIText(UIStrings.showMore, color: UIColors.primary,),
                      Icon(Icons.arrow_drop_down, color: UIColors.primary,)
                    ],
                  ) :
                  Row(
                    children: [
                      UIText(UIStrings.showLess, color: UIColors.primary,),
                      Icon(Icons.arrow_drop_up, color: UIColors.primary,)
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
