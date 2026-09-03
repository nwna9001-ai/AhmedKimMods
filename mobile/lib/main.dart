import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/home/home_page.dart';
import 'features/profile/profile_page.dart';
import 'features/explore/explore_page.dart';
import 'features/upload/upload_page.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rmwirgguecibxtvgywj.supabase.co',
    anonKey: 'sb_publishable_IQExCaGxIJlRSsbc5_3Jsg_S2EdOn0w',
  );

  runApp(const AhmedKimModsApp());
}

class AhmedKimModsApp extends StatelessWidget {
  const AhmedKimModsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KIM ADDONS',
      theme: AppTheme.darkTheme,
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
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    FavoritesPage(),
    UploadPage(),
    ProfilePageReal(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'اكتشف',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          NavigationDestination(
            icon: Icon(Icons.upload_outlined),
            selectedIcon: Icon(Icons.upload),
            label: 'رفع',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'الحساب',
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'المفضلة',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
