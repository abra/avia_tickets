import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app/style/app_theme.dart';
import 'data/local_storage.dart';
import 'data/ticket_repository.dart';
import 'screens/home/home_screen.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.ticketRepository,
    required this.localStorageRepository,
  });

  final TicketRepository ticketRepository;
  final LocalStorage localStorageRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _index = 0;

  late final _pages = <Widget>[
    HomeScreen(
      ticketRepository: widget.ticketRepository,
      localStorageRepository: widget.localStorageRepository,
    ),
    const _PagePlaceholder(name: 'Отели'),
    const _PagePlaceholder(name: 'Короче'),
    const _PagePlaceholder(name: 'Подписки'),
    const _PagePlaceholder(name: 'Профиль'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: Scaffold(
        body: Center(
          child: IndexedStack(
            index: _index,
            children: _pages,
          ),
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.appColors.grey1,
                blurRadius: 1,
              ),
            ],
          ),
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: BottomNavigationBar(
              currentIndex: _index,
              items: [
                _getNavItem(
                  context: context,
                  itemIndex: 0,
                  currentIndex: _index,
                  svgAssetPath: 'assets/icons/svg/airplane.svg',
                  label: 'Авиабилеты',
                ),
                _getNavItem(
                  context: context,
                  itemIndex: 1,
                  currentIndex: _index,
                  svgAssetPath: 'assets/icons/svg/hotels.svg',
                  label: 'Отели',
                ),
                _getNavItem(
                  context: context,
                  itemIndex: 2,
                  currentIndex: _index,
                  svgAssetPath: 'assets/icons/svg/location.svg',
                  label: 'Короче',
                ),
                _getNavItem(
                  context: context,
                  itemIndex: 3,
                  currentIndex: _index,
                  svgAssetPath: 'assets/icons/svg/ring.svg',
                  label: 'Подписки',
                ),
                _getNavItem(
                  context: context,
                  itemIndex: 4,
                  currentIndex: _index,
                  svgAssetPath: 'assets/icons/svg/profile.svg',
                  label: 'Профиль',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _getNavItem({
    required BuildContext context,
    required int itemIndex,
    required int currentIndex,
    required String svgAssetPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          svgAssetPath,
          semanticsLabel: '$label icon',
          colorFilter: itemIndex == currentIndex
              ? ColorFilter.mode(
                  AppTheme.appColors.blue,
                  BlendMode.srcIn,
                )
              : ColorFilter.mode(
                  AppTheme.appColors.grey6,
                  BlendMode.srcIn,
                ),
        ),
      ),
      label: label,
    );
  }
}

class _PagePlaceholder extends StatelessWidget {
  const _PagePlaceholder({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
