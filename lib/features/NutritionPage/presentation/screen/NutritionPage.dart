import 'package:flutter/material.dart';
import '../widgets/nutrition_calorie_card.dart';
import '../widgets/nutrition_diet_quality_card.dart';
import '../widgets/nutrition_hydration_card.dart';
import '../widgets/nutrition_insight_card.dart';
import '../widgets/nutrition_meal_section.dart';
import '../widgets/nutrition_recent_frequent_card.dart';
import '../widgets/nutrition_weekly_trends_card.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NutritionCalorieCard(),
          const SizedBox(height: 16),
          const NutritionInsightCard(),
          const SizedBox(height: 24),
          NutritionMealSection(date: DateTime.now()),
          const SizedBox(height: 24),
          const NutritionDietQualityCard(),
          const SizedBox(height: 16),
          const NutritionRecentFrequentCard(
            frequentFoods: ['Oats', 'Eggs', 'Rice'],
          ),
          const SizedBox(height: 16),
          const NutritionHydrationCard(),
          const SizedBox(height: 16),
          const NutritionWeeklyTrendsCard(),
        ],
      ),
    );
  }
}
