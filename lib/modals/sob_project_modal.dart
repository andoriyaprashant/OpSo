// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SobProjectModal {
  String name;
  String organization;
  String description;
  String mentor;
  String university;
  String country;
  List<String> projects;
  int year;
  SobProjectModal({
    required this.name,
    required this.organization,
    required this.description,
    required this.mentor,
    required this.university,
    required this.country,
    required this.projects,
    required this.year,
  });

  SobProjectModal copyWith({
    String? name,
    String? organization,
    String? description,
    String? mentor,
    String? university,
    String? country,
    List<String>? projects,
    int? year,
  }) {
    return SobProjectModal(
        name: name ?? this.name,
        organization: organization ?? this.organization,
        description: description ?? this.description,
        mentor: mentor ?? this.mentor,
        university: university ?? this.university,
        country: country ?? this.country,
        projects: projects ?? this.projects,
        year: year ?? this.year);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'organization': organization,
      'description': description,
      'mentor': mentor,
      'university': university,
      'country': country,
      'project_links': projects,
      'year': year,
    };
  }

  factory SobProjectModal.fromMap(Map<String, dynamic> map) {
    List<String> projects = [];
    for (var project in map["project_links"] ?? []) {
      projects.add(project);
    }
    var modal = SobProjectModal(
      name: map['name'] ?? "",
      organization: map['organization'] ?? "",
      description: map['description'] ?? "",
      mentor: map['mentor'] ?? "",
      university: map['university'] ?? "",
      country: map['country'] ?? "",
      projects: projects,
      year: map['year'] ?? 0,
    );
    // print(modal);

    return modal;
  }

  String toJson() => json.encode(toMap());

  factory SobProjectModal.fromJson(String source) =>
      SobProjectModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SobProjectModal(name: $name, organization: $organization, description: $description, mentor: $mentor, university: $university, country: $country, projects: $projects)';
  }

  @override
  bool operator ==(covariant SobProjectModal other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.organization == organization &&
        other.description == description &&
        other.mentor == mentor &&
        other.university == university &&
        other.country == country &&
        listEquals(other.projects, projects);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        organization.hashCode ^
        description.hashCode ^
        mentor.hashCode ^
        university.hashCode ^
        country.hashCode ^
        projects.hashCode;
  }
}
