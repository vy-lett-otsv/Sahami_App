import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../constants/dimens_manager.dart';

class UITextPrice extends StatelessWidget {
  final double price;
  final double? priceSale;
  final bool isPriceSale;
  final Color color;
  final bool end;

  const UITextPrice(
      {Key? key,
        required this.price,
        this.priceSale,
        this.isPriceSale = false,
        this.color = const Color(0xFF000000),
        this.end = false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = intl.NumberFormat.decimalPattern();
    return isPriceSale
        ? Row(
            mainAxisAlignment: end ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                "${formatter.format(price)} VNĐ",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough),
                textAlign: TextAlign.end,
              ),
              SizedBox(
                width: DimensManager.dimens.setWidth(10),
              ),
              Text(
                "${formatter.format(priceSale)} VNĐ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: color
                ),
                textAlign: TextAlign.end,
              ),
            ],
          )
        : Text(
            "${formatter.format(price)} VNĐ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color
            ),
            textAlign: TextAlign.end,
          );
  }
}
