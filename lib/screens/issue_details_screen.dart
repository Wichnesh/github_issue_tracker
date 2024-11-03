import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/issue_details_controller.dart';
import '../helper/date_formatter.dart';
import '../models/issue_model.dart';

class IssueDetailsScreen extends StatelessWidget {
  final Issue issue;
  final String owner;
  final String repo;
  final IssueDetailsController detailsController = Get.put(IssueDetailsController());

  IssueDetailsScreen({super.key, required this.issue, required this.owner, required this.repo});

  @override
  Widget build(BuildContext context) {
    detailsController.fetchComments(owner, repo, issue.number);

    return Scaffold(
      appBar: AppBar(
        title: Text('Issue #${issue.number} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(issue.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Created by ${issue.author} on ${issue.createdAt}"),
            const SizedBox(height: 8),
            if (issue.closedAt != null) Text("Closed on ${formatDate(issue.createdAt)},"),
            const SizedBox(height: 16),
            const Text("Comments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(() {
                if (detailsController.isLoading.value) return const Center(child: CircularProgressIndicator());
                if (detailsController.hasError.value) return Center(child: Text(detailsController.errorMessage.value));
                return ListView.builder(
                  itemCount: detailsController.comments.length,
                  itemBuilder: (context, index) {
                    final comment = detailsController.comments[index];
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(comment.body),
                        subtitle: Text("By ${comment.author} on ${formatDate(comment.createdAt)}"),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
