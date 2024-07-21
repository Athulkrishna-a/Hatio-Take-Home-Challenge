import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> exportToGist(String projectTitle, int completedTodos,
    int totalTodos, List<Map<String, dynamic>> todos) async {
  // Generate Markdown content
  StringBuffer content = StringBuffer();
  content.writeln('# $projectTitle\n');
  content.writeln('## Summary\n');
  content.writeln('$completedTodos / $totalTodos completed\n');
  content.writeln('## Pending Todos\n');
  for (var todo in todos.where((todo) => todo['status'] != 'done')) {
    content.writeln(
        '- [ ] ${todo['description']} (Created: ${todo['createdDate']})');
  }
  content.writeln('\n## Completed Todos\n');
  for (var todo in todos.where((todo) => todo['status'] == 'done')) {
    content.writeln(
        '- [x] ${todo['description']} (Created: ${todo['createdDate']}, Updated: ${todo['updatedDate']})');
  }

  // Create the Gist
  var response = await http.post(
    Uri.parse('https://api.github.com/gists'),
    headers: {
      'Content-Type': 'application/json',
      // 'Authorization': 'Git hub Token', // Replace with your GitHub token
    },
    body: json.encode({
      'description': 'Todo Summary for $projectTitle',
      'public': false,
      'files': {
        '$projectTitle.md': {'content': content.toString()}
      }
    }),
  );

  if (response.statusCode == 201) {
    print('Gist created successfully!');
  } else {
    print('Failed to create gist: ${response.body}');
  }
}
