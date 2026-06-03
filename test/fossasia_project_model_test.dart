import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/fossasia_project_modal.dart';

void main() {
  group('FOSSASIAProjectModel Tests', () {
    const String testName = 'OpSo';
    const String testDescription = 'Open Source Programs App';
    final List<String> testTechStack = ['Flutter', 'Dart'];
    const String testLink = 'https://github.com/andoriyaprashant/OpSo';
    const String testYear = '2026';

    test('should construct model correctly with standard constructor', () {
      final model = FOSSASIAProjectModel(
        name: testName,
        description: testDescription,
        techStack: testTechStack,
        link: testLink,
        year: testYear,
      );

      expect(model.name, testName);
      expect(model.description, testDescription);
      expect(model.techStack, testTechStack);
      expect(model.link, testLink);
      expect(model.year, testYear);
    });

    test('should parse model from JSON when TechStack is a List', () {
      final Map<String, dynamic> jsonMap = {
        'Name': testName,
        'Description': testDescription,
        'TechStack': testTechStack,
        'link': testLink,
        'Year': testYear,
      };

      final model = FOSSASIAProjectModel.fromJson(jsonMap);

      expect(model.name, testName);
      expect(model.description, testDescription);
      expect(model.techStack, testTechStack);
      expect(model.link, testLink);
      expect(model.year, testYear);
    });

    test('should parse model from JSON when TechStack is a single String', () {
      final Map<String, dynamic> jsonMap = {
        'Name': testName,
        'Description': testDescription,
        'TechStack': 'Flutter',
        'link': testLink,
        'Year': testYear,
      };

      final model = FOSSASIAProjectModel.fromJson(jsonMap);

      expect(model.name, testName);
      expect(model.description, testDescription);
      expect(model.techStack, ['Flutter']);
      expect(model.link, testLink);
      expect(model.year, testYear);
    });

    test('should parse model from JSON when Year is an integer', () {
      final Map<String, dynamic> jsonMap = {
        'Name': testName,
        'Description': testDescription,
        'TechStack': testTechStack,
        'link': testLink,
        'Year': 2026,
      };

      final model = FOSSASIAProjectModel.fromJson(jsonMap);

      expect(model.year, '2026');
    });

    test('should serialize model to JSON map correctly', () {
      final model = FOSSASIAProjectModel(
        name: testName,
        description: testDescription,
        techStack: testTechStack,
        link: testLink,
        year: testYear,
      );

      final jsonMap = model.toJson();

      expect(jsonMap['Name'], testName);
      expect(jsonMap['Description'], testDescription);
      expect(jsonMap['TechStack'], testTechStack);
      expect(jsonMap['link'], testLink);
      expect(jsonMap['Year'], testYear);
    });

    test('should output correct toString representation', () {
      final model = FOSSASIAProjectModel(
        name: testName,
        description: testDescription,
        techStack: testTechStack,
        link: testLink,
        year: testYear,
      );

      final expectedString =
          'FOSSASIAProjectModel(name: $testName, description: $testDescription, techStack: $testTechStack, link: $testLink, year: $testYear)';
      expect(model.toString(), expectedString);
    });
  });
}
