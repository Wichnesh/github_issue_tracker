import 'package:get/get.dart';

import '../controllers/github_issue_controller.dart';

class GitHubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GitHubIssueController>(() => GitHubIssueController(), fenix: true);
  }
}
