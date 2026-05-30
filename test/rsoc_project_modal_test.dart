import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/rsoc_project_modal.dart';

void main() {
  group('RsocProjectModal', () {
    final tModal = RsocProjectModal(
      name: 'TestProject',
      contributor: 'Alice',
      description: 'A test RSOC project',
      githubUrl: 'https://github.com/test/rsoc',
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.name, 'TestProject');
      expect(tModal.contributor, 'Alice');
      expect(tModal.description, 'A test RSOC project');
      expect(tModal.githubUrl, 'https://github.com/test/rsoc');
    });

    test('fromJson constructs correctly', () {
      final json = {
        'name': 'JsonProject',
        'contributor': 'Bob',
        'description': 'Json description',
        'githubUrl': 'https://github.com/json/rsoc',
      };
      final modal = RsocProjectModal.fromJson(json);
      expect(modal.name, 'JsonProject');
      expect(modal.contributor, 'Bob');
      expect(modal.description, 'Json description');
      expect(modal.githubUrl, 'https://github.com/json/rsoc');
    });

    test('toJson returns correct map', () {
      final map = tModal.toJson();
      expect(map['name'], 'TestProject');
      expect(map['contributor'], 'Alice');
      expect(map['description'], 'A test RSOC project');
      expect(map['githubUrl'], 'https://github.com/test/rsoc');
    });

    test('toJson and fromJson are symmetric', () {
      final map = tModal.toJson();
      final restored = RsocProjectModal.fromJson(map);
      expect(restored.name, tModal.name);
      expect(restored.contributor, tModal.contributor);
      expect(restored.description, tModal.description);
      expect(restored.githubUrl, tModal.githubUrl);
    });

    test('toString contains all fields', () {
      final str = tModal.toString();
      expect(str, contains('TestProject'));
      expect(str, contains('Alice'));
      expect(str, contains('A test RSOC project'));
      expect(str, contains('https://github.com/test/rsoc'));
    });

    test('supports empty string fields', () {
      final modal = RsocProjectModal(
        name: '',
        contributor: '',
        description: '',
        githubUrl: '',
      );
      expect(modal.name, '');
      expect(modal.contributor, '');
    });
  });
}
