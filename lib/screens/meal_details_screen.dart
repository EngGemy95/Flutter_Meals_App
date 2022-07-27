import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  MealDetailsScreen(this._isFavorite, this._toggleFavorite, {Key? key})
      : super(key: key);

  static const mealDetailsRouteName = '/meal-details';

  final Function _isFavorite;
  final Function _toggleFavorite;

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget childWidget) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        width: 300,
        height: 200,
        child: childWidget);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;

    final mealDetails = DUMMY_MEALS.firstWhere((mealItem) {
      return mealItem.id == mealId;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetails.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                mealDetails.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(mealDetails.ingredients[index]),
                    ),
                  );
                },
                itemCount: mealDetails.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          '# ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(mealDetails.steps[index]),
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: mealDetails.steps.length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleFavorite(mealId);
        },
        child: _isFavorite(mealId)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(mealId);
      //   },
      // ),
    );
  }
}
