import 'package:flutter/material.dart';

class NutritionInsightCard extends StatelessWidget {
  final String message;
  final VoidCallback? onAiAnalysis;

  const NutritionInsightCard({
    super.key,
    this.message = 'Analyzing your eating patterns...',
    this.onAiAnalysis,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4EB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFD4A3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE2C4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFD4730A),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NUTRITION\nINSIGHT',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF7A4010),
                        height: 1.25,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onAiAnalysis,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: cs.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'AI ANALYSIS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7A4010),
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
