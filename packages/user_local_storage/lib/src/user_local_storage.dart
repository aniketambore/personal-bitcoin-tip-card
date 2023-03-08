import 'models/models.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class UserLocalStorage {
  UserLocalStorage({
    required this.identityJson,
  });

  final String identityJson;

  Future<IdentityLM> getUserIdentity() async {
    final data = await _readJsonFile(identityJson);
    final identity = IdentityLM.fromJson(data);
    return identity;
  }

  Future<dynamic> _readJsonFile(String jsonFilePath) async {
    final String response = await rootBundle.loadString(jsonFilePath);
    return json.decode(response);
  }
}
