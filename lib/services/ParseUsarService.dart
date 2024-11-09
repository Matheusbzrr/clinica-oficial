import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ParseUsarService {
  static final ParseUsarService _instance = ParseUsarService._internal();
  factory ParseUsarService() => _instance;

  ParseUsarService._internal();

  final String keyApplicationId = 'g4HqlebHJIb5hK6tyWBcufQfZDutuehirNW80z1D';
  final String keyClientKey = 'jlPx7j6xpyR5eOoVMx6ljSph3XNvJX7bToEMWhca';
  final String keyParseServerUrl = 'https://parseapi.back4app.com';

  Future<void> initializeParse() async {
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
    );
  }
}
