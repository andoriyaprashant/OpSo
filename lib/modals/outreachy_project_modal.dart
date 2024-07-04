import 'dart:convert';

class OutreachyProjectModal {
  String name;
  String description;
  List<String> skills;
  int spots;
  int year;

  OutreachyProjectModal({
    required this.name,
    required this.description,
    required this.skills,
    required this.spots,
    required this.year,
  });

  OutreachyProjectModal copyWith({
    String? name,
    String? description,
    List<String>? skills,
    int? spots,
    int? year,
  }) {
    return OutreachyProjectModal(
      name: name ?? this.name,
      description: description ?? this.description,
      skills: skills ?? this.skills,
      spots: spots ?? this.spots,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'skills': skills,
      'spots': spots,
      'year': year,
    };
  }

  factory OutreachyProjectModal.fromMap(Map<String, dynamic> map) {
    return OutreachyProjectModal(
      name: map['name'] as String,
      description: map['description'] as String,
      skills: List<String>.from(map['skills'] as List),
      spots: map['spots'] as int,
      year: map['year'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OutreachyProjectModal.fromJson(String source) =>
      OutreachyProjectModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OutreachyProjectModal(name: $name, description: $description, skills: $skills, spots: $spots, year: $year)';
  }
}