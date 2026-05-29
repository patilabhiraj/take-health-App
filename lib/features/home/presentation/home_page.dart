import 'package:flutter/material.dart';
import 'package:take_health/features/ai_chat/ai_chat_page.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onViewFullPlan;
  final VoidCallback? onUploadReport;
  final VoidCallback? onNutrition;

  const HomePage({
    super.key,
    this.onViewFullPlan,
    this.onUploadReport,
    this.onNutrition,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          /// AI SEARCH BAR
          AiSearchBar(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AiChatPage()),
            ),
            hintText: "What should I eat for dinner?",
          ),

          const SizedBox(height: 16),

    
          /// OPTIMIZE HEALTH CARD
          HealthOptimizeCard(
            onCompleteProfile: () {
              // Navigate to profile completion
            },
            onUploadReport: onUploadReport,
          ),

          const SizedBox(height: 16),

          /// CALORIES CARD
          CaloriesCard(
            currentCalories: 0,
            targetCalories: 3335,
            protein: 18,
            carbs: 68,
            fats: 9,
            onViewDetails: () {
              // Navigate to nutrient details
            },
          ),

          const SizedBox(height: 16),

          /// TODAY'S DIET CARD
          TodaysDietCard(
            onViewFullPlan: onViewFullPlan,
          ),

          const SizedBox(height: 16),

          /// LAB INSIGHTS CARD
          LabInsightsCard(
            onUploadReport: onUploadReport,
          ),

          const SizedBox(height: 16),

          /// LOGGED MEALS CARD
          LoggedMealsCard(
            onLogMeal: () {
              // Navigate to meal logging
            },
            onViewMenu: () {
              // Navigate to menu
            },
          ),

          const SizedBox(height: 16),

          /// NUTRITION DEFICIENCY CARD
          NutritionDeficiencyCard(
            onUploadReport: onUploadReport,
            onViewDetails: onNutrition,
          ),
          /// CARE PLAN CARD
          CarePlanCard(
            tasks: const [
              CarePlanTask(title: 'DRINK 3L WATER'),
              CarePlanTask(title: 'MORNING WALK 20 MINS'),
              CarePlanTask(title: 'TAKE MULTIVITAMINS'),
              CarePlanTask(title: '8 HOURS SLEEP'),
            ],
            onTaskToggle: () {
              // Handle task toggle
            },
          ),
          const SizedBox(height: 16),

          const SizedBox(height: 16),

          /// STEP COUNTER CARD
          StepCounterCard(
            stepsToday: 0,
            caloriesBurned: 0,
            targetCalories: 7000,
            onTap: () {
              // Navigate to step counter details
            },
          ),
          /// SMOKE LOG CARD
          SmokeLogCard(
            onTap: () {
              // Navigate to smoke log
            },
          ),
  const SizedBox(height: 16),

          /// DRINK LOG CARD
          DrinkLogCard(
            onTap: () {
              // Navigate to drink log
            },
          ),

          const SizedBox(height: 16),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
