import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/utility_class.dart';
import 'package:task_manager/provider/image_provider.dart';
import 'package:task_manager/ui/widgets/task_progress_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskStatus? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickProvider>(
      builder: (context, provider, child) {
        XFile? image = provider.profileImage;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 180,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${FuntionLogic.showGrettings()},",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      image == null
                          ? CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              child: const Icon(
                                Icons.person,
                                size: 24,
                                color: Colors.white,
                              ),
                            )
                          : ClipOval(
                              child: kIsWeb
                                  ? Image.network(
                                      image.path,
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    )
                                  : Image.file(
                                      File(image.path),
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Mirza Tanvir",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 17,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        formatDateTime(DateTime.now()),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  elevation: 0.5,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    child: Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 8.0,
                          percent: 0.7,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          animationDuration: 3000,
                          center: Text("${(0.7 * 100).toInt()}%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                          progressColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                        ),
                        const SizedBox(width: 10),
                        (((0.7 * 100) >= 60) && ((0.7 * 100) <= 99))
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("You're almost there!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    const SizedBox(height: 4),
                                    Text(
                                        "Keep going and complete your tasks today",
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16)),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Today's Progress",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(
                                        "${(0.7 * 5).round()} of ${5} tasks completed",
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 18)),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "🔥 ",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: "Today's Tasks",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const TaskProgressTile(
                    title: "Fix Login Bug",
                    progress: 0.1,
                    taskStatus: TaskStatus.sNew,
                    icon: Icons.bug_report),
                const TaskProgressTile(
                    title: "Client Call",
                    progress: 1.0,
                    taskStatus: TaskStatus.completed,
                    icon: Icons.phone_forwarded),
                const TaskProgressTile(
                    title: "Design Homepage",
                    progress: 0.8,
                    taskStatus: TaskStatus.progress,
                    icon: Icons.design_services),
                const SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "📂 ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                        ),
                      ),
                      const TextSpan(
                        text: "Upcoming Tasks",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const TaskProgressTile(
                    title: "Update Docs",
                    progress: 0,
                    taskStatus: TaskStatus.upcoming,
                    icon: Icons.update),
                const TaskProgressTile(
                    title: "Plan Sprint",
                    progress: 0,
                    taskStatus: TaskStatus.upcoming,
                    icon: Icons.schedule),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE, MMMM d').format(dateTime);
  }
}
