// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class OsocModal {
  String name = "";
  String image_url = "";
  String description = "";
  String project_url = "";
  int year = 0;
  OsocModal({
    required this.name,
    required this.image_url,
    required this.description,
    required this.project_url,
    required this.year,
  });

  OsocModal copyWith({
    String? name,
    String? image_url,
    String? description,
    String? project_url,
    int? year,
  }) {
    return OsocModal(
      name: name ?? this.name,
      image_url: image_url ?? this.image_url,
      description: description ?? this.description,
      project_url: project_url ?? this.project_url,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image_url': image_url,
      'description': description,
      'project_url': project_url,
      'year': year,
    };
  }

  factory OsocModal.fromMap(Map<String, dynamic> map) {
    return OsocModal(
      name: map['name'] as String,
      image_url: map['image_url'] as String,
      description: map['description'] as String,
      project_url: map['project_url'] as String,
      year: map['year'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OsocModal.fromJson(String source) =>
      OsocModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OsocModal(name: $name, image_url: $image_url, description: $description, project_url: $project_url, year: $year)';
  }

  @override
  bool operator ==(covariant OsocModal other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image_url == image_url &&
        other.description == description &&
        other.project_url == project_url &&
        other.year == year;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image_url.hashCode ^
        description.hashCode ^
        project_url.hashCode ^
        year.hashCode;
  }
}
