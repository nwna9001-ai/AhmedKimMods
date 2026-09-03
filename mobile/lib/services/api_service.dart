import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/mod_model.dart';

class ApiService {
  static Future<List<ModModel>> getMods() async {
    final data = await Supabase.instance.client
        .from('mods')
        .select();

    return data.map<ModModel>((item) {
      return ModModel(
        id: item['id'].toString(),
        title: item['name'] ?? '',
        description: item['description'] ?? '',
        imageUrl: item['image_url'] ?? '',
        downloadUrl: item['download_url'] ?? '',
        category: item['category'] ?? 'Minecraft Addons',
      );
    }).toList();
  }
}
