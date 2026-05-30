import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/gsod/gsod_modal_old.dart';

void main() {
  group('GsodModalOld', () {
    final tModal = GsodModalOld(
      organizationName: 'TestOrg',
      organizationUrl: 'https://testorg.com',
      technicalWriter: 'Alice Writer',
      mentor: 'Bob Mentor',
      project: 'Improve Documentation',
      projectUrl: 'https://testorg.com/project',
      report: 'Final Report',
      reportUrl: 'https://testorg.com/report',
      originalProjectProposal: 'Original Proposal',
      originalProjectProposalUrl: 'https://testorg.com/proposal',
      year: 2020,
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.organizationName, 'TestOrg');
      expect(tModal.organizationUrl, 'https://testorg.com');
      expect(tModal.technicalWriter, 'Alice Writer');
      expect(tModal.mentor, 'Bob Mentor');
      expect(tModal.project, 'Improve Documentation');
      expect(tModal.report, 'Final Report');
      expect(tModal.year, 2020);
    });

    test('copyWith updates organizationName via organization param', () {
      final updated = tModal.copyWith(organization: 'NewOrg', year: 2019);
      expect(updated.organizationName, 'NewOrg');
      expect(updated.year, 2019);
      expect(updated.technicalWriter, tModal.technicalWriter);
    });

    test('copyWith with no args returns equivalent object', () {
      final copy = tModal.copyWith();
      expect(copy.organizationName, tModal.organizationName);
      expect(copy.year, tModal.year);
      expect(copy.mentor, tModal.mentor);
    });

    test('toMap returns correct map', () {
      final map = tModal.toMap();
      expect(map['organization'], 'TestOrg');
      expect(map['organization_url'], 'https://testorg.com');
      expect(map['technical_writer'], 'Alice Writer');
      expect(map['mentor'], 'Bob Mentor');
      expect(map['project'], 'Improve Documentation');
      expect(map['report'], 'Final Report');
      expect(map['year'], 2020);
    });

    test('fromMap constructs correctly', () {
      final map = {
        'organization': 'FromMap Org',
        'organization_url': 'https://frommap.com',
        'technical_writer': 'Jane',
        'mentor': 'John',
        'project': 'Docs Project',
        'project_url': 'https://frommap.com/proj',
        'report': 'Report',
        'report_url': 'https://frommap.com/report',
        'original_project_proposal': 'Proposal',
        'original_project_proposal_url': 'https://frommap.com/proposal',
        'year': 2019,
      };
      final modal = GsodModalOld.fromMap(map);
      expect(modal.organizationName, 'FromMap Org');
      expect(modal.technicalWriter, 'Jane');
      expect(modal.year, 2019);
    });

    test('fromMap handles missing fields with empty string defaults', () {
      final modal = GsodModalOld.fromMap({});
      expect(modal.organizationName, '');
      expect(modal.technicalWriter, '');
      expect(modal.year, 0);
    });

    test('equality operator works correctly', () {
      final other = GsodModalOld(
        organizationName: 'TestOrg',
        organizationUrl: 'https://testorg.com',
        technicalWriter: 'Alice Writer',
        mentor: 'Bob Mentor',
        project: 'Improve Documentation',
        projectUrl: 'https://testorg.com/project',
        report: 'Final Report',
        reportUrl: 'https://testorg.com/report',
        originalProjectProposal: 'Original Proposal',
        originalProjectProposalUrl: 'https://testorg.com/proposal',
        year: 2020,
      );
      expect(tModal == other, isTrue);
    });

    test('inequality when fields differ', () {
      final other = tModal.copyWith(year: 2021);
      expect(tModal == other, isFalse);
    });

    test('hashCode is consistent for equal objects', () {
      final other = tModal.copyWith();
      expect(tModal.hashCode, equals(other.hashCode));
    });

    test('toJson returns valid JSON string', () {
      final jsonStr = tModal.toJson();
      expect(jsonStr, isA<String>());
      expect(jsonStr.contains('TestOrg'), isTrue);
    });

    test('toString contains key fields', () {
      final str = tModal.toString();
      expect(str, contains('TestOrg'));
      expect(str, contains('Alice Writer'));
      expect(str, contains('2020'));
    });
  });
}
