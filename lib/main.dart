import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/screens/home_screen.dart';
import 'package:github_issue_tracker/screens/issue_list_screen.dart';

import 'bindings/github_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GitHub Issue Tracker',
      initialBinding: GitHubBinding(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/issues',
          page: () => IssueListScreen(),
        ),
      ],
    );
  }
}
