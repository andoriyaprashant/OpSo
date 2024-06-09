import 'dart:convert';

class SwocProjectModal {
  String name;
  String repo;
  List<String> techstack;
  String owner;
  String year;

  SwocProjectModal({
    required this.name,
    required this.repo,
    required this.techstack,
    required this.owner,
    required this.year,
  });

  SwocProjectModal copyWith({
    String? name,
    String? repo,
    List<String>? techstack,
    String? owner,
    String? year,
  }) {
    return SwocProjectModal(
      name: name ?? this.name,
      repo: repo ?? this.repo,
      techstack: techstack ?? this.techstack,
      owner: owner ?? this.owner,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': name,
      'Repo': repo,
      'TechStack': techstack,
      'Owner': owner,
      'Year': year,
    };
  }

  factory SwocProjectModal.fromMap(Map<String, dynamic> map) {
    return SwocProjectModal(
      name: map['Name'] as String,
      repo: map['Repo'] as String,
      owner: map['Owner'] as String,
      year: map['Year'] as String,
      techstack: List<String>.from(map['TechStack'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory SwocProjectModal.getDataFromJson(dynamic data) {
    List<String> tech = [];
    for (String t in data['TechStack']) {
      tech.add(t);
    }
    return SwocProjectModal(
      repo: data['Repo'],
      owner: data['Owner'],
      name: data['Name'],
      techstack: tech,
      year: data['Year'],
    );
  }

  @override
  String toString() {
    return 'SwocProjectModal(Name: $name, Repo: $repo, TechStack: $techstack, Owner: $owner, Year: $year)';
  }
}
