class FOSSASIAProjectModel {
  String name;
  String description;
  List<String> techStack;
  String link;
  String year;

  FOSSASIAProjectModel({
    required this.name,
    required this.description,
    required this.techStack,
    required this.link,
    required this.year,
  });

  factory FOSSASIAProjectModel.fromJson(Map<String, dynamic> json) {
    List<String> techStackList = [];
    if (json['TechStack'] is List) {
      techStackList = List<String>.from(json['TechStack']);
    } else if (json['TechStack'] is String) {
      techStackList = [json['TechStack']];
    }

    return FOSSASIAProjectModel(
      name: json['Name'],
      description: json['Description'],
      techStack: techStackList,
      link: json['link'],
      year: json['Year'].toString(), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Description': description,
      'TechStack': techStack,
      'link': link,
      'Year': year,
    };
  }

  @override
  String toString() {
    return 'FOSSASIAProjectModel(name: $name, description: $description, techStack: $techStack, link: $link, year: $year)';
  }
}
