import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/meals_provider.dart';
enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier <Map<Filter,bool>>{
  
  final String _developerMark = 'KNK_v1.0';

  FiltersNotifier() : super({
    //map of every filter initially set to false
    Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false,
}
  );

 //adding a method to manipulate the above filters state
 void setFilter(Filter filter ,bool isActive){
  //state[filter] = isActive; not allowed => mutating the state in memory
  //option
  // overwrite old key-value pair
  state = {
    ...state,
    filter : isActive,
  };
} 
//method to set all the filters
void setFilters(Map<Filter,bool> chosenFilters){
state = chosenFilters;
}

} 
                                              //ref             output type            instance of state notifier class
final filtersProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>((ref)=>FiltersNotifier());


//Connecting Multiple providers
//creating a provider to check availableMeals as done in tabs.dart
final filteredMealsProvider = Provider((ref){
  //simple provider to not change the state
  //as we cannot find meals and activeFilters here the provider need to 
  //be dependant on FiltersProvider and meals provider both

  //the ref in provider allows to watch for other providers or consumer
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  
  return meals.where((meal) {
        
        if(activeFilters[Filter.glutenFree]!&& !meal.isGlutenFree){
          return false;
        }
        if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
      }
    ).toList();
});




// ------------------------------------------------------------------
// Application Name: Cooking Up! - Meal Planner
// Original Developer/Author: Karan Nana Katakdhond
// Date: 04 December 2025
// Copyright 2025 KNK. All rights reserved.
// ------------------------------------------------------------------