import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/hyperledger_modal.dart';

void main() {
  group('HyperledgerProjectModal', () {
    final tModal = HyperledgerProjectModal(
      name: 'TestProject',
      wiki: 'https://wiki.hyperledger.org/test',
      mentors: ['Alice', 'Bob'],
      year: '2023',
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.name, 'TestProject');
      expect(tModal.wiki, 'https://wiki.hyperledger.org/test');
      expect(tModal.mentors, ['Alice', 'Bob']);
      expect(tModal.year, '2023');
    });

    test('fromJson with list mentors', () {
      final json = {
        'title': 'ListMentorProject',
        'link': 'https://wiki.hyperledger.org/list',
        'mentors': ['Mentor1', 'Mentor2'],
        'year': 2023,
      };
      final modal = HyperledgerProjectModal.fromJson(json);
      expect(modal.name, 'ListMentorProject');
      expect(modal.mentors, ['Mentor1', 'Mentor2']);
      expect(modal.year, '2023');
    });

    test('fromJson with string mentor', () {
      final json = {
        'title': 'SingleMentorProject',
        'link': 'https://wiki.hyperledger.org/single',
        'mentors': 'SingleMentor',
        'year': 2022,
      };
      final modal = HyperledgerProjectModal.fromJson(json);
      expect(modal.mentors, ['SingleMentor']);
    });

    test('fromJson converts year int to string', () {
      final json = {
        'title': 'YearTest',
        'link': 'url',
        'mentors': <String>[],
        'year': 2024,
      };
      final modal = HyperledgerProjectModal.fromJson(json);
      expect(modal.year, '2024');
    });

    test('toJson returns correct map', () {
      final map = tModal.toJson();
      expect(map['title'], 'TestProject');
      expect(map['link'], 'https://wiki.hyperledger.org/test');
      expect(map['mentors'], ['Alice', 'Bob']);
      expect(map['year'], '2023');
    });

    test('toString contains key fields', () {
      final str = tModal.toString();
      expect(str, contains('TestProject'));
      expect(str, contains('Alice'));
      expect(str, contains('2023'));
    });

    test('supports empty mentors list', () {
      final modal = HyperledgerProjectModal(
        name: 'NoMentor',
        wiki: 'url',
        mentors: [],
        year: '2023',
      );
      expect(modal.mentors, isEmpty);
    });
  });
}
