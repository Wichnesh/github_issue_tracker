import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/comment_model.dart';
import '../models/issue_model.dart';

class GitHubApiService {
  static Future<List<Issue>> fetchIssues(String owner, String repo, String state, int page,
      {String? label, String? sort}) async {
    final url = Uri.https('api.github.com', '/repos/$owner/$repo/issues', {
      'state': state,
      'page': page.toString(),
    });

    if (kDebugMode) {
      print('Fetching issues from URL: $url');
    }

    final response = await http.get(url);

    if (kDebugMode) {
      print('Response status code: ${response.statusCode}');
    }

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Issue.fromJson(item)).toList();
    } else {
      if (kDebugMode) {
        print('Error fetching issues: ${response.body}');
      }
      throw Exception('Failed to load issues');
    }
  }

  static Future<List<Comment>> fetchComments(String owner, String repo, int issueNumber) async {
    final url = Uri.https('api.github.com', '/repos/$owner/$repo/issues/$issueNumber/comments');

    if (kDebugMode) {
      print('Fetching comments from URL: $url');
    }

    final response = await http.get(url);

    if (kDebugMode) {
      print('Response status code: ${response.statusCode}');
    }

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Comment.fromJson(item)).toList();
    } else {
      if (kDebugMode) {
        print('Error fetching comments: ${response.body}');
      }
      throw Exception('Failed to load comments');
    }
  }
}
