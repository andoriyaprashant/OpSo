// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// This file will modal the projects in Google Summer of docs for year 2019 to 2020
class GsodModalOld {
  String organizationName;
  String organizationUrl;
  String technicalWriter;
  String mentor;
  String project;
  String projectUrl;
  String report;
  String reportUrl;
  String originalProjectProposal;
  String originalProjectProposalUrl;
  int year;
  GsodModalOld({
    required this.organizationName,
    required this.organizationUrl,
    required this.technicalWriter,
    required this.mentor,
    required this.project,
    required this.projectUrl,
    required this.report,
    required this.reportUrl,
    required this.originalProjectProposal,
    required this.originalProjectProposalUrl,
    required this.year,
  });

  GsodModalOld copyWith({
    String? organization,
    String? organizationUrl,
    String? technicalWriter,
    String? mentor,
    String? project,
    String? projectUrl,
    String? report,
    String? reportUrl,
    String? originalProjectProposal,
    String? originalProjectProposalUrl,
    int? year,
  }) {
    return GsodModalOld(
      organizationName: organization ?? this.organizationName,
      organizationUrl: organizationUrl ?? this.organizationUrl,
      technicalWriter: technicalWriter ?? this.technicalWriter,
      mentor: mentor ?? this.mentor,
      project: project ?? this.project,
      projectUrl: projectUrl ?? this.projectUrl,
      report: report ?? this.report,
      reportUrl: reportUrl ?? this.reportUrl,
      originalProjectProposal:
          originalProjectProposal ?? this.originalProjectProposal,
      originalProjectProposalUrl:
          originalProjectProposalUrl ?? this.originalProjectProposalUrl,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organization': organizationName,
      'organization_url': organizationUrl,
      'technical_writer': technicalWriter,
      'mentor': mentor,
      'project': project,
      'project_url': projectUrl,
      'report': report,
      'report_url': reportUrl,
      'original_project_proposal': originalProjectProposal,
      'original_project_proposal_url': originalProjectProposalUrl,
      'year': year,
    };
  }

  factory GsodModalOld.fromMap(Map<String, dynamic> map) {
    return GsodModalOld(
      organizationName: map['organization'] ?? "",
      organizationUrl: map['organization_url'] ?? "",
      technicalWriter: map['technical_writer'] ?? "",
      mentor: map['mentor'] ?? "",
      project: map['project'] ?? "",
      projectUrl: map['project_url'] ?? "",
      report: map['report'] ?? "",
      reportUrl: map['report_url'] ?? "",
      originalProjectProposal: map['original_project_proposal'] ?? "",
      originalProjectProposalUrl: map['original_project_proposal_url'] ?? "",
      year: map['year'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GsodModalOld.fromJson(String source) =>
      GsodModalOld.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GsodModalOld(organization: $organizationName, organizationUrl: $organizationUrl, technicalWriter: $technicalWriter, mentor: $mentor, project: $project, projectUrl: $projectUrl, report: $report, reportUrl: $reportUrl, originalProjectProposal: $originalProjectProposal, originalProjectProposalUrl: $originalProjectProposalUrl, year: $year)';
  }

  @override
  bool operator ==(covariant GsodModalOld other) {
    if (identical(this, other)) return true;

    return other.organizationName == organizationName &&
        other.organizationUrl == organizationUrl &&
        other.technicalWriter == technicalWriter &&
        other.mentor == mentor &&
        other.project == project &&
        other.projectUrl == projectUrl &&
        other.report == report &&
        other.reportUrl == reportUrl &&
        other.originalProjectProposal == originalProjectProposal &&
        other.originalProjectProposalUrl == originalProjectProposalUrl &&
        other.year == year;
  }

  @override
  int get hashCode {
    return organizationName.hashCode ^
        organizationUrl.hashCode ^
        technicalWriter.hashCode ^
        mentor.hashCode ^
        project.hashCode ^
        projectUrl.hashCode ^
        report.hashCode ^
        reportUrl.hashCode ^
        originalProjectProposal.hashCode ^
        originalProjectProposalUrl.hashCode ^
        year.hashCode;
  }
}
