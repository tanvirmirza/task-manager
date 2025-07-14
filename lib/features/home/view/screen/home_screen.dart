import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/utils/time_util.dart';
import 'package:task_manager/core/utils/utils_class.dart';
import 'package:task_manager/features/home/view/widget/build_progress_card.dart';
import 'package:task_manager/features/home/view/widget/task_progress_tile.dart';
import 'package:task_manager/features/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeController());

  final FunctionLogic logic = FunctionLogic();

  @override
  Widget build(BuildContext context) {
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
              _greetingRow(context),
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
                  Icon(Icons.calendar_today_outlined,
                      size: 17, color: Colors.white.withOpacity(0.8)),
                  const SizedBox(width: 5),
                  Text(
                    FunctionLogic.dateTimeFormat(DateTime.now().toString()),
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
            const BuildProgressCard(),
            const SizedBox(height: 30),
            _sectionTitle("🔥 Today's Tasks"),
            const SizedBox(height: 12),
            const TaskProgressTile(
              title: "Fix Login Bug",
              progress: 0.1,
              taskStatus: TaskStatus.sNew,
              icon: Icons.bug_report,
            ),
            const TaskProgressTile(
              title: "Client Call",
              progress: 1.0,
              taskStatus: TaskStatus.completed,
              icon: Icons.phone_forwarded,
            ),
            const TaskProgressTile(
              title: "Design Homepage",
              progress: 0.8,
              taskStatus: TaskStatus.progress,
              icon: Icons.design_services,
            ),
            const SizedBox(height: 24),
            _sectionTitle("📂 Upcoming Tasks"),
            const SizedBox(height: 12),
            const TaskProgressTile(
              title: "Update Docs",
              progress: 0,
              taskStatus: TaskStatus.upcoming,
              icon: Icons.update,
            ),
            const TaskProgressTile(
              title: "Plan Sprint",
              progress: 0,
              taskStatus: TaskStatus.upcoming,
              icon: Icons.schedule,
            ),
          ],
        ),
      ),
    );
  }

  Widget _greetingRow(BuildContext context) {
    return Obx(() {
      final image = controller.profileImage.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              logic.showGreetings(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
               GestureDetector(
                onTap: controller.pickImage,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: image == null
                      ? const Icon(Icons.person, size: 24, color: Colors.white)
                      : ClipOval(
                    child: kIsWeb
                        ? Image.network(image.path,
                        fit: BoxFit.cover, width: 50, height: 50)
                        : Image.file(File(image.path),
                        fit: BoxFit.cover, width: 50, height: 50),
                  ),
                ),
              )
          ],
        );
      }
    );
  }



  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

}
