import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BuildProgressCard extends StatelessWidget {
  const BuildProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    const progress = 0.7;
    final completedText = "${(progress * 5).round()} of 5 tasks completed";
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      elevation: 0.5,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 8.0,
              percent: progress,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 3000,
              center: Text("${(progress * 100).toInt()}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
              progressColor: Theme.of(context).colorScheme.primary,
              backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    (progress * 100 >= 60 && progress * 100 <= 99)
                        ? "You're almost there!"
                        : "Today's Progress",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (progress * 100 >= 60 && progress * 100 <= 99)
                        ? "Keep going and complete your tasks today"
                        : completedText,
                    style:
                    TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
