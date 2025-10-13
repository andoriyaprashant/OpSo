import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Contributor model class
class Contributor {
  final String login;
  final String avatarUrl;
  final int contributions;

  Contributor({
    required this.login,
    required this.avatarUrl,
    required this.contributions,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) => Contributor(
        login: json['login'] ?? '',
        avatarUrl: json['avatar_url'] ?? '',
        contributions: json['contributions'] ?? 0,
      );
}

// API function: returns List<Contributor>
Future<List<Contributor>> fetchContributors() async {
  final githubToken = dotenv.env['GITHUB_TOKEN'];
  if (githubToken == null || githubToken.isEmpty) {
    throw Exception('GitHub token missing in .env');
  }

  // **IMPORTANT - OWNER and REPO ko apne repo ke according set karo**
  final repoOwner = 'ambitionless'; // <-- Apna github username
  final repoName = 'OpSo'; // <-- Apne repo ka naam (case sensitive)
  final url = 'https://api.github.com/repos/$repoOwner/$repoName/contributors';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        // Github API ke liye classic tokens, "Bearer" nahi -- "token"
        'Authorization': 'token $githubToken',
        'Accept': 'application/vnd.github.v3+json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Contributor.fromJson(json)).toList();
    } else {
      // Debugging ke liye poora response show karo
      print(
          'GitHub API failed: ${response.statusCode} - ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      throw Exception(
          'GitHub API error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('API call failed: $e');
  }
}
