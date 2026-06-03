import 'package:flutter_test/flutter_test.dart';
import 'package:opso/modals/GSoC/Gsoc.dart';

void main() {
  group('Project', () {
    test('fromJson constructs correctly', () {
      final json = {
        'title': 'Test Project',
        'short_description': 'Short desc',
        'description': 'Full description',
        'student_name': 'Alice',
        'code_url': 'https://github.com/alice/project',
        'project_url': 'https://summerofcode.withgoogle.com/project',
      };
      final project = Project.fromJson(json);
      expect(project.title, 'Test Project');
      expect(project.shortDescription, 'Short desc');
      expect(project.description, 'Full description');
      expect(project.studentName, 'Alice');
      expect(project.codeUrl, 'https://github.com/alice/project');
      expect(project.projectUrl, 'https://summerofcode.withgoogle.com/project');
    });

    test('fromJson handles missing fields with empty string defaults', () {
      final project = Project.fromJson({});
      expect(project.title, '');
      expect(project.shortDescription, '');
      expect(project.description, '');
      expect(project.studentName, '');
      expect(project.codeUrl, '');
      expect(project.projectUrl, '');
    });
  });

  group('Organization', () {
    final orgJson = {
      'name': 'TestOrg',
      'image_url': 'https://example.com/image.png',
      'image_background_color': '#FFFFFF',
      'description': 'A test organization',
      'url': 'https://testorg.com',
      'num_projects': 5,
      'category': 'programming languages and development tools',
      'projects_url': 'https://testorg.com/projects',
      'irc_channel': '#testorg',
      'contact_email': 'contact@testorg.com',
      'mailing_list': 'list@testorg.com',
      'twitter_url': 'https://twitter.com/testorg',
      'blog_url': 'https://blog.testorg.com',
      'topics': ['machine learning', 'AI'],
      'technologies': ['Python', 'TensorFlow'],
      'projects': [],
    };

    test('fromJson constructs correctly', () {
      final org = Organization.fromJson(orgJson);
      expect(org.name, 'TestOrg');
      expect(org.numProjects, 5);
      expect(org.topics, ['machine learning', 'AI']);
      expect(org.technologies, ['Python', 'TensorFlow']);
      expect(org.projects, isEmpty);
    });

    test('fromJson handles missing fields with defaults', () {
      final org = Organization.fromJson({});
      expect(org.name, '');
      expect(org.numProjects, 0);
      expect(org.topics, isEmpty);
      expect(org.technologies, isEmpty);
      expect(org.projects, isEmpty);
    });

    test('fromJson parses nested projects', () {
      final jsonWithProjects = Map<String, dynamic>.from(orgJson);
      jsonWithProjects['projects'] = [
        {
          'title': 'Nested Project',
          'short_description': '',
          'description': '',
          'student_name': 'Bob',
          'code_url': '',
          'project_url': '',
        }
      ];
      final org = Organization.fromJson(jsonWithProjects);
      expect(org.projects, hasLength(1));
      expect(org.projects.first.title, 'Nested Project');
      expect(org.projects.first.studentName, 'Bob');
    });
  });

  group('Gsoc', () {
    test('fromJson constructs correctly', () {
      final json = {
        'year': 2023,
        'archive_url': 'https://summerofcode.withgoogle.com/archive',
        'organizations': [],
      };
      final gsoc = Gsoc.fromJson(json);
      expect(gsoc.year, 2023);
      expect(gsoc.archiveUrl, 'https://summerofcode.withgoogle.com/archive');
      expect(gsoc.organizations, isEmpty);
    });

    test('fromJson handles missing archive_url', () {
      final json = {
        'year': 2022,
        'organizations': [],
      };
      final gsoc = Gsoc.fromJson(json);
      expect(gsoc.archiveUrl, '');
    });

    test('fromJson parses nested organizations', () {
      final json = {
        'year': 2021,
        'archive_url': '',
        'organizations': [
          {
            'name': 'Org1',
            'image_url': '',
            'image_background_color': '',
            'description': '',
            'url': '',
            'num_projects': 2,
            'category': '',
            'projects_url': '',
            'irc_channel': '',
            'contact_email': '',
            'mailing_list': '',
            'twitter_url': '',
            'blog_url': '',
            'topics': [],
            'technologies': [],
            'projects': [],
          }
        ],
      };
      final gsoc = Gsoc.fromJson(json);
      expect(gsoc.organizations, hasLength(1));
      expect(gsoc.organizations.first.name, 'Org1');
      expect(gsoc.organizations.first.numProjects, 2);
    });
  });
}
