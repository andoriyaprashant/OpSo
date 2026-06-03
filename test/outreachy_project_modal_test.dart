import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/outreachy_project_modal.dart';

void main() {
  group('OutreachyProjectModal', () {
    final tModal = OutreachyProjectModal(
      name: 'TestProject',
      description: 'A test Outreachy project',
      skills: ['Python', 'Django'],
      spots: 3,
      year: 2023,
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.name, 'TestProject');
      expect(tModal.description, 'A test Outreachy project');
      expect(tModal.skills, ['Python', 'Django']);
      expect(tModal.spots, 3);
      expect(tModal.year, 2023);
    });

    test('copyWith returns updated instance', () {
      final updated = tModal.copyWith(name: 'NewName', spots: 5);
      expect(updated.name, 'NewName');
      expect(updated.spots, 5);
      expect(updated.description, tModal.description);
      expect(updated.skills, tModal.skills);
      expect(updated.year, tModal.year);
    });

    test('copyWith with no args returns equivalent object', () {
      final copy = tModal.copyWith();
      expect(copy.name, tModal.name);
      expect(copy.spots, tModal.spots);
      expect(copy.year, tModal.year);
    });

    test('toMap returns correct map', () {
      final map = tModal.toMap();
      expect(map['name'], 'TestProject');
      expect(map['description'], 'A test Outreachy project');
      expect(map['skills'], ['Python', 'Django']);
      expect(map['spots'], 3);
      expect(map['year'], 2023);
    });

    test('fromMap constructs correctly', () {
      final map = {
        'name': 'FromMapProject',
        'description': 'From map desc',
        'skills': ['Go', 'Rust'],
        'spots': 2,
        'year': 2022,
      };
      final modal = OutreachyProjectModal.fromMap(map);
      expect(modal.name, 'FromMapProject');
      expect(modal.skills, ['Go', 'Rust']);
      expect(modal.spots, 2);
      expect(modal.year, 2022);
    });

    test('toJson returns valid JSON string', () {
      final jsonStr = tModal.toJson();
      expect(jsonStr, isA<String>());
      expect(jsonStr.contains('TestProject'), isTrue);
    });

    test('toString contains all fields', () {
      final str = tModal.toString();
      expect(str, contains('TestProject'));
      expect(str, contains('Python'));
      expect(str, contains('3'));
      expect(str, contains('2023'));
    });

    test('skills supports empty list', () {
      final modal = OutreachyProjectModal(
        name: 'NoSkills',
        description: 'desc',
        skills: [],
        spots: 1,
        year: 2023,
      );
      expect(modal.skills, isEmpty);
    });

    test('spots can be zero', () {
      final modal = OutreachyProjectModal(
        name: 'ZeroSpots',
        description: 'desc',
        skills: ['Dart'],
        spots: 0,
        year: 2023,
      );
      expect(modal.spots, 0);
    });
  });
}
