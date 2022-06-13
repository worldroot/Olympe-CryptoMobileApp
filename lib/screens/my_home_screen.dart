import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:olympe/components/snackbar.dart';
import 'package:olympe/screens/metrics_screen.dart';
import 'package:olympe/screens/screens.dart';
import 'package:olympe/statics.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final PageController _pageController = PageController();

  DateTime? backButtonPressTime;

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > const Duration(seconds: 3);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ShowSnackBar().showSnackBar(
        context,
        "Press Back Again to Exit App",
        duration: const Duration(seconds: 2),
        noAction: true,
      );
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    _pageController.jumpToPage(
      index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String username =
        Hive.box("user_data").get("name", defaultValue: "Guest");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,
        title: Text(
          "Welcome to Olympe ${capitalize(username)} 👋",
          style: const TextStyle(fontSize: 25, fontFamily: "Oswald"),
        ),
        toolbarHeight: 70,
        actions: [
          IconButton(
              onPressed: () {
                Hive.box("user_data").clear();
                Navigator.popAndPushNamed(context, "/login");
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: WillPopScope(
          onWillPop: () => handleWillPop(context),
          child: PageView(
            onPageChanged: (indx) {
              _selectedIndex.value = indx;
            },
            controller: _pageController,
            children: const [
              FirstScreen(),
              SecondScreen(),
              MetricsScreen(),
              ProfileScreen(),
            ],
          )),
      backgroundColor: Palette.backgroundColor,
      bottomNavigationBar: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (BuildContext context, int indexValue, Widget? child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 60,
              child: SalomonBottomBar(
                currentIndex: indexValue,
                onTap: (index) {
                  _onItemTapped(index);
                },
                items: [
                  /// Home
                  SalomonBottomBarItem(
                      icon: const Icon(CupertinoIcons.money_dollar),
                      title: const Text("Crypto"),
                      selectedColor: Palette.primaryColor,
                      unselectedColor: const Color(0xff4c505c)),

                  SalomonBottomBarItem(
                      icon: const Icon(CupertinoIcons.chart_bar_alt_fill),
                      title: const Text("DashBoard"),
                      selectedColor: Palette.primaryColor,
                      unselectedColor: const Color(0xff4c505c)),

                  SalomonBottomBarItem(
                      icon: const Icon(CupertinoIcons.chart_bar_alt_fill),
                      title: const Text("Metrics"),
                      selectedColor: Palette.primaryColor,
                      unselectedColor: const Color(0xff4c505c)),

                  SalomonBottomBarItem(
                      icon: const Icon(CupertinoIcons.settings),
                      title: const Text("Profile"),
                      selectedColor: Palette.primaryColor,
                      unselectedColor: const Color(0xff4c505c)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
