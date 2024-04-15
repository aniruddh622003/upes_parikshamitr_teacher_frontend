import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show serverUrl;

Future<dynamic> finishDuty(String remarks) async {
  const storage = FlutterSecureStorage();
  final String? jwt = await storage.read(key: 'jwt');
  final String? slotId = await storage.read(key: 'slotId');
  final response = await http.post(
    Uri.parse('$serverUrl/teacher/flying/finish-duty'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $jwt',
    },
    body: jsonEncode({
      'final_remarks': remarks,
      'slot_id': slotId,
    }),
  );
  return response;
}
