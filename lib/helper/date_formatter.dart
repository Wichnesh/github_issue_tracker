import 'package:intl/intl.dart';

String formatDate(String createdAt) {
  final date = DateTime.parse(createdAt);
  return DateFormat('dd/MM/yyyy HH:mm').format(date);
}
