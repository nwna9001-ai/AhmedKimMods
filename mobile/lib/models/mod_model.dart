class ModModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String? downloadUrl;
  final String? category;

  const ModModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.downloadUrl,
    this.category,
  });
}
