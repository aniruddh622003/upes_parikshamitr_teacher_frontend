import 'package:http/http.dart' as http;
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show serverUrl;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<dynamic> getSupplies() async {
  const storage = FlutterSecureStorage();
  final String? jwt = await storage.read(key: 'jwt');
  final String? roomId = await storage.read(key: 'roomId');
  dynamic response = await http.get(
      Uri.parse('$serverUrl/teacher/invigilation/get-supplies?room_id=$roomId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      });
  return response;
}
