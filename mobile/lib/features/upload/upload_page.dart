import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final supabase = Supabase.instance.client;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedFileName;
  PlatformFile? selectedFile;
  bool uploading = false;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: [
        'mcpack',
        'mcaddon',
        'mcworld',
        'zip',
      ],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.single;
        selectedFileName = result.files.single.name;
      });
    }
  }

  Future<void> uploadMod() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('اختر ملف الإضافة أولاً'),
        ),
      );
      return;
    }

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('اكتب اسم الإضافة'),
        ),
      );
      return;
    }

    if (selectedFile!.bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر قراءة الملف'),
        ),
      );
      return;
    }

    setState(() {
      uploading = true;
    });

    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${selectedFile!.name}';

      await supabase.storage
          .from('addons')
          .uploadBinary(
            fileName,
            selectedFile!.bytes!,
          );

      final downloadUrl =
          supabase.storage.from('addons').getPublicUrl(fileName);

      await supabase.from('mods').insert({
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'download_url': downloadUrl,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم رفع الإضافة بنجاح ✅'),
        ),
      );

      nameController.clear();
      descriptionController.clear();

      setState(() {
        selectedFile = null;
        selectedFileName = null;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء الرفع: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          uploading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'رفع إضافة',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: uploading ? null : pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF181818),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 180),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.upload_file,
                    color: Colors.white,
                    size: 55,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    selectedFileName ?? 'اختر ملف الإضافة',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '.mcpack أو .mcaddon أو .mcworld أو .zip',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'اسم الإضافة',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF181818),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'وصف الإضافة',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF181818),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: uploading ? null : uploadMod,
                child: uploading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'رفع الإضافة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
