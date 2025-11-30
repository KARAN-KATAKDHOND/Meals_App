import 'package:flutter/material.dart';
import 'package:meals/models/meals_model.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals/screens/meal_details.dart';
class MealItem extends StatelessWidget {
  final Meal meal;
  const MealItem({super.key,required this.meal,required this.onToggleFavorite});
  final void Function(Meal meal) onToggleFavorite;
  
String get complexityText{
  return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1) ;
}
String get affodabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }
//cluster all functions on main screen and pass here instead of this specific function
void gotoMealsSpecificScreen(BuildContext context){
  
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealDetailsScreen(meal:meal,onToggleFavorite: onToggleFavorite,
         
        )));
}
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      //only shapre doest works here so we need to enforce
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap:()=>gotoMealsSpecificScreen(context),
        child: Stack(
          children: [
            FadeInImage(placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity, 
              height: 200,),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,//: 50 ->end 50 pixel prior to the image ending position use stack diagram for ref
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign:TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,//cut offs long text with ...
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      ),
                    const SizedBox(height: 12,),
                    Row(
                    
                      mainAxisAlignment: .center,
                      children: [
                        //instead of repeating the widget multiple times here to show traits of meal we make a cusome widget meal_item_trait.dart
                        MealItemTrait(icon: Icons.schedule , label: '${meal.duration} min'),
                        SizedBox(width: 20,),
                        MealItemTrait(icon: Icons.work , label: complexityText),
                        SizedBox(width: 20,),
                        MealItemTrait(icon: Icons.attach_money , label: affodabilityText),
                        SizedBox(width: 20,)
                      ],
                    )
                  ],
                ),
              ),),
          ],
        ),
      ),
    );
  }
}