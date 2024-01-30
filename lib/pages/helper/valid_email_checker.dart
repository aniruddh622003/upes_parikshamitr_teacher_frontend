bool isValidEmail(String email) {
  final RegExp regex =
      RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  return regex.hasMatch(email);
}
