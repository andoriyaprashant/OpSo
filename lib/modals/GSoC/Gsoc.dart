class Gsoc {
  final int year;
  final String archiveUrl;
  final List<Organization> organizations;

  Gsoc({
    required this.year,
    required this.archiveUrl,
    required this.organizations,
  });

  factory Gsoc.fromJson(Map<String, dynamic> json) {
    return Gsoc(
      year: json['year'],
      archiveUrl: json['archive_url'] ?? '',
      organizations: (json['organizations'] as List)
          .map((org) => Organization.fromJson(org))
          .toList(),
    );
  }
}

class Organization {
  final String name;
  final String imageUrl;
  final String imageBackgroundColor;
  final String description;
  final String url;
  final int numProjects;
  final String category;
  final String projectsUrl;
  final String ircChannel;
  final String contactEmail;
  final String mailingList;
  final String twitterUrl;
  final String blogUrl;
  final List<String> topics;
  final List<String> technologies;
  final List<Project> projects;

  Organization({
    required this.name,
    required this.imageUrl,
    required this.imageBackgroundColor,
    required this.description,
    required this.url,
    required this.numProjects,
    required this.category,
    required this.projectsUrl,
    required this.ircChannel,
    required this.contactEmail,
    required this.mailingList,
    required this.twitterUrl,
    required this.blogUrl,
    required this.topics,
    required this.technologies,
    required this.projects,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      imageBackgroundColor: json['image_background_color'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      numProjects: json['num_projects'] ?? 0,
      category: json['category'] ?? '',
      projectsUrl: json['projects_url'] ?? '',
      ircChannel: json['irc_channel'] ?? '',
      contactEmail: json['contact_email'] ?? '',
      mailingList: json['mailing_list'] ?? '',
      twitterUrl: json['twitter_url'] ?? '',
      blogUrl: json['blog_url'] ?? '',
      topics: (json['topics'] as List?)?.map((item) => item as String).toList() ?? [],
      technologies: (json['technologies'] as List?)?.map((item) => item as String).toList() ?? [],
      projects: (json['projects'] as List?)
          ?.map((project) => Project.fromJson(project))
          .toList() ??
          [],
    );
  }
}

class Project {
  final String title;
  final String shortDescription;
  final String description;
  final String studentName;
  final String codeUrl;
  final String projectUrl;

  Project({
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.studentName,
    required this.codeUrl,
    required this.projectUrl,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] ?? '',
      shortDescription: json['short_description'] ?? '',
      description: json['description'] ?? '',
      studentName: json['student_name'] ?? '',
      codeUrl: json['code_url'] ?? '',
      projectUrl: json['project_url'] ?? '',
    );
  }
}