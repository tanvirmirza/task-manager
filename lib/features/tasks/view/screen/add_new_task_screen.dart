import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/widgets/tm_app_bar.dart';
import 'package:task_manager/features/tasks/controller/add_new_task_controller.dart';

class AddNewTaskScreen extends StatelessWidget {
  AddNewTaskScreen({super.key});
  final controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: TMAppBar(),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              Text(
                'Create Task',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller.titleController,
                hint: 'Task Title',
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller.descriptionController,
                hint: 'Task Description',
                maxLines: 6,
              ),
              const SizedBox(height: 16),
              Text(
                'Category',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.categories.map((category) {
                  final isSelected =
                      controller.selectedCategory.value == category.text;
                  return ChoiceChip(
                    label: Text(category.text),
                    selected: isSelected,
                    selectedColor: primary,
                    backgroundColor: Colors.grey[200],
                    checkmarkColor: Colors.white,
                    showCheckmark: false,
                    avatar: isSelected
                        ? Icon(category.icon, color: Colors.white)
                        : null,
                    labelStyle: TextStyle(
                      color:
                      isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    onSelected: (_) =>
                    controller.selectedCategory.value =
                        category.text,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }).toList(),
              )),
              const SizedBox(height: 30),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                  controller.isLoading.value ? null : controller.submit,
                  icon: const Icon(Icons.check_circle_outline),
                  label: controller.isLoading.value
                      ? const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                      : const Text(
                    'Add Task',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl,
      {required String hint, int maxLines = 1}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      elevation: 0.5,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        textInputAction:
        maxLines == 1 ? TextInputAction.next : TextInputAction.done,
        validator: (value) =>
        (value == null || value.trim().isEmpty) ? 'Required' : null,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
