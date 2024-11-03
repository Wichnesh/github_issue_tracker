import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/github_issue_controller.dart';
import '../helper/date_formatter.dart';
import 'issue_details_screen.dart';

class IssueListScreen extends StatelessWidget {
  final GitHubIssueController controller = Get.find();

  IssueListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Get.arguments as String;
    final ownerRepo = repo.split('/');
    controller.fetchIssues(owner: ownerRepo[0], repo: ownerRepo[1]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Issues for $repo'),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Card(
                  key: ValueKey(controller.isOpenIssues.value),
                  color: controller.isOpenIssues.value ? Colors.green[100] : Colors.red[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          controller.isOpenIssues.value ? 'Open Issues' : 'Closed Issues',
                          style: TextStyle(
                            color: controller.isOpenIssues.value ? Colors.green : Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Switch(
                          value: controller.isOpenIssues.value,
                          onChanged: (value) async {
                            controller.toggleIssueState();
                            await controller.fetchIssues(owner: ownerRepo[0], repo: ownerRepo[1]);
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.red[200],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            controller.fetchIssues(owner: ownerRepo[0], repo: ownerRepo[1]);
          },
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return Stack(
                    children: [
                      NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                            controller.loadMoreIssues(owner: ownerRepo[0], repo: ownerRepo[1]);
                          }
                          return false;
                        },
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView.builder(
                            itemCount: controller.issues.length,
                            itemBuilder: (context, index) {
                              final issue = controller.issues[index];
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(issue.title),
                                  subtitle: Text('Issue #${issue.number} by ${issue.author}'),
                                  trailing: Text(
                                    formatDate(issue.createdAt),
                                  ),
                                  onTap: () {
                                    Get.to(IssueDetailsScreen(issue: issue, owner: ownerRepo[0], repo: ownerRepo[1]));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (controller.isLoading.value)
                        const Positioned.fill(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
