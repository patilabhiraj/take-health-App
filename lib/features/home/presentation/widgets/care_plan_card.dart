import 'package:flutter/material.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                      color: const Color(0xffE8F5E9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      color: const Color(0xff5D8B74),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Care Plan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                '$_completedTasks/${widget.tasks.length}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
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
                              ? const Color(0xff5D8B74)
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        color: _taskStates[index]
                            ? const Color(0xff5D8B74)
                            : Colors.transparent,
                      ),
                      child: _taskStates[index]
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
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
                            ? Colors.grey[400]
                            : Colors.black87,
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
              color: const Color(0xffFBF8F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$_remainingTasks TASKS REMAINING',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
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
