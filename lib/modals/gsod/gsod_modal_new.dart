// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// This will modal the Google Summer of Docs projects from year 2021 to 2023
class GsodModalNew {
  String organizationName;
  String organizationUrl;
  String docsPage;
  String docsPageUrl;
  String budget;
  String budgetUrl;
  String acceptedProjectProposal;
  String acceptedProjectProposalUrl;
  String caseStudy;
  String caseStudyUrl;
  int year;
  GsodModalNew({
    required this.organizationName,
    required this.organizationUrl,
    required this.docsPage,
    required this.docsPageUrl,
    required this.budget,
    required this.budgetUrl,
    required this.acceptedProjectProposal,
    required this.acceptedProjectProposalUrl,
    required this.caseStudy,
    required this.caseStudyUrl,
    required this.year,
  });

  GsodModalNew copyWith({
    String? organizationName,
    String? organizationUrl,
    String? docsPage,
    String? docsPageUrl,
    String? budget,
    String? budgetUrl,
    String? acceptedProjectProposal,
    String? acceptedProjectProposalUrl,
    String? caseStudy,
    String? caseStudyUrl,
    int? year,
  }) {
    return GsodModalNew(
      organizationName: organizationName ?? this.organizationName,
      organizationUrl: organizationUrl ?? this.organizationUrl,
      docsPage: docsPage ?? this.docsPage,
      docsPageUrl: docsPageUrl ?? this.docsPageUrl,
      budget: budget ?? this.budget,
      budgetUrl: budgetUrl ?? this.budgetUrl,
      acceptedProjectProposal:
          acceptedProjectProposal ?? this.acceptedProjectProposal,
      acceptedProjectProposalUrl:
          acceptedProjectProposalUrl ?? this.acceptedProjectProposalUrl,
      caseStudy: caseStudy ?? this.caseStudy,
      caseStudyUrl: caseStudyUrl ?? this.caseStudyUrl,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organization_name': organizationName,
      'organization_url': organizationUrl,
      'docs_page': docsPage,
      'docs_page_url': docsPageUrl,
      'budget': budget,
      'budget_url': budgetUrl,
      'accepted_project_proposal': acceptedProjectProposal,
      'accepted_project_proposal_url': acceptedProjectProposalUrl,
      'case_study': caseStudy,
      'case_study_url': caseStudyUrl,
      'year': year,
    };
  }

  factory GsodModalNew.fromMap(Map<String, dynamic> map) {
    return GsodModalNew(
      organizationName: map['organization_name'] ?? "",
      organizationUrl: map['organization_url'] ?? "",
      docsPage: map['docs_page'] ?? "",
      docsPageUrl: map['docs_page_url'] ?? "",
      budget: map['budget'] ?? "",
      budgetUrl: map['budget_url'] ?? "",
      acceptedProjectProposal: map['accepted_project_proposal'] ?? "",
      acceptedProjectProposalUrl: map['accepted_project_proposal_url'] ?? "",
      caseStudy: map['case_study'] ?? "",
      caseStudyUrl: map['case_study_url'] ?? "",
      year: map['year'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GsodModalNew.fromJson(String source) =>
      GsodModalNew.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GsodModalNew(organizationName: $organizationName, organizationUrl: $organizationUrl, docsPage: $docsPage, docsPageUrl: $docsPageUrl, budget: $budget, budgetUrl: $budgetUrl, acceptedProjectProposal: $acceptedProjectProposal, acceptedProjectProposalUrl: $acceptedProjectProposalUrl, caseStudy: $caseStudy, caseStudyUrl: $caseStudyUrl, year: $year)';
  }

  @override
  bool operator ==(covariant GsodModalNew other) {
    if (identical(this, other)) return true;

    return other.organizationName == organizationName &&
        other.organizationUrl == organizationUrl &&
        other.docsPage == docsPage &&
        other.docsPageUrl == docsPageUrl &&
        other.budget == budget &&
        other.budgetUrl == budgetUrl &&
        other.acceptedProjectProposal == acceptedProjectProposal &&
        other.acceptedProjectProposalUrl == acceptedProjectProposalUrl &&
        other.caseStudy == caseStudy &&
        other.caseStudyUrl == caseStudyUrl &&
        other.year == year;
  }

  @override
  int get hashCode {
    return organizationName.hashCode ^
        organizationUrl.hashCode ^
        docsPage.hashCode ^
        docsPageUrl.hashCode ^
        budget.hashCode ^
        budgetUrl.hashCode ^
        acceptedProjectProposal.hashCode ^
        acceptedProjectProposalUrl.hashCode ^
        caseStudy.hashCode ^
        caseStudyUrl.hashCode ^
        year.hashCode;
  }
}
