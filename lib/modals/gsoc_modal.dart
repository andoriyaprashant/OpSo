import 'dart:convert';

class GsocProjectModel {
  String name;
  String githubUrl;
  List<String> techstack;
  String hostedBy;
  String year;

  GsocProjectModel({
    required this.name,
    required this.githubUrl,
    required this.techstack,
    required this.hostedBy,
    required this.year,
  });

  GsocProjectModel copyWith({
    String? name,
    String? githubUrl,
    List<String>? techstack,
    String? hostedBy,
    String? year,
  }) {
    return GsocProjectModel(
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

  factory GsocProjectModel.fromMap(Map<String, dynamic> map) {
    return GsocProjectModel(
      name: map['name'] as String,
      githubUrl: map['githubUrl'] as String,
      hostedBy: map['hostedBy'] as String,
      year: map['year'] as String,
      techstack: List<String>.from((map['techstack'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory GsocProjectModel.getDataFromJson(dynamic data) {
    List<String> tech = [];
    for (String t in data['techstack']) {
      tech.add(t);
    }
    return GsocProjectModel(
      githubUrl: data['githubUrl'],
      hostedBy: data['hostedBy'],
      name: data['name'],
      techstack: tech,
      year: data['year'],
    );
  }

  @override
  String toString() {
    return 'GsocProjectModel(name: $name, githubUrl: $githubUrl, techstack: $techstack, hostedBy: $hostedBy, year: $year)';
  }
}
