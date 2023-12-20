import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/config/route/app_router.dart';
import 'package:movies_app/core/utils/constants/app_strings.dart';

import 'package:movies_app/config/route/app_routes.dart';
import 'package:movies_app/core/utils/constants/app_values.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final String location = GoRouterState.of(context).uri.toString();
          if (!location.startsWith(moviesPath)) {
            _onItemTapped(0, context);
          }
          return true;
        },
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.movies,
            icon: Icon(
              Icons.movie_creation_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.shows,
            icon: Icon(
              Icons.tv_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.search,
            icon: Icon(
              Icons.search_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.watchlist,
            icon: Icon(
              Icons.bookmark_rounded,
              size: AppSize.s20,
            ),
          ),
        ],
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(moviesPath)) {
      return 0;
    }
    if (location.startsWith(tvShowsPath)) {
      return 1;
    }
    if (location.startsWith(searchPath)) {
      return 2;
    }
    if (location.startsWith(watchlistPath)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.moviesRoute);
        break;
      case 1:
        context.goNamed(AppRoutes.tvShowsRoute);
        break;
      case 2:
        context.goNamed(AppRoutes.searchRoute);
        break;
      case 3:
        context.goNamed(AppRoutes.watchlistRoute);
        break;
    }
  }
}
