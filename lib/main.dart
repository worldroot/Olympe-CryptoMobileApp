import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olympe/screens/screens.dart';

import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  setOptimalDisplayMode();
  await Hive.initFlutter();
  await openHiveBox('user_data');
  runApp(const MyApp());
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  if (limit) {
    final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
      final Directory dir = await getApplicationDocumentsDirectory();
      final String dirPath = dir.path;
      final File dbFile = File('$dirPath/$boxName.hive');
      final File lockFile = File('$dirPath/$boxName.lock');
      await dbFile.delete();
      await lockFile.delete();
      await Hive.openBox(boxName);
      print("box open :" + boxName);
      throw 'Failed to open $boxName Box\nError: $error';
    });
    // clear box if it grows large
    if (box.length > 500) {
      box.clear();
      print("box clear :" + boxName);
    }
    await Hive.openBox(boxName);
    print("box open after else :" + boxName);
  } else {
    await Hive.openBox(boxName).onError((error, stackTrace) async {
      final Directory dir = await getApplicationDocumentsDirectory();
      final String dirPath = dir.path;
      final File dbFile = File('$dirPath/$boxName.hive');
      final File lockFile = File('$dirPath/$boxName.lock');
      await dbFile.delete();
      await lockFile.delete();
      await Hive.openBox(boxName);
      print("dbfile and lockfile deleted and box open : :" + boxName);
      throw 'Failed to open $boxName Box\nError: $error';
    });
  }
}

Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where((DisplayMode m) =>
          m.width == active.width && m.height == active.height)
      .toList()
    ..sort((DisplayMode a, DisplayMode b) =>
        b.refreshRate.compareTo(a.refreshRate));

  final DisplayMode mostOptimalMode =
      sameResolution.isNotEmpty ? sameResolution.first : active;

  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textSize = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Olympe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              headline4: textSize.headline4!.copyWith(
                color: Colors.white,
              ),
              headline5: textSize.headline5!.copyWith(color: Colors.white),
              headline6: textSize.headline6!.copyWith(
                color: Colors.white,
              ),
              subtitle1: textSize.subtitle1!.copyWith(
                color: Colors.white,
              ),
              subtitle2: textSize.subtitle2!.copyWith(
                color: Colors.grey,
              ),
              overline: textSize.overline!.copyWith(color: Colors.grey),
            ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => initialFuntion(),
        '/home': (context) => const MyHomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }

  Widget initialFuntion() {
    return Hive.box('user_data').get('username') != null
        ? const MyHomeScreen()
        : const LoginScreen();
  }
}
