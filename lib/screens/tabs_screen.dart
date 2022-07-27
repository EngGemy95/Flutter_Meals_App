import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      //initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meals'),
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.category),
              child: Text('Categories'),
            ),
            Tab(
              icon: Icon(Icons.favorite),
              child: Text('Favorites'),
            ),
          ]),
        ),
        body: const TabBarView(children: [
          CategoriesScreen(),
          //FavoritesScreen(),
        ]),
      ),
    );
  }
}
