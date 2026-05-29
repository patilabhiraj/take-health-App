import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  final int totalSteps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isActive = index <= currentStep;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index < totalSteps - 1 ? 6 : 0),
              height: 4,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.lightMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}
