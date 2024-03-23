import 'package:http/http.dart' as http;
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show serverUrl;

Future<dynamic> getRoomDetails(String roomId) async {
  dynamic response = await http.get(Uri.parse(
      '$serverUrl/teacher/invigilation/seating-plan?room_id=$roomId'));
  return response;
}
