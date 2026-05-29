import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class CarePlanCard extends StatefulWidget {
  final List<CarePlanTask> tasks;
  final VoidCallback? onTaskToggle;

  const CarePlanCard({
    super.key,
    required this.tasks,
    this.onTaskToggle,
  });

  @override
  State<CarePlanCard> createState() => _CarePlanCardState();
}

class _CarePlanCardState extends State<CarePlanCard> {
  late List<bool> _taskStates;

  @override
  void initState() {
    super.initState();
    _taskStates = List.generate(widget.tasks.length, (index) => false);
  }

  int get _completedTasks => _taskStates.where((state) => state).length;
  int get _remainingTasks => widget.tasks.length - _completedTasks;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cs.outline.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: context.cShadow,
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.cPrimarySurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      color: cs.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Care Plan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
              Text(
                '$_completedTasks/${widget.tasks.length}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Task List
          ...List.generate(widget.tasks.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _taskStates[index] = !_taskStates[index];
                      });
                      widget.onTaskToggle?.call();
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _taskStates[index]
                              ? cs.primary
                              : cs.outline,
                          width: 2,
                        ),
                        color: _taskStates[index]
                            ? cs.primary
                            : Colors.transparent,
                      ),
                      child: _taskStates[index]
                          ? Icon(
                              Icons.check,
                              size: 16,
                              color: cs.onPrimary,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.tasks[index].title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _taskStates[index]
                            ? cs.onSurfaceVariant
                            : cs.onSurface,
                        decoration: _taskStates[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 8),

          // Remaining Tasks
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: context.cWarmSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$_remainingTasks TASKS REMAINING',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: cs.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarePlanTask {
  final String title;

  const CarePlanTask({required this.title});
}
