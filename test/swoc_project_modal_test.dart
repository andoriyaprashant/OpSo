import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/swoc_project_modal.dart';

void main() {
  group('SwocProjectModal', () {
    final tModal = SwocProjectModal(
      name: 'TestProject',
      repo: 'https://github.com/test/repo',
      techstack: ['Flutter', 'Dart'],
      owner: 'TestOwner',
      year: '2023',
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.name, 'TestProject');
      expect(tModal.repo, 'https://github.com/test/repo');
      expect(tModal.techstack, ['Flutter', 'Dart']);
      expect(tModal.owner, 'TestOwner');
      expect(tModal.year, '2023');
    });

    test('copyWith returns new instance with updated fields', () {
      final updated = tModal.copyWith(name: 'NewName', year: '2024');
      expect(updated.name, 'NewName');
      expect(updated.year, '2024');
      expect(updated.repo, tModal.repo);
      expect(updated.techstack, tModal.techstack);
      expect(updated.owner, tModal.owner);
    });

    test('copyWith with no args returns equivalent object', () {
      final copy = tModal.copyWith();
      expect(copy.name, tModal.name);
      expect(copy.repo, tModal.repo);
      expect(copy.owner, tModal.owner);
      expect(copy.year, tModal.year);
    });

    test('toMap returns correct map', () {
      final map = tModal.toMap();
      expect(map['Name'], 'TestProject');
      expect(map['Repo'], 'https://github.com/test/repo');
      expect(map['TechStack'], ['Flutter', 'Dart']);
      expect(map['Owner'], 'TestOwner');
      expect(map['Year'], '2023');
    });

    test('fromMap constructs correctly', () {
      final map = {
        'Name': 'FromMapProject',
        'Repo': 'https://github.com/from/map',
        'TechStack': ['React', 'Node'],
        'Owner': 'MapOwner',
        'Year': '2022',
      };
      final modal = SwocProjectModal.fromMap(map);
      expect(modal.name, 'FromMapProject');
      expect(modal.repo, 'https://github.com/from/map');
      expect(modal.techstack, ['React', 'Node']);
      expect(modal.owner, 'MapOwner');
      expect(modal.year, '2022');
    });

    test('getDataFromJson constructs correctly', () {
      final data = {
        'Name': 'JsonProject',
        'Repo': 'https://github.com/json/project',
        'TechStack': ['Python', 'Django'],
        'Owner': 'JsonOwner',
        'Year': '2021',
      };
      final modal = SwocProjectModal.getDataFromJson(data);
      expect(modal.name, 'JsonProject');
      expect(modal.techstack, ['Python', 'Django']);
      expect(modal.year, '2021');
    });

    test('toJson returns a valid JSON string', () {
      final jsonStr = tModal.toJson();
      expect(jsonStr, isA<String>());
      expect(jsonStr.contains('TestProject'), isTrue);
    });

    test('toString contains all fields', () {
      final str = tModal.toString();
      expect(str, contains('TestProject'));
      expect(str, contains('TestOwner'));
      expect(str, contains('2023'));
    });

    test('techstack supports empty list', () {
      final modal = SwocProjectModal(
        name: 'NoTech',
        repo: 'url',
        techstack: [],
        owner: 'owner',
        year: '2023',
      );
      expect(modal.techstack, isEmpty);
    });
  });
}
