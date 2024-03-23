import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show serverUrl;

Future<dynamic> reqRoomVisit(Map data) async {
  const storage = FlutterSecureStorage();
  final String? jwt = await storage.read(key: 'jwt');
  final response = await http.post(
    Uri.parse('$serverUrl/teacher/flying/request-visit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $jwt',
    },
    body: jsonEncode(data),
  );
  return response;
}
