import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/issue_model.dart';
import '../services/github_api_service.dart';

class GitHubIssueController extends GetxController {
  var issues = <Issue>[].obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var isOpenIssues = true.obs;
  int currentPage = 1;
  bool hasMoreIssues = true;
  TextEditingController searchController = TextEditingController();

  void toggleIssueState() {
    isOpenIssues.value = !isOpenIssues.value;
    resetPagination();
  }

  void resetPagination() {
    issues.clear();
    currentPage = 1;
    hasMoreIssues = true;
  }

  Future<void> fetchIssues({String? owner, String? repo, String? label, String? sort}) async {
    if (isLoading.value || !hasMoreIssues) return;

    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    String state = isOpenIssues.value ? 'open' : 'closed';

    try {
      var newIssues = await GitHubApiService.fetchIssues(
        owner ?? "",
        repo ?? "",
        state,
        currentPage,
        label: label,
        sort: sort,
      );

      if (newIssues.isNotEmpty) {
        issues.addAll(newIssues);
        currentPage++;
      } else {
        hasMoreIssues = false; // No more issues to load
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreIssues({String? owner, String? repo, String? label, String? sort}) async {
    if (isLoadingMore.value || !hasMoreIssues) return;

    isLoadingMore.value = true;
    try {
      await fetchIssues(owner: owner, repo: repo, label: label, sort: sort);
    } finally {
      isLoadingMore.value = false;
    }
  }
}
