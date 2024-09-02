import 'dart:convert';
import 'dart:developer';

import 'package:student_api/models/students.dart';
import 'package:student_api/services/global.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<Students>> fetchStudents() async {
    var url = Uri.parse('$baseUrl/index');
    final response = await http.get(
      url,
    );
    List<dynamic> data = jsonDecode(response.body);
    List<Students> productList = [];

    for (var item in data) {
      Students products = Students.fromJson(item);
      productList.add(products);
    }

    return productList;
  }

  static Future<void> addStudents(Students student) async {
    var url = Uri.parse('$baseUrl/store');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'first_name': student.firstName,
          'last_name': student.lastName,
          'course': student.course,
          'year': student.year,
          'enrolled': student.enrolled,
        }));
    if (response.statusCode == 200) {
      log('Student added successfully');
    } else {
      log('Error: ${response.statusCode}');
      try {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['error'] ?? 'Failed to add student';
        final details = responseBody['details'] ?? '';
        log('Error Message: $errorMessage');
        log('Details: $details');
      } catch (e) {
        log('Failed to parse error response: $e');
      }
      throw Exception('Failed to add student');
    }
  }

  static Future<void> upadateStudents(int id, Students student) async {
    var url = Uri.parse('$baseUrl/update/$id');
    final response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'first_name': student.firstName,
          'last_name': student.lastName,
          'course': student.course,
          'year': student.year,
          'enrolled': student.enrolled,
        }));
    if (response.statusCode == 200) {
      log('Student added successfully');
    } else {
      log('Error for update: ${response.statusCode}');
    }
  }

  static Future<void> deleteStudents(int id) async{
    var url = Uri.parse('$baseUrl/destroy/$id');
    final response = await http.delete(
      url,
    );
     if (response.statusCode == 200) {
      log('Student added successfully');
    } else {
      log('Error: ${response.statusCode}');
    }
  }
}
