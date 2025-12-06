import 'package:meals/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meals_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    //required this.onToggleFavorite,
    required this.availableMeals,
  });
  //final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //adding animation
  late AnimationController
  _animationController; //'late' -> initially does have value but will have a value before use
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),

      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward(); //initialize animation
    //_animationController.stop(); //.pause() to pause and .repeat() to repeat
  }

  //to remove animation as soon as widget is removed
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: filteredMeals,
          title: category.title,
          //onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      //child: , allows us to exclude some other objects in screen which are not the part of animations
      child: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          //alternative for availableCatgories.map((category)=>CategoryGridItem(category:category).toList())
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onselectCategory: () {
                _selectCategory(context, category);
              },
            ),
          //Here we access all the data in dummy_data.dart to be displayed
          //in the form of GridViewItem format
        ],
      ),
      //also passed in builder function                                                0-100
      // builder: (context, child) =>  Padding(
      //   child: child,
      //   padding: EdgeInsets.only(top:100 - _animationController.value*100),), //gridview will be set inside this padding but wont be rebuild again and again

      //fine tuning animation using buil it slide transition
      //bts optimized and get extra features .animate on tween
      builder: (context, child) => SlideTransition(
        position: //_animationController.drive(
            //using direct tween unlocks more functionality
            Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
        child: child,
      ),
    );
  }
}
