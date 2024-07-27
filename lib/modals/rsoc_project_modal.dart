class RsocProjectModal {
  String name;
  String contributor;
  String description;
  String githubUrl;

  RsocProjectModal({
    required this.name,
    required this.contributor,
    required this.description,
    required this.githubUrl,
  });

  factory RsocProjectModal.fromJson(Map<String, dynamic> json) {
    return RsocProjectModal(
      name: json['name'],
      contributor: json['contributor'],
      description: json['description'],
      githubUrl: json['githubUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contributor': contributor,
      'description': description,
      'githubUrl': githubUrl,
    };
  }

  @override
  String toString() {
    return 'RsocProjectModal(name: $name, contributor: $contributor, description: $description, githubUrl: $githubUrl)';
  }
}
