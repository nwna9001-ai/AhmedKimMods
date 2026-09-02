import '../models/mod_model.dart';

class ApiService {
  static Future<List<ModModel>> getMods() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      ModModel(
        id: '1',
        title: 'Example Mod',
        description: 'A Minecraft addon from KIM ADDONS',
        imageUrl: '',
        downloadUrl: '',
        category: 'Minecraft Addons',
      ),
    ];
  }
}
