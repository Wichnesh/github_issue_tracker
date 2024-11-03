import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController repoController = TextEditingController(text: 'jonataslaw/getx');
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Issue Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: repoController,
              decoration: const InputDecoration(
                labelText: 'Repository (owner/repo) Example : jonataslaw/getx',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (repoController.text.contains('/')) {
                  Get.toNamed('/issues', arguments: repoController.text);
                } else {
                  Get.snackbar('Error', 'Invalid repository format');
                }
              },
              child: const Text('Search Issues'),
            )
          ],
        ),
      ),
    );
  }
}
