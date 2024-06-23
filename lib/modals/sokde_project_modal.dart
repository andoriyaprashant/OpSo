class SokdeProjectModal {
  String name;
  String wiki;
  List<String> mentees;
  List<String> mentors;
  String year;

  SokdeProjectModal({
    required this.name,
    required this.wiki,
    required this.mentees,
    required this.mentors,
    required this.year,
  });

  factory SokdeProjectModal.fromJson(Map<String, dynamic> json) {
    List<String> mentorsList = [];
    if (json['mentors'] is List) {
      mentorsList = List<String>.from(json['mentors']);
    } else if (json['mentors'] is String) {
      mentorsList = [json['mentors']];
    }

    List<String> menteesList = [];
    if (json['mentees'] is List) {
      menteesList = List<String>.from(json['mentees']);
    } else if (json['mentees'] is String) {
      menteesList = [json['mentees']];
    }

    return SokdeProjectModal(
      name: json['title'],
      wiki: json['link'],
      mentors: mentorsList,
      mentees: menteesList,
      year: json['year'].toString(), // Ensure year is converted to string if necessary
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'link': wiki,
      'mentors': mentors,
      'mentees': mentees,
      'year': year,
    };
  }

  @override
  String toString() {
    return 'SokdeProjectModal(name: $name, wiki: $wiki, mentees: $mentees, mentors: $mentors, year: $year)';
  }
}
