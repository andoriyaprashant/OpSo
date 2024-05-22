// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LinuxFoundationModal {
  String name;
  String projectUrl;
  String imageUrl;
  LinuxFoundationModal({
    required this.name,
    required this.projectUrl,
    required this.imageUrl,
  });

  LinuxFoundationModal copyWith({
    String? name,
    String? projectUrl,
    String? imageUrl,
  }) {
    return LinuxFoundationModal(
      name: name ?? this.name,
      projectUrl: projectUrl ?? this.projectUrl,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'project_url': projectUrl,
      'image_url': imageUrl,
    };
  }

  factory LinuxFoundationModal.fromMap(Map<String, dynamic> map) {
    return LinuxFoundationModal(
      name: map['name'] as String,
      projectUrl: map['project_url'] as String,
      imageUrl: map['image_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LinuxFoundationModal.fromJson(String source) =>
      LinuxFoundationModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LinuxFoundationModal(name: $name, projectUrl: $projectUrl, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant LinuxFoundationModal other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.projectUrl == projectUrl &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => name.hashCode ^ projectUrl.hashCode ^ imageUrl.hashCode;
}
