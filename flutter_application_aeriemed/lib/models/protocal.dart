import 'package:path_provider/path_provider.dart';

class Protocol {
  final String id;
  String title;
  String filePath;
  final DateTime addedDate;

  Protocol({
    required this.id,
    required this.title,
    required this.filePath,
    required this.addedDate,
  });

  // For saving to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'filePath': filePath,
        'addedDate': addedDate.toIso8601String(),
      };

  factory Protocol.fromJson(Map<String, dynamic> json) => Protocol(
        id: json['id'],
        title: json['title'],
        filePath: json['filePath'],
        addedDate: DateTime.parse(json['addedDate']),
      );
}