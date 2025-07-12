import 'package:flutter/material.dart';
import '../../widgets/tm_app_bar.dart';

class Category {
  final IconData icon;
  final String text;
  Category({
    required this.icon,
    required this.text,
  });
}

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<Category> _categories = [
    Category(icon: Icons.work, text: 'Work'),
    Category(icon: Icons.school, text: 'Study'),
    Category(icon: Icons.health_and_safety, text: 'Health'),
    Category(icon: Icons.person, text: 'Personal'),
  ];
  String _selectedCategory = 'Work';

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const TMAppBar(),
      body: Padding(
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
              child: TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Task Title',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 5),
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
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Task Description',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Category',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _categories.map((category) {
                final isSelected = category.text.toLowerCase() ==
                    _selectedCategory.toLowerCase();
                return ChoiceChip(
                  label: Text(category.text),
                  selected: isSelected,
                  selectedColor: primary,
                  backgroundColor: Colors.grey[200],
                  checkmarkColor: Colors.white,
                  showCheckmark: false,
                  avatar: isSelected
                      ? Icon(
                          category.icon,
                          color: Colors.white,
                        )
                      : null,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  onSelected: (value) {
                    setState(() {
                      _selectedCategory = category.text;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onTapSubmitButton,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    final title = _titleController.text.trim();
    // final desc = _descriptionController.text.trim();
    if (title.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task added successfully!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    _titleController.clear();
    _descriptionController.clear();
  }
}
