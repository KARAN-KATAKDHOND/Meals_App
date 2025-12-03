import 'package:flutter/material.dart';
import 'package:meals/models/meals_model.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
    //required this.onToggleFavorite,
  
  });
  final String? title;
  
  final List<Meal> meals;
  //final void Function(Meal meal) onToggleFavorite;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(meal: meals[index],
      //onToggleFavorite: onToggleFavorite,
      ),
    );
    //condition for empty meal
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... Nothing here! ',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Try Selecting a different Category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    } else {
      //always return scaffold for a new screen so that we can display an appBar on top
      return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: content,
      );
    }
  }
}
