// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GssocProjectModal {
  String name;
  String githubUrl;
  List<String> techstack;
  String hostedBy;
  String year;

  GssocProjectModal(
      {required this.name,
      required this.githubUrl,
      required this.techstack,
      required this.hostedBy,
      required this.year});

  GssocProjectModal copyWith({
    String? name,
    String? githubUrl,
    List<String>? techstack,
    String? hostedBy,
    String? year,
  }) {
    return GssocProjectModal(
      name: name ?? this.name,
      githubUrl: githubUrl ?? this.githubUrl,
      techstack: techstack ?? this.techstack,
      hostedBy: hostedBy ?? this.hostedBy,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'githubUrl': githubUrl,
      'techstack': techstack,
      'hostedBy': hostedBy,
      'year': year,
    };
  }

  factory GssocProjectModal.fromMap(Map<String, dynamic> map) {
    return GssocProjectModal(
      name: map['name'] as String,
      githubUrl: map['githubUrl'] as String,
      hostedBy: map['hostedBy'] as String,
      year: map['year'] as String,
      techstack: List<String>.from((map['techstack'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory GssocProjectModal.getDataFromJson(dynamic data) {
    List<String> tech = [];
    for (String t in data['techstack']) {
      tech.add(t);
    }
    return GssocProjectModal(
      githubUrl: data['githubUrl'],
      hostedBy: data['hostedBy'],
      name: data['name'],
      techstack: tech,
      year: data['year'],
    );
  }

  @override
  String toString() {
    return 'GssocProjectModal(name: $name, githubUrl: $githubUrl, techstack: $techstack, hostedBy: $hostedBy, year: $year)';
  }
}
