import 'package:get/get.dart';

import '../models/comment_model.dart';
import '../services/github_api_service.dart';

class IssueDetailsController extends GetxController {
  var comments = <Comment>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  void fetchComments(String owner, String repo, int issueNumber) async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      comments.value = await GitHubApiService.fetchComments(owner, repo, issueNumber);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
