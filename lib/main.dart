import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals_app/screens/favorites_screen.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/bottom_tabs_screen.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegan'] as bool && !meal.isVegan) {
          return false;
        }

        if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) {
      return meal.id == mealId;
    });

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) {
          return meal.id == mealId;
        }));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) {
      return meal.id == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => BottomTabsScreen(_favoriteMeals),
        CategoryMealsScreen.categoryNameRouteName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.mealDetailsRouteName: (ctx) =>
            MealDetailsScreen(_isMealFavorite, _toggleFavorite),
        FiltersScreen.filtersRouteName: (ctx) =>
            FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        // called if the flutter does not exist the route of page in the Route
        // if(settings.name == '/details-meal'){

        // }else if(settings.name=='/anything'){

        // }

        // go to the CategoryMealsScreen as a default page
        return MaterialPageRoute(
          builder: (context) {
            return CategoryMealsScreen(_availableMeals);
          },
        );
      },
      onUnknownRoute: (settings) {
        // called if the flutter does not find the route of page or return error of page 404
        // go to the CategoryMealsScreen as a default page
        MaterialPageRoute(
          builder: (context) {
            return CategoryMealsScreen(_availableMeals);
          },
        );
      },
    );
  }
}
