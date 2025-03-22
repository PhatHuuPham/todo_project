import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/app_database.dart';
import 'package:todo_app/services/data/share_prefrence.dart';
import 'package:todo_app/viewmodel/auth_viewmodel.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/viewmodel/user_viewmodel.dart';
import 'package:todo_app/views/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/viewmodel/setting_provider.dart';
// import 'package:todo_app/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Đảm bảo Flutter đã khởi tạo trước khi gọi SharedPreferences

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final taskDao = database.taskDao;
  final taskViewModel = TaskViewmodel(taskDao);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TaskCategoryViewmodel()),
      ChangeNotifierProvider(create: (context) => taskViewModel),
      ChangeNotifierProvider(create: (context) => UserViewmodel()),
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ChangeNotifierProvider(create: (context) => Shareprefrence()),
      ChangeNotifierProvider(create: (context) => SettingProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, settingProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,

          // ),
          locale: settingProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          theme: settingProvider.lightTheme,
          darkTheme: settingProvider.darkTheme,
          themeMode: settingProvider.themeMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
