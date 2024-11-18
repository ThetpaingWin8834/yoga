import 'package:intl/intl.dart';

String formatDateToString(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

DateTime formatStringToDate(String date) {
  return DateFormat('dd/MM/yyyy').parse(date);
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$",
  );
  return emailRegex.hasMatch(email);
}

class EmptyDataException implements Exception {}
