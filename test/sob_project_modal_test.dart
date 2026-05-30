import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/sob_project_modal.dart';

void main() {
  group('SobProjectModal', () {
    final tModal = SobProjectModal(
      name: 'Alice Smith',
      organization: 'Bitcoin Org',
      description: 'Working on Bitcoin core',
      mentor: 'Bob Jones',
      university: 'MIT',
      country: 'USA',
      projects: [
        'https://github.com/test/proj1',
        'https://github.com/test/proj2',
      ],
      year: 2023,
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.name, 'Alice Smith');
      expect(tModal.organization, 'Bitcoin Org');
      expect(tModal.description, 'Working on Bitcoin core');
      expect(tModal.mentor, 'Bob Jones');
      expect(tModal.university, 'MIT');
      expect(tModal.country, 'USA');
      expect(tModal.projects, hasLength(2));
      expect(tModal.year, 2023);
    });

    test('copyWith updates selected fields', () {
      final updated = tModal.copyWith(name: 'Jane Doe', country: 'UK');
      expect(updated.name, 'Jane Doe');
      expect(updated.country, 'UK');
      expect(updated.organization, tModal.organization);
      expect(updated.mentor, tModal.mentor);
    });

    test('copyWith with no args returns equivalent object', () {
      final copy = tModal.copyWith();
      expect(copy.name, tModal.name);
      expect(copy.year, tModal.year);
    });

    test('toMap returns correct map', () {
      final map = tModal.toMap();
      expect(map['name'], 'Alice Smith');
      expect(map['organization'], 'Bitcoin Org');
      expect(map['mentor'], 'Bob Jones');
      expect(map['university'], 'MIT');
      expect(map['country'], 'USA');
      expect(map['year'], 2023);
      expect(map['project_links'], hasLength(2));
    });

    test('fromMap constructs correctly with project_links', () {
      final map = {
        'name': 'Bob',
        'organization': 'Ethereum',
        'description': 'DeFi work',
        'mentor': 'Charlie',
        'university': 'Stanford',
        'country': 'Canada',
        'project_links': ['https://github.com/a', 'https://github.com/b'],
        'year': 2022,
      };
      final modal = SobProjectModal.fromMap(map);
      expect(modal.name, 'Bob');
      expect(modal.projects, hasLength(2));
      expect(modal.year, 2022);
    });

    test('fromMap handles missing project_links gracefully', () {
      final map = {
        'name': 'NoLinks',
        'organization': 'Org',
        'description': 'Desc',
        'mentor': 'Mentor',
        'university': 'Univ',
        'country': 'Country',
        'year': 2021,
      };
      final modal = SobProjectModal.fromMap(map);
      expect(modal.projects, isEmpty);
    });

    test('fromMap handles null values with defaults', () {
      final modal = SobProjectModal.fromMap({});
      expect(modal.name, '');
      expect(modal.year, 0);
      expect(modal.projects, isEmpty);
    });

    test('equality operator works correctly', () {
      final other = SobProjectModal(
        name: 'Alice Smith',
        organization: 'Bitcoin Org',
        description: 'Working on Bitcoin core',
        mentor: 'Bob Jones',
        university: 'MIT',
        country: 'USA',
        projects: [
          'https://github.com/test/proj1',
          'https://github.com/test/proj2',
        ],
        year: 2023,
      );
      expect(tModal == other, isTrue);
    });

    test('inequality when fields differ', () {
      final other = tModal.copyWith(name: 'Different');
      expect(tModal == other, isFalse);
    });

    test('toString contains all key fields', () {
      final str = tModal.toString();
      expect(str, contains('Alice Smith'));
      expect(str, contains('Bitcoin Org'));
      expect(str, contains('MIT'));
    });
  });
}
