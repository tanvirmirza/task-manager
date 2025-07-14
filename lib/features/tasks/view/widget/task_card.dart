import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/time_util.dart';
import 'package:task_manager/core/utils/utils_class.dart';

class TaskCard extends StatelessWidget {
  final TaskStatus taskStatus;
  final String title;
  final String description;
  final DateTime createdDate;
  final bool isCompleted;
  final ValueChanged<bool?>? onStatusChanged;

  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.title,
    required this.description,
    required this.createdDate,
    this.isCompleted = false,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusChipColor(taskStatus);
    return Card(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      elevation: 0.5,
      child: ListTile(
        leading: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          side: const BorderSide(color: Colors.grey, width: 2),
          value: isCompleted,
          onChanged: onStatusChanged,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              FunctionLogic.formatTimeAgo(createdDate),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(color: Colors.grey.shade600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _statusText(taskStatus),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }

  String _statusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.sNew:
        return 'New';
      case TaskStatus.progress:
        return 'Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
      default:
        return '';
    }
  }
}
