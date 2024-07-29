import 'package:dio/dio.dart';


import '../modals/GSoC/Gsoc.dart';

class ApiService {
  // All org
  final String baseUrl = 'https://api.gsocorganizations.dev/';

  Future<Gsoc> getOrgByYear(String year) async {
    String yearOrgUrl = '';
    switch (year) {
      case '2024':
        yearOrgUrl = '2024';
        break;
      case '2023':
        yearOrgUrl = '2023';
        break;
      case '2022':
        yearOrgUrl = '2022';
        break;
      case '2021':
        yearOrgUrl = '2021';
        break;
      case '2020':
        yearOrgUrl = '2020';
        break;
      default:
        yearOrgUrl = 'allOrg';
        break;
    }
    final String allOrg = '$baseUrl$yearOrgUrl';
    print("status is" + allOrg);
    try {
      Response response = await Dio().get(allOrg + ".json");
      if (response.statusCode == 200) {
        // Parse the JSON response into a Gsoc object
        return Gsoc.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch organizations');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}