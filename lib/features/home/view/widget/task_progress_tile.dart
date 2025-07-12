import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/time_util.dart';
import 'package:task_manager/core/utils/utils_class.dart';

class TaskProgressTile extends StatelessWidget {
  const TaskProgressTile({
    super.key,
    required this.taskStatus,
    required this.title,
    required this.progress,
    required this.icon,
  });

  final TaskStatus taskStatus;
  final String title;
  final double progress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      elevation: 0.5,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.2),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  minHeight: 6,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  FunctionLogic.formatTimeAgo(DateTime.now()),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: getStatusChipColor(taskStatus).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getStatusLabel(taskStatus),
            style: TextStyle(
              color: getStatusChipColor(taskStatus),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusLabel(TaskStatus status) {
    switch (status) {
      case TaskStatus.sNew:
        return 'New';
      case TaskStatus.progress:
        return 'Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
      case TaskStatus.upcoming:
      default:
        return 'Upcoming';
    }
  }
}
