import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/gssoc_project_modal.dart';

void main() {
  group('GssocProjectModal Tests', () {
    const String testName = 'OpSo';
    const String testGithubUrl = 'https://github.com/andoriyaprashant/OpSo';
    final List<String> testTechStack = ['Flutter', 'Dart'];
    const String testHostedBy = 'GirlScript Foundation';
    const String testYear = '2026';

    test('should construct model correctly with standard constructor', () {
      final model = GssocProjectModal(
        name: testName,
        githubUrl: testGithubUrl,
        techstack: testTechStack,
        hostedBy: testHostedBy,
        year: testYear,
      );

      expect(model.name, testName);
      expect(model.githubUrl, testGithubUrl);
      expect(model.techstack, testTechStack);
      expect(model.hostedBy, testHostedBy);
      expect(model.year, testYear);
    });

    test('should copyWith modified fields correctly', () {
      final model = GssocProjectModal(
        name: testName,
        githubUrl: testGithubUrl,
        techstack: testTechStack,
        hostedBy: testHostedBy,
        year: testYear,
      );

      final copiedModel = model.copyWith(
        name: 'New Name',
        year: '2027',
      );

      expect(copiedModel.name, 'New Name');
      expect(copiedModel.githubUrl, testGithubUrl);
      expect(copiedModel.techstack, testTechStack);
      expect(copiedModel.hostedBy, testHostedBy);
      expect(copiedModel.year, '2027');
    });

    test('should map representation toMap and fromMap correctly', () {
      final model = GssocProjectModal(
        name: testName,
        githubUrl: testGithubUrl,
        techstack: testTechStack,
        hostedBy: testHostedBy,
        year: testYear,
      );

      final map = model.toMap();
      expect(map['name'], testName);
      expect(map['githubUrl'], testGithubUrl);
      expect(map['techstack'], testTechStack);
      expect(map['hostedBy'], testHostedBy);
      expect(map['year'], testYear);

      // Note: fromMap cast map['techstack'] as List<String>, so we need to pass List<String>
      final parsedModel = GssocProjectModal.fromMap(map);
      expect(parsedModel.name, testName);
      expect(parsedModel.githubUrl, testGithubUrl);
      expect(parsedModel.techstack, testTechStack);
      expect(parsedModel.hostedBy, testHostedBy);
      expect(parsedModel.year, testYear);
    });

    test('should serialize to JSON string correctly', () {
      final model = GssocProjectModal(
        name: testName,
        githubUrl: testGithubUrl,
        techstack: testTechStack,
        hostedBy: testHostedBy,
        year: testYear,
      );

      final jsonString = model.toJson();
      final decodedMap = json.decode(jsonString);

      expect(decodedMap['name'], testName);
      expect(decodedMap['githubUrl'], testGithubUrl);
      expect(decodedMap['techstack'], testTechStack);
      expect(decodedMap['hostedBy'], testHostedBy);
      expect(decodedMap['year'], testYear);
    });

    test('should parse from JSON using getDataFromJson helper method', () {
      final Map<String, dynamic> jsonMap = {
        'name': testName,
        'githubUrl': testGithubUrl,
        'techstack': testTechStack,
        'hostedBy': testHostedBy,
        'year': testYear,
      };

      final model = GssocProjectModal.getDataFromJson(jsonMap);

      expect(model.name, testName);
      expect(model.githubUrl, testGithubUrl);
      expect(model.techstack, testTechStack);
      expect(model.hostedBy, testHostedBy);
      expect(model.year, testYear);
    });

    test('should output correct toString representation', () {
      final model = GssocProjectModal(
        name: testName,
        githubUrl: testGithubUrl,
        techstack: testTechStack,
        hostedBy: testHostedBy,
        year: testYear,
      );

      final expectedString =
          'GssocProjectModal(name: $testName, githubUrl: $testGithubUrl, techstack: $testTechStack, hostedBy: $testHostedBy, year: $testYear)';
      expect(model.toString(), expectedString);
    });
  });
}
