import 'package:flutter/material.dart';

import '../../models/mod_model.dart';
import '../../services/api_service.dart';
import '../../widgets/mod_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<ModModel> _mods = [];
  List<ModModel> _filteredMods = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMods();
    _searchController.addListener(_searchMods);
  }

  Future<void> _loadMods() async {
    final mods = await ApiService.getMods();

    if (!mounted) return;

    setState(() {
      _mods = mods;
      _filteredMods = mods;
      _loading = false;
    });
  }

  void _searchMods() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredMods = _mods;
      } else {
        _filteredMods = _mods.where((mod) {
          return mod.title.toLowerCase().contains(query) ||
              mod.description.toLowerCase().contains(query) ||
              (mod.category ?? '').toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _categoryButton(
    String title,
    IconData icon,
  ) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _searchController.text = title;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF151515),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white12,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadMods,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'KIM ADDONS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'اكتشف أفضل إضافات Minecraft',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'ابحث عن مود أو إضافة...',
                  hintStyle: const TextStyle(
                    color: Colors.white38,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white70,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white70,
                          ),
                        )
                      : null,
                  filled: true,
                  fillColor: const Color(0xFF151515),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'تصفح حسب المنصة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _categoryButton(
                    'Bedrock',
                    Icons.phone_android,
                  ),
                  const SizedBox(width: 12),
                  _categoryButton(
                    'Java',
                    Icons.computer,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'أحدث الإضافات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_filteredMods.length} إضافة',
                    style: const TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_filteredMods.isEmpty)
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151515),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 50,
                        color: Colors.white38,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'لم يتم العثور على إضافات',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ..._filteredMods.map(
                  (mod) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ModCard(
                      title: mod.title,
                      description: mod.description,
                      imageUrl: mod.imageUrl,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم اختيار ${mod.title}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
