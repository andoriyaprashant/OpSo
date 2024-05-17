class Gsoc {
  int? year;
  String? archiveUrl;
  List<Organizations>? organizations;

  Gsoc({this.year, this.archiveUrl, this.organizations});

  Gsoc.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    archiveUrl = json['archive_url'];
    if (json['organizations'] != null) {
      organizations = <Organizations>[];
      json['organizations'].forEach((v) {
        organizations!.add(Organizations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['archive_url'] = archiveUrl;
    if (organizations != null) {
      data['organizations'] = organizations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Organizations {
  String? name;
  String? imageUrl;
  String? imageBackgroundColor;
  String? description;
  String? url;
  String? category;
  String? projectsUrl;
  String? ideasUrl;
  String? guideUrl;
  List<String>? topics;
  List<String>? technologies;
  String? ircChannel;
  String? contactEmail;
  String? mailingList;
  String? twitterUrl;
  String? blogUrl;
  String? facebookUrl;
  int? numProjects;
  List<Project>? projects;

  Organizations({
    this.name,
    this.imageUrl,
    this.imageBackgroundColor,
    this.description,
    this.url,
    this.category,
    this.projectsUrl,
    this.ideasUrl,
    this.guideUrl,
    this.topics,
    this.technologies,
    this.ircChannel,
    this.contactEmail,
    this.mailingList,
    this.twitterUrl,
    this.blogUrl,
    this.facebookUrl,
    this.numProjects,
    this.projects,
  });

  Organizations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['image_url'];
    imageBackgroundColor = json['image_background_color'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    projectsUrl = json['projects_url'];
    ideasUrl = json['ideas_url'];
    guideUrl = json['guide_url'];
    topics = List<String>.from(json['topics'] ?? []);
    technologies = List<String>.from(json['technologies'] ?? []);
    ircChannel = json['irc_channel'];
    contactEmail = json['contact_email'];
    mailingList = json['mailing_list'];
    twitterUrl = json['twitter_url'];
    blogUrl = json['blog_url'];
    facebookUrl = json['facebook_url'];
    numProjects = json['num_projects'];
    if (json['projects'] != null) {
      projects = <Project>[];
      json['projects'].forEach((v) {
        projects!.add(Project.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['image_background_color'] = imageBackgroundColor;
    data['description'] = description;
    data['url'] = url;
    data['category'] = category;
    data['projects_url'] = projectsUrl;
    data['ideas_url'] = ideasUrl;
    data['guide_url'] = guideUrl;
    data['topics'] = topics;
    data['technologies'] = technologies;
    data['irc_channel'] = ircChannel;
    data['contact_email'] = contactEmail;
    data['mailing_list'] = mailingList;
    data['twitter_url'] = twitterUrl;
    data['blog_url'] = blogUrl;
    data['facebook_url'] = facebookUrl;
    data['num_projects'] = numProjects;
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Project {
  String? name;
  String? description;
  String? url;

  Project({
    this.name,
    this.description,
    this.url,
  });

  Project.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['url'] = url;
    return data;
  }
}