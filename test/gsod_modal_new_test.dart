import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/gsod/gsod_modal_new.dart';

void main() {
  group('GsodModalNew', () {
    final tModal = GsodModalNew(
      organizationName: 'TestOrg',
      organizationUrl: 'https://testorg.com',
      docsPage: 'Documentation',
      docsPageUrl: 'https://testorg.com/docs',
      budget: '10000',
      budgetUrl: 'https://testorg.com/budget',
      acceptedProjectProposal: 'Test Proposal',
      acceptedProjectProposalUrl: 'https://testorg.com/proposal',
      caseStudy: 'Test Case Study',
      caseStudyUrl: 'https://testorg.com/case-study',
      year: 2023,
    );

    test('constructor sets all fields correctly', () {
      expect(tModal.organizationName, 'TestOrg');
      expect(tModal.organizationUrl, 'https://testorg.com');
      expect(tModal.docsPage, 'Documentation');
      expect(tModal.budget, '10000');
      expect(tModal.acceptedProjectProposal, 'Test Proposal');
      expect(tModal.caseStudy, 'Test Case Study');
      expect(tModal.year, 2023);
    });

    test('copyWith updates selected fields', () {
      final updated = tModal.copyWith(organizationName: 'NewOrg', year: 2024);
      expect(updated.organizationName, 'NewOrg');
      expect(updated.year, 2024);
      expect(updated.budget, tModal.budget);
      expect(updated.docsPage, tModal.docsPage);
    });

    test('copyWith with no args returns equivalent object', () {
      final copy = tModal.copyWith();
      expect(copy.organizationName, tModal.organizationName);
      expect(copy.year, tModal.year);
    });

    test('toMap returns correct map', () {
      final map = tModal.toMap();
      expect(map['organization_name'], 'TestOrg');
      expect(map['organization_url'], 'https://testorg.com');
      expect(map['budget'], '10000');
      expect(map['year'], 2023);
    });

    test('fromMap constructs correctly', () {
      final map = {
        'organization_name': 'FromMap Org',
        'organization_url': 'https://frommap.com',
        'docs_page': 'Docs',
        'docs_page_url': 'https://frommap.com/docs',
        'budget': '5000',
        'budget_url': 'https://frommap.com/budget',
        'accepted_project_proposal': 'Proposal',
        'accepted_project_proposal_url': 'https://frommap.com/proposal',
        'case_study': 'Case',
        'case_study_url': 'https://frommap.com/case',
        'year': 2022,
      };
      final modal = GsodModalNew.fromMap(map);
      expect(modal.organizationName, 'FromMap Org');
      expect(modal.budget, '5000');
      expect(modal.year, 2022);
    });

    test('fromMap handles missing fields with defaults', () {
      final modal = GsodModalNew.fromMap({});
      expect(modal.organizationName, '');
      expect(modal.budget, '');
      expect(modal.year, 0);
    });

    test('equality operator works correctly', () {
      final other = GsodModalNew(
        organizationName: 'TestOrg',
        organizationUrl: 'https://testorg.com',
        docsPage: 'Documentation',
        docsPageUrl: 'https://testorg.com/docs',
        budget: '10000',
        budgetUrl: 'https://testorg.com/budget',
        acceptedProjectProposal: 'Test Proposal',
        acceptedProjectProposalUrl: 'https://testorg.com/proposal',
        caseStudy: 'Test Case Study',
        caseStudyUrl: 'https://testorg.com/case-study',
        year: 2023,
      );
      expect(tModal == other, isTrue);
    });

    test('inequality when fields differ', () {
      final other = tModal.copyWith(year: 2024);
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
      expect(str, contains('10000'));
      expect(str, contains('2023'));
    });
  });
}
