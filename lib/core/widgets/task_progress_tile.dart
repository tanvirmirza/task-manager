import 'package:flutter/material.dart';
import 'package:task_manager/core/core.dart';

class TaskProgressTile extends StatefulWidget {
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
  State<TaskProgressTile> createState() => _TaskProgressTileState();
}

class _TaskProgressTileState extends State<TaskProgressTile> {
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
          child: Icon(widget.icon,
              color: Theme.of(context).colorScheme.primary, size: 28),
        ),
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: LinearProgressIndicator(
                  value: widget.progress,
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 6),
            ),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(FuntionLogic.formatTimeAgo(DateTime.now()),
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 5),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: FuntionLogic()
                .getStatusChipColor(widget.taskStatus)
                .withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.taskStatus == TaskStatus.sNew
                ? 'New'
                : widget.taskStatus == TaskStatus.progress
                    ? 'Progress'
                    : widget.taskStatus == TaskStatus.completed
                        ? 'Completed'
                        : widget.taskStatus == TaskStatus.cancelled
                            ? 'Cancelled'
                            : 'Upcoming',
            style: TextStyle(
                color: FuntionLogic().getStatusChipColor(widget.taskStatus),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
