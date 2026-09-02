import '../models/mod_model.dart';

class ApiService {
  static Future<List<ModModel>> getMods() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      ModModel(
        title: 'Example Mod',
        description: 'A Minecraft addon from KIM ADDONS',
        imageUrl: '',
        downloadUrl: '',
      ),
    ];
  }
}
