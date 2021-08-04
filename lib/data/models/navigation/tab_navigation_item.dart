import 'package:flutter/material.dart';
import 'package:real_estate/ui/category/category.dart';
import 'package:real_estate/ui/favorite/favourite.dart';
import 'package:real_estate/ui/home/home.dart';
import 'package:real_estate/ui/profile/profile.dart';
import 'package:real_estate/ui/search/search.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomeScreen(),
          icon: const Icon(Icons.home),
          title: "Home",
        ),
        TabNavigationItem(
          page: CategoryScreen(),
          icon: const Icon(Icons.category),
          title: "Category",
        ),
        TabNavigationItem(
          page: SearchScreen(),
          icon: const Icon(Icons.search),
          title: "Search",
        ),
        TabNavigationItem(
          page: FavoriteScreen(),
          icon: const Icon(Icons.favorite),
          title: "Favorite",
        ),
        TabNavigationItem(
          page: ProfileScreen(),
          icon: const Icon(Icons.account_circle_rounded),
          title: "Profile",
        ),
      ];
}
