import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/sokde_project_modal.dart';

void main() {
  group('SokdeProjectModal', () {
    final tModal = SokdeProjectModal(
      name: 'TestProject',
      wiki: 'https://wiki.kde.org/test',
      mentees: ['Alice', 'Bob'],
      mentors: ['Charlie'],
      year: '2023',
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.name, 'TestProject');
      expect(tModal.wiki, 'https://wiki.kde.org/test');
      expect(tModal.mentees, ['Alice', 'Bob']);
      expect(tModal.mentors, ['Charlie']);
      expect(tModal.year, '2023');
    });

    test('fromJson with list mentors and mentees', () {
      final json = {
        'title': 'JsonProject',
        'link': 'https://wiki.kde.org/json',
        'mentors': ['Mentor1', 'Mentor2'],
        'mentees': ['Mentee1'],
        'year': 2023,
      };
      final modal = SokdeProjectModal.fromJson(json);
      expect(modal.name, 'JsonProject');
      expect(modal.wiki, 'https://wiki.kde.org/json');
      expect(modal.mentors, ['Mentor1', 'Mentor2']);
      expect(modal.mentees, ['Mentee1']);
      expect(modal.year, '2023');
    });

    test('fromJson with string mentors and mentees', () {
      final json = {
        'title': 'SingleMentorProject',
        'link': 'https://wiki.kde.org/single',
        'mentors': 'SingleMentor',
        'mentees': 'SingleMentee',
        'year': 2022,
      };
      final modal = SokdeProjectModal.fromJson(json);
      expect(modal.mentors, ['SingleMentor']);
      expect(modal.mentees, ['SingleMentee']);
    });

    test('fromJson converts year to string', () {
      final json = {
        'title': 'YearTest',
        'link': 'url',
        'mentors': <String>[],
        'mentees': <String>[],
        'year': 2024,
      };
      final modal = SokdeProjectModal.fromJson(json);
      expect(modal.year, '2024');
    });

    test('toJson returns correct map', () {
      final map = tModal.toJson();
      expect(map['title'], 'TestProject');
      expect(map['link'], 'https://wiki.kde.org/test');
      expect(map['mentors'], ['Charlie']);
      expect(map['mentees'], ['Alice', 'Bob']);
      expect(map['year'], '2023');
    });

    test('toString contains key fields', () {
      final str = tModal.toString();
      expect(str, contains('TestProject'));
      expect(str, contains('Alice'));
      expect(str, contains('Charlie'));
    });

    test('supports empty mentors and mentees list', () {
      final modal = SokdeProjectModal(
        name: 'Empty',
        wiki: 'url',
        mentees: [],
        mentors: [],
        year: '2023',
      );
      expect(modal.mentors, isEmpty);
      expect(modal.mentees, isEmpty);
    });
  });
}
