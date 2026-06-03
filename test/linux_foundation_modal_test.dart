import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/linux_foundation_modal.dart';

void main() {
  group('LinuxFoundationModal', () {
    final tModal = LinuxFoundationModal(
      name: 'TestProject',
      projectUrl: 'https://linuxfoundation.org/test',
      imageUrl: 'https://linuxfoundation.org/test.png',
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.name, 'TestProject');
      expect(tModal.projectUrl, 'https://linuxfoundation.org/test');
      expect(tModal.imageUrl, 'https://linuxfoundation.org/test.png');
    });

    test('copyWith returns updated instance', () {
      final updated = tModal.copyWith(name: 'UpdatedName');
      expect(updated.name, 'UpdatedName');
      expect(updated.projectUrl, tModal.projectUrl);
      expect(updated.imageUrl, tModal.imageUrl);
    });

    test('copyWith with no args returns equivalent object', () {
      final copy = tModal.copyWith();
      expect(copy.name, tModal.name);
      expect(copy.projectUrl, tModal.projectUrl);
      expect(copy.imageUrl, tModal.imageUrl);
    });

    test('toMap returns correct map', () {
      final map = tModal.toMap();
      expect(map['name'], 'TestProject');
      expect(map['project_url'], 'https://linuxfoundation.org/test');
      expect(map['image_url'], 'https://linuxfoundation.org/test.png');
    });

    test('fromMap constructs correctly', () {
      final map = {
        'name': 'FromMapProject',
        'project_url': 'https://linuxfoundation.org/from',
        'image_url': 'https://linuxfoundation.org/from.png',
      };
      final modal = LinuxFoundationModal.fromMap(map);
      expect(modal.name, 'FromMapProject');
      expect(modal.projectUrl, 'https://linuxfoundation.org/from');
      expect(modal.imageUrl, 'https://linuxfoundation.org/from.png');
    });

    test('equality operator works correctly', () {
      final other = LinuxFoundationModal(
        name: 'TestProject',
        projectUrl: 'https://linuxfoundation.org/test',
        imageUrl: 'https://linuxfoundation.org/test.png',
      );
      expect(tModal == other, isTrue);
    });

    test('inequality when fields differ', () {
      final other = tModal.copyWith(name: 'DifferentName');
      expect(tModal == other, isFalse);
    });

    test('hashCode is consistent', () {
      final other = LinuxFoundationModal(
        name: 'TestProject',
        projectUrl: 'https://linuxfoundation.org/test',
        imageUrl: 'https://linuxfoundation.org/test.png',
      );
      expect(tModal.hashCode, equals(other.hashCode));
    });

    test('toJson returns valid JSON string', () {
      final jsonStr = tModal.toJson();
      expect(jsonStr, isA<String>());
      expect(jsonStr.contains('TestProject'), isTrue);
    });

    test('toString contains all fields', () {
      final str = tModal.toString();
      expect(str, contains('TestProject'));
      expect(str, contains('https://linuxfoundation.org/test'));
    });
  });
}
