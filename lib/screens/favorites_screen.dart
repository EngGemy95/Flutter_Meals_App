import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen(this._favoritesMeals, {Key? key}) : super(key: key);

  final List<Meal> _favoritesMeals;

  @override
  Widget build(BuildContext context) {
    return _favoritesMeals.isEmpty
        ? Center(
            child: Container(
              child: Text('You have no favorite yet - Start adding some!'),
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: _favoritesMeals[index].id,
                title: _favoritesMeals[index].title,
                imageUrl: _favoritesMeals[index].imageUrl,
                duration: _favoritesMeals[index].duration,
                complexity: _favoritesMeals[index].complexity,
                affordability: _favoritesMeals[index].affordability,
                // removeItem: _removeMeal,
              );
            },
            itemCount: _favoritesMeals.length,
          );
  }
}
