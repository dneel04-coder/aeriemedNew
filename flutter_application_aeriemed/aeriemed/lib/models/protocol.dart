import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/protocol.dart';

class StorageService {
  static const String _fileName = 'protocols.json';
  static List<Protocol> _protocols = [];

  static Future<void> init() async {
    await _loadProtocols();
  }

  static Future<void> _loadProtocols() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_fileName');
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonString);
        _protocols = jsonList.map((e) => Protocol.fromJson(e)).toList();
      }
    } catch (e) {
      _protocols = [];
    }
  }

  static Future<void> _saveProtocols() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_fileName');
    final jsonList = _protocols.map((p) => p.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  static Future<String> copyFileToLocal(File file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newPath = '${appDir.path}/${file.uri.pathSegments.last}';
    final newFile = await file.copy(newPath);
    return newFile.path;
  }

  static Future<void> addProtocol(File file) async {
    final localPath = await copyFileToLocal(file);
    final protocol = Protocol(
      id: const Uuid().v4(),
      title: file.uri.pathSegments.last.replaceAll('.pdf', ''),
      filePath: localPath,
      addedDate: DateTime.now(),
    );
    _protocols.add(protocol);
    await _saveProtocols();
  }

  static List<Protocol> getAll() {
    return List.from(_protocols)..sort((a, b) => b.addedDate.compareTo(a.addedDate));
  }

  static Future<void> deleteProtocol(Protocol protocol) async {
    final file = File(protocol.filePath);
    if (await file.exists()) await file.delete();
    _protocols.removeWhere((p) => p.id == protocol.id);
    await _saveProtocols();
  }
}