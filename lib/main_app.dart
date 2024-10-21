import 'package:flutter/material.dart';
import 'package:gomate/misc/theme.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/account_page.dart';
import 'package:gomate/pages/home_page.dart';
import 'package:gomate/widgets/other/adaptive.dart';

enum AppPage {
  home, account;

  @override
  String toString() {
    switch (this) {
      case home:
        return "Home";
      case account:
        return "Account";
      default:
        return "";
    }
  }

  Icon icon(bool isActive, ThemeData theme) {
    IconData iconData = () {
      switch (this) {
        case home:
          return isActive ? Icons.home : Icons.home_outlined;
        case account:
          return isActive ? Icons.person_rounded: Icons.person_outline_rounded;
        default:
          return isActive ? Icons.home : Icons.home_outlined;
      }
    }();
    return Icon(
      iconData,
      color: isActive ? theme.colorScheme.primary : null,
    );
  }

  Widget content() {
    switch (this) {
      case home:
        return const HomePage();
      case account:
        return const AccountPage();
      default:
        return const Placeholder();
    }
  }
}

class MainApp extends StatefulWidget {
  final AppPage page;

  int get pageIndex => page.index;

  MainApp({super.key, this.page = AppPage.home});

  final List<Widget> pageContents =
      AppPage.values.map((page) => page.content()).toList();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AppPage page = AppPage.home;

  void changePage(int value) {
    setState(() {
      switch (value) {
        case 0:
          page = AppPage.home;
          break;
        case 1:
          page = AppPage.account;
          break;
        default:
          page = AppPage.home;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemedApp(
      home: Adaptive(
        horizontal: MainAppHorizontal(
          changePage: changePage,
          page: page,
          pageContents: widget.pageContents,
        ),
        vertical: MainAppVertical(
          changePage: changePage,
          page: page,
          pageContents: widget.pageContents,
        ),
      ),
    );
  }
}

class MainAppHorizontal extends StatefulWidget {
  final void Function(int) changePage;
  final AppPage page;
  final List<Widget> pageContents;
  const MainAppHorizontal(
      {super.key,
      required this.changePage,
      required this.page,
      required this.pageContents});
  @override
  State<MainAppHorizontal> createState() => _MainAppHorizontalState();
}

class _MainAppHorizontalState extends State<MainAppHorizontal> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainerHigh,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.sizeOf(context).height),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    backgroundColor: theme.colorScheme.surfaceContainerHigh,
                    groupAlignment: 0,
                    extended: Adaptive.of(context).dimensions.isWider,
                    destinations: [
                      for (final page in AppPage.values)
                        NavigationRailDestination(
                            icon: page.icon(false, theme),
                            selectedIcon: page.icon(true, theme),
                            label: Text(page.toString()))
                    ],
                    selectedIndex: widget.page.index,
                    onDestinationSelected: (value) {
                      widget.changePage(value);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
                child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(color: theme.colorScheme.surface),
                child: IndexedStack(
                  index: widget.page.index,
                  children: widget.pageContents,
                ),
              ),
            ))
          ],
        ));
  }
}

class MainAppVertical extends StatefulWidget {
  final void Function(int) changePage;
  final AppPage page;
  final List<Widget> pageContents;
  const MainAppVertical(
      {super.key,
      required this.changePage,
      required this.page,
      required this.pageContents});
  @override
  State<MainAppVertical> createState() => _MainAppVerticalState();
}

class _MainAppVerticalState extends State<MainAppVertical> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: IndexedStack(
          index: widget.page.index,
          children: widget.pageContents,
        ),
        bottomNavigationBar: NavigationBar(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            destinations: [
              for (var page in AppPage.values)
                NavigationDestination(
                    icon: page.icon(false, theme),
                    selectedIcon: page.icon(true, theme),
                    label: page.toString())
            ],
            selectedIndex: widget.page.index,
            onDestinationSelected: (value) {
              widget.changePage(value);
            }));
  }
}

class ThemedApp extends StatelessWidget {
  final Widget? home;
  const ThemedApp({super.key, this.home});
  @override
  Widget build(BuildContext context) {
    final theme = MaterialTheme(createTextTheme(context, "Poppins", "Prata"));
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      theme: theme.light(),
      darkTheme: theme.dark(),
      highContrastTheme: theme.lightHighContrast(),
      highContrastDarkTheme: theme.darkHighContrast(),
      home: home,
    );
  }
}
