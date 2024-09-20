import 'dart:convert';
import 'dart:developer';

import 'package:student_api/models/students.dart';
import 'package:student_api/services/global.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String apiurl;

  ApiServices({required this.apiurl});

  Future<List<Students>> fetchStudents() async {
    var url = Uri.parse('$baseUrl/index');
    final response = await http.get(
      url,
    );
    try {
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Students> studentList =
            data.map((item) => Students.fromJson(item)).toList();
        return studentList;
      } else {
        log('Error: Failed to load students. Status code: ${response.statusCode}');
        throw Exception('Failed to load students');
      }
    } catch (e) {
      log('Error occurred: $e');
      throw Exception('Failed to load students: $e');
    }
  }

  Future<Map<String, dynamic>> addStudents(Students student) async {
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
    return {'statusCode': response.statusCode};
  }

  Future<Map<String, dynamic>> updateStudents(int id, Students student) async {
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
    return {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };
  }

  Future<Map<String, dynamic>> deleteStudents(int id) async {
    var url = Uri.parse('$baseUrl/destroy/$id');
    final response = await http.delete(
      url,
    );
    // if (response.statusCode == 200) {
    //   log('Student added successfully');
    //   return response.statusCode;
    // } else {
    //   log('Error: ${response.statusCode}');
    // }
    return {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };
  }
}
