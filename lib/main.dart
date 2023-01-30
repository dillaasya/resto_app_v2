import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_v2/data/api/api_service.dart';
import 'package:resto_app_v2/data/provider/list_provider.dart';
import 'package:resto_app_v2/data/provider/review_provider.dart';
import 'package:resto_app_v2/ui/detail_page.dart';
import 'package:resto_app_v2/ui/list_all_page.dart';
import 'package:resto_app_v2/ui/navbar_page.dart';
import 'package:resto_app_v2/ui/search_page.dart';
import 'package:resto_app_v2/ui/setting_page.dart';

import 'data/provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(
            create: (_) => ListProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_)=> ReviewProvider(apiService: ApiService())),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          title: 'resto app v2',
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home: const NavbarPage(),
          initialRoute: NavbarPage.routeName,
          routes: {
            NavbarPage.routeName: (context) => const NavbarPage(),
            ListAllPage.routeName: (context) => const ListAllPage(),
            SettingPage.routeName: (context) => const SettingPage(),
            SearchPage.routeName: (context) => const SearchPage(),
            DetailPage.routeName: (context) => DetailPage(
                  id: ModalRoute.of(context)?.settings.arguments as String,
                ),
          },
        ),
      ),
    );
  }
}
