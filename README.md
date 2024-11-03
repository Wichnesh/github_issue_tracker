# GitHub Issue Tracker App

This is a GitHub Issue Tracker app built with Flutter and GetX for state management. The app allows users to search for a GitHub repository and view both open and closed issues for that repository, with features like pagination, error handling, and more.

## Features

- Repository Issue Search**: Users can enter a repository name in the format `owner/repository' to retrieve and display issues.
- Toggle Between Open and Closed Issues**: Users can switch between viewing open and closed issues using a toggle switch in the app's header.
- Issue Details: Each issue displays key information, including:
    - Issue Title
    - Issue Number
    - Created Date
    - Author
    - Labels
- Issue Navigation: Users can tap on an issue to open it in the GitHub web interface for more details.
- Pagination: The app supports infinite scrolling, allowing users to load more issues as they reach the end of the list.
- Error Handling: Proper error messages are shown in case of network issues, invalid repository names, or if there are no issues available in the repository.

## Screens and UI Components

1. Home Screen: Displays a search bar where users can enter the repository name in the format `owner/repository` to look up issues.
2. Issue List Screen: Shows a list of issues for the selected repository, with a toggle for open and closed issues and pagination support for loading more issues.
3. Loading and Error States**: Visual indicators such as a loading spinner and error messages for an improved user experience.



