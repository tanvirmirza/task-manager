import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressBox extends StatelessWidget {
  final Color centerTextColor;
  final String centerText;
  final Color progressColor;
  final String footerText;
  final double percent;
  const ProgressBox({
    super.key,
    required this.progressColor,
    required this.centerTextColor,
    required this.footerText,
    required this.centerText,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(blurRadius: 4, color: Colors.black12, offset: Offset(0, 2)),
        ], borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 8.0,
            percent: percent,
            center: Text(centerText,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: centerTextColor)),
            progressColor: progressColor,
            backgroundColor: Colors.grey.shade300,
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 1200,
            footer: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(footerText,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
