import 'package:flutter/material.dart';

void main() => runApp(const AhmedKimModsApp());

class AppColors {
  static const red = Color(0xFF8B1018);
  static const redBright = Color(0xFFB71924);
  static const black = Color(0xFF090909);
  static const surface = Color(0xFF151515);
  static const muted = Color(0xFF9B9B9B);
}

class AhmedKimModsApp extends StatelessWidget {
  const AhmedKimModsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahmed Kim Mods',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.black,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.redBright,
          surface: AppColors.surface,
        ),
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  final pages = const [
    HomePage(),
    ExplorePage(),
    FavoritesPage(),
    UploadPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: pages[index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'اكتشف'),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'المفضلة'),
          NavigationDestination(icon: Icon(Icons.add_box_outlined), selectedIcon: Icon(Icons.add_box), label: 'رفع'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'الحساب'),
        ],
      ),
    );
  }
}

class PageFrame extends StatelessWidget {
  final String title;
  final Widget child;
  const PageFrame({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.black,
            pinned: true,
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverToBoxAdapter(child: child),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Ahmed Kim Mods',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mods & Add-ons', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        const Text('اكتشف أفضل إضافات Minecraft لـ Bedrock و Java', style: TextStyle(color: AppColors.muted)),
        const SizedBox(height: 18),
        TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن Mod أو Add-on...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(child: _CategoryCard(title: 'Bedrock', icon: Icons.extension)),
            const SizedBox(width: 12),
            Expanded(child: _CategoryCard(title: 'Java', icon: Icons.build_circle_outlined)),
          ],
        ),
        const SizedBox(height: 26),
        const Text('الأحدث', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        const _ModCard(title: 'Epic Adventure Add-on', platform: 'Bedrock', rating: '4.8'),
        const _ModCard(title: 'Better Worlds', platform: 'Java', rating: '4.7'),
      ],
    ),
  );
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const _CategoryCard({required this.title, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18)),
    child: Row(children: [Icon(icon, color: AppColors.redBright), const SizedBox(width: 10), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))]),
  );
}

class _ModCard extends StatelessWidget {
  final String title, platform, rating;
  const _ModCard({required this.title, required this.platform, required this.rating});
  @override
  Widget build(BuildContext context) => Card(
    color: AppColors.surface,
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: Container(width: 58, height: 58, decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.extension)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$platform  •  ⭐ $rating'),
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(title: 'اكتشف', child: const Text('التصنيفات والبحث المتقدم ستكون هنا.'));
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(title: 'المفضلة', child: const Text('إضافاتك المحفوظة ستظهر هنا.'));
}

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(title: 'رفع إضافة', child: const Text('واجهة رفع Mods و Add-ons ستتصل بالـ API هنا.'));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(title: 'الحساب', child: const Text('تسجيل الدخول والملف الشخصي والإعدادات.'));
}
