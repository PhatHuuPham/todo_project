import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final Map<String, String> _languages = {
    "en": "English",
    "vi": "Tiếng Việt",
  };

  final Map<ThemeMode, String> _themes = {
    ThemeMode.light: "Sáng",
    ThemeMode.dark: "Tối",
    ThemeMode.system: "Hệ thống",
  };

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // Cài đặt ngôn ngữ
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(
                _languages[settingProvider.locale.languageCode] ?? "English"),
            trailing: DropdownButton<String>(
              value: settingProvider.locale.languageCode,
              items: _languages.entries
                  .map((e) => DropdownMenuItem<String>(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (String? value) {
                if (value != null) {
                  settingProvider.setLocale(Locale(value));
                }
              },
            ),
          ),
          const Divider(),

          // Cài đặt Theme
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(l10n.home),
            subtitle: Text(_themes[settingProvider.themeMode] ?? 'Light'),
            trailing: DropdownButton<ThemeMode>(
              value: settingProvider.themeMode,
              items: _themes.entries
                  .map((e) => DropdownMenuItem<ThemeMode>(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  settingProvider.setThemeMode(value);
                }
              },
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text("xoá cache"),
            onTap: () async {
              final taskViewModel =
                  Provider.of<TaskViewmodel>(context, listen: false);
              // Get database instance and clear tasks
              try {
                // Delete tasks from database then refresh list
                await taskViewModel.deleteAllTasks();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
