class GsocModel {
  String? organization;
  String? organizationUrl;
  String? technicalWriter;
  String? mentor;
  String? project;
  String? projectUrl;
  String? report;
  String? reportUrl;
  String? originalProjectProposal;
  String? acceptedProjectProposalUrl;
  int? year;

  GsocModel(
      {this.organization,
        this.organizationUrl,
        this.technicalWriter,
        this.mentor,
        this.project,
        this.projectUrl,
        this.report,
        this.reportUrl,
        this.originalProjectProposal,
        this.acceptedProjectProposalUrl,
        this.year});

  GsocModel.fromJson(Map<String, dynamic> json) {
    organization = json['organization_name'];
    organizationUrl = json['organization_url'];
    technicalWriter = json['technical_writer'];
    mentor = json['mentor'];
    project = json['project'];
    projectUrl = json['project_url'];
    report = json['report'];
    reportUrl = json['report_url'];
    originalProjectProposal = json['accepted_project_proposal'];
    acceptedProjectProposalUrl = json['accepted_project_proposal_url'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_name'] = this.organization;
    data['organization_url'] = this.organizationUrl;
    data['technical_writer'] = this.technicalWriter;
    data['mentor'] = this.mentor;
    data['project'] = this.project;
    data['project_url'] = this.projectUrl;
    data['report'] = this.report;
    data['report_url'] = this.reportUrl;
    data['accepted_project_proposal'] = this.originalProjectProposal;
    data['accepted_project_proposal_url'] = this.acceptedProjectProposalUrl;
    data['year'] = this.year;
    return data;
  }
}