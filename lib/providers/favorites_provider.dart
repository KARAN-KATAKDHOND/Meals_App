import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/models/meals_model.dart';
// for static return type provider like dummyMeals
/*final favoriteMealsProvider = Provider((ref){
   return something
});*/

//for more complex or advance provider with logic use
//StateNotifierProvider. It works with another object StateNotifier
//similar to that of statefull widget

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  //adding some initial values using constructor and we pass data in super(data , list in this case)
  FavoriteMealsNotifier():super([]);
  //adding some methods to modify any value if needed
  bool toggleMealFavoriteStatus(Meal meal){
    //here we cannot use the same logic as function in tabs.dart
    // as we cannot edit the value passed to super i.e cant use .add or similar
    // we must always replace the value
    final mealIsFavorite = state.contains(meal);

    if(mealIsFavorite){
      state = state.where((m){
      //if meal id doesnt match meal id in favorites[meals deosnt exist in fav list add it]
      //else remove it
        return (m.id != meal.id);
      }).toList();
      return false;
    }else{
      state = [...state,meal];
      return true;
    }



  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref){
  return FavoriteMealsNotifier();
  //returns instance of notifier class
  //to let it know the data which it will return mention it with name
});
  //a simple provider that stores all the 
  //favorite meal in a list


