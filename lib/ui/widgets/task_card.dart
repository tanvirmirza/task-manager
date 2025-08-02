import 'package:flutter/material.dart';
import 'package:task_manager/core/utility_class.dart';

class TaskCard extends StatefulWidget {
  final TaskStatus taskStatus;
  const TaskCard({
    super.key,
    required this.taskStatus,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  TaskStatus? selectedStatus;

  @override
  Widget build(BuildContext context) {
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
          value: selectedStatus == TaskStatus.completed,
          onChanged: (value) {
            setState(() {
              selectedStatus =
                  value == true ? TaskStatus.completed : TaskStatus.sNew;
            });
          },
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        title: Row(
          children: [
            const Text(
              'Problem Solving',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Spacer(),
            Text(
              FuntionLogic.formatTimeAgo(DateTime.now()),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Five DSA problem solve',
              style: TextStyle(color: Colors.grey.shade600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: FuntionLogic()
                        .getStatusChipColor(widget.taskStatus)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    widget.taskStatus == TaskStatus.sNew
                        ? 'New'
                        : widget.taskStatus == TaskStatus.progress
                            ? 'Progress'
                            : widget.taskStatus == TaskStatus.completed
                                ? 'Completed'
                                : 'Cancelled',
                    style: TextStyle(
                      color:
                          FuntionLogic().getStatusChipColor(widget.taskStatus),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}

//  Card(
//       elevation: 0,
//       color: Colors.white,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Title will be here',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const Text('Description will be here'),
//              Text(formatTimeAgo(DateTime.now()).toString(),),
//             Row(
//               children: [
//                 Chip(
//                   label: Text(
//                      taskStatus == TaskStatus.progress ? 'Progress' : taskStatus == TaskStatus.completed ? 'Completed' : 'Cancelled',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   backgroundColor: _getStatusChipColor(),
//                   side: BorderSide.none,
//                 ),
//                 const Spacer(),
//                 IconButton(
//                     onPressed: () {}, icon: const Icon(CupertinoIcons.delete)),
//                 IconButton(
//                     onPressed: () {}, icon: const Icon(CupertinoIcons.pencil)),
//               ],
//             )
//           ],
//         ),
//       ),
//     );


