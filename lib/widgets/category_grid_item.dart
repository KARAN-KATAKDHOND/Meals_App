import 'package:flutter/material.dart';
import 'package:meals/models/category_model.dart';
//import 'package:meals/data/dummy_data.dart';
class CategoryGridItem extends StatelessWidget{
final Category category;
final void Function() onselectCategory;
  const CategoryGridItem({required this.category,super.key,required this.onselectCategory});
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onselectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9)
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            ),
        ),
        child: Text(category.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith( //!--> is used to tell dart that titleLarge will be defined
          color: Theme.of(context).colorScheme.onSurface,//onBackground replacement onSurface
        ),
        ) ,
      ),
    );
  }
}