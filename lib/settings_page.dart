import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _darkMode = false;

  Widget _buildSettingItem(IconData icon, String title, {Widget? trailing}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: trailing,
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            // User Info Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(radius: 30, backgroundColor: Colors.grey[300]),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ариунаа', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        Text('Таны профайл'),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(onPressed: () {}, child: Text('Засах')),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Settings Options
            _buildSettingItem(Icons.notifications, 'Мэдэгдэл',
              trailing: Switch(
                value: _notifications,
                onChanged: (bool value) {
                  setState(() {
                    _notifications = value;
                  });
                },
              ),
            ),

            _buildSettingItem(Icons.dark_mode, 'Харанхуй горим',
              trailing: Switch(
                value: _darkMode,
                onChanged: (bool value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
            ),

            _buildSettingItem(Icons.lock, 'Нууцлал'),
            _buildSettingItem(Icons.language, 'Хэл'),
            _buildSettingItem(Icons.info, 'Тухай'),
          ],
        ),
      ),
    );
  }
}
