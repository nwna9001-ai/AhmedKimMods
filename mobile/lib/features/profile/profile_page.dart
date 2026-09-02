import 'package:flutter/material.dart';

class ProfilePageReal extends StatelessWidget {
  const ProfilePageReal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        title: const Text(
          'الحساب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFF252525),
            child: Icon(
              Icons.person,
              size: 55,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              'زائر',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Center(
            child: Text(
              'سجّل الدخول للاستفادة من جميع الميزات',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 30),

          _AccountButton(
            icon: Icons.login,
            title: 'تسجيل الدخول',
            onTap: () {
              _showMessage(context, 'صفحة تسجيل الدخول قادمة');
            },
          ),

          _AccountButton(
            icon: Icons.person_add,
            title: 'إنشاء حساب جديد',
            onTap: () {
              _showMessage(context, 'صفحة إنشاء الحساب قادمة');
            },
          ),

          const SizedBox(height: 15),

          const Divider(color: Colors.white12),

          const SizedBox(height: 15),

          _AccountButton(
            icon: Icons.download,
            title: 'التحميلات',
            onTap: () {},
          ),

          _AccountButton(
            icon: Icons.favorite,
            title: 'المفضلة',
            onTap: () {},
          ),

          _AccountButton(
            icon: Icons.settings,
            title: 'الإعدادات',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _AccountButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AccountButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
