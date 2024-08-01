class HyperledgerProjectModal {
  String name;
  String wiki;
  List<String> mentors;
  String year;

  HyperledgerProjectModal({
    required this.name,
    required this.wiki,
    required this.mentors,
    required this.year,
  });

  factory HyperledgerProjectModal.fromJson(Map<String, dynamic> json) {
    List<String> mentorsList = [];
    if (json['mentors'] is List) {
      mentorsList = List<String>.from(json['mentors']);
    } else if (json['mentors'] is String) {
      mentorsList = [json['mentors']];
    }

    return HyperledgerProjectModal(
      name: json['title'],
      wiki: json['link'],
      mentors: mentorsList,
      year: json['year'].toString(), // Ensure year is converted to string if necessary
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'link': wiki,
      'mentors': mentors,
      'year': year,
    };
  }

  @override
  String toString() {
    return 'HyperledgerProjectModal(name: $name, wiki: $wiki, mentors: $mentors, year: $year)';
  }
}
