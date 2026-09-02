import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mods = [
      {
        'name': 'Furniture Addon',
        'description': 'أثاث جديد ورائع لعالم ماينكرافت',
        'icon': Icons.chair,
      },
      {
        'name': 'Lucky Block',
        'description': 'بلوك الحظ مع مفاجآت مختلفة',
        'icon': Icons.card_giftcard,
      },
      {
        'name': 'Cars Addon',
        'description': 'سيارات ومركبات جديدة',
        'icon': Icons.directions_car,
      },
      {
        'name': 'Modern House',
        'description': 'خريطة منزل عصري جاهزة',
        'icon': Icons.home,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'اكتشف',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'ابحث عن مود أو إضافة...',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: const Color(0xFF181818),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'الإضافات والمودات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...mods.map(
            (mod) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181818),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      mod['icon'] as IconData,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mod['name'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          mod['description'] as String,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 17,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تمت الإضافة إلى المفضلة ❤️'),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
