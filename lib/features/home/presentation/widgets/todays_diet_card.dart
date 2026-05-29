import 'package:flutter/material.dart';

class TodaysDietCard extends StatefulWidget {
  final VoidCallback? onViewFullPlan;

  const TodaysDietCard({
    super.key,
    this.onViewFullPlan,
  });

  @override
  State<TodaysDietCard> createState() => _TodaysDietCardState();
}

class _TodaysDietCardState extends State<TodaysDietCard> {
  String selectedMeal = 'LUNCH';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Diet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Fri, 29 May 2026",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Meal Type Selector
          Row(
            children: [
              _MealTypeChip(
                label: 'BREAKFAST',
                isSelected: selectedMeal == 'BREAKFAST',
                onTap: () => setState(() => selectedMeal = 'BREAKFAST'),
              ),
              const SizedBox(width: 10),
              _MealTypeChip(
                label: 'LUNCH',
                isSelected: selectedMeal == 'LUNCH',
                onTap: () => setState(() => selectedMeal = 'LUNCH'),
              ),
              const SizedBox(width: 10),
              _MealTypeChip(
                label: 'DINNER',
                isSelected: selectedMeal == 'DINNER',
                onTap: () => setState(() => selectedMeal = 'DINNER'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // No Plan State
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: const Color(0xffFBF8F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.restaurant_outlined,
                    color: const Color(0xff5D8B74),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'NO PLAN TODAY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // View Full Plan Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onViewFullPlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6BAF92),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Full Plan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealTypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MealTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff6BAF92) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
