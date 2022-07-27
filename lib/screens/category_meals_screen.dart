import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen(
  //   this.categoryId,
  //   this.categoryTitle, {
  //   key,
  // }) : super(key: key);

  static const categoryNameRouteName = '/category-meals';
  List<Meal> _availableMeals;
  CategoryMealsScreen(this._availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var _loadedInitState = false;

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    //We can not use this code in initState() because we use context in this code
    //because the context initialize after widget is initialized

    //_loadedInitState we can not use here now , but this in course the didChangeDependencies() method call a couple of time
    if (!_loadedInitState) {
      final routeArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      categoryTitle = routeArguments['title'] as String;
      final String categoryId = routeArguments['id'] as String;
      displayedMeals = widget._availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      _loadedInitState = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals![index].id,
            title: displayedMeals![index].title,
            imageUrl: displayedMeals![index].imageUrl,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals?.length,
      ),
    );
  }
}
