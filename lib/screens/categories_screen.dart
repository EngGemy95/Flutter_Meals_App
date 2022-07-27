import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(10),
        children: DUMMY_CATEGORIES.map((categoryITem) {
          return CategoryItem(
            categoryITem.id,
            categoryITem.title,
            categoryITem.color,
          );
        }).toList(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 150,
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
        ));
  }
}
