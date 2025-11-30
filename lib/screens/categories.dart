import 'package:meals/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
// import 'package:meals/models/category_model.dart';
class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key});
  void _selectCategory(BuildContext context,Category category){
    final filteredMeals = dummyMeals
    .where((meal)=>meal.categories.contains(category.id))
    .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx)=>MealsScreen(
          meals: filteredMeals, 
          title: category.title,
          )));
  }

  @override
  Widget build(BuildContext context){
    return GridView(
          padding: EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            ),
          children: [
            //alternative for availableCatgories.map((category)=>CategoryGridItem(category:category).toList())
            for(final category in availableCategories)
            CategoryGridItem(category: category,onselectCategory: (){
              _selectCategory(context,category);
              },),
             //Here we access all the data in dummy_data.dart to be displayed
             //in the form of GridViewItem format
        ], );
  }
}