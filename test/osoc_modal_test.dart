import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/osoc_modal.dart';

void main() {
  group('OsocModal Tests', () {
    const String testName = 'OpSo';
    const String testImageUrl = 'https://example.com/image.png';
    const String testDescription = 'Open Source Programs App';
    const String testProjectUrl = 'https://github.com/andoriyaprashant/OpSo';
    const int testYear = 2026;

    test('should construct model correctly with standard constructor', () {
      final model = OsocModal(
        name: testName,
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      expect(model.name, testName);
      expect(model.image_url, testImageUrl);
      expect(model.description, testDescription);
      expect(model.project_url, testProjectUrl);
      expect(model.year, testYear);
    });

    test('should copyWith modified fields correctly', () {
      final model = OsocModal(
        name: testName,
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      final copiedModel = model.copyWith(
        name: 'New Name',
        year: 2027,
      );

      expect(copiedModel.name, 'New Name');
      expect(copiedModel.image_url, testImageUrl);
      expect(copiedModel.description, testDescription);
      expect(copiedModel.project_url, testProjectUrl);
      expect(copiedModel.year, 2027);
    });

    test('should map representation toMap and fromMap correctly', () {
      final model = OsocModal(
        name: testName,
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      final map = model.toMap();
      expect(map['name'], testName);
      expect(map['image_url'], testImageUrl);
      expect(map['description'], testDescription);
      expect(map['project_url'], testProjectUrl);
      expect(map['year'], testYear);

      final parsedModel = OsocModal.fromMap(map);
      expect(parsedModel.name, testName);
      expect(parsedModel.image_url, testImageUrl);
      expect(parsedModel.description, testDescription);
      expect(parsedModel.project_url, testProjectUrl);
      expect(parsedModel.year, testYear);
    });

    test('should serialize to JSON string and deserialize from JSON string correctly', () {
      final model = OsocModal(
        name: testName,
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      final jsonString = model.toJson();
      final decodedMap = json.decode(jsonString);

      expect(decodedMap['name'], testName);
      expect(decodedMap['image_url'], testImageUrl);
      expect(decodedMap['description'], testDescription);
      expect(decodedMap['project_url'], testProjectUrl);
      expect(decodedMap['year'], testYear);

      final modelFromJson = OsocModal.fromJson(jsonString);
      expect(modelFromJson, model);
    });

    test('should output correct toString representation', () {
      final model = OsocModal(
        name: testName,
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      final expectedString =
          'OsocModal(name: $testName, image_url: $testImageUrl, description: $testDescription, project_url: $testProjectUrl, year: $testYear)';
      expect(model.toString(), expectedString);
    });

    test('should correctly compare objects via operator == and hashCode', () {
      final model1 = OsocModal(
        name: testName,
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      final model2 = OsocModal(
        name: testName,
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      final model3 = OsocModal(
        name: 'Different Name',
        image_url: testImageUrl,
        description: testDescription,
        project_url: testProjectUrl,
        year: testYear,
      );

      expect(model1 == model2, isTrue);
      expect(model1 == model3, isFalse);
      expect(model1.hashCode == model2.hashCode, isTrue);
      expect(model1.hashCode == model3.hashCode, isFalse);
    });
  });
}
