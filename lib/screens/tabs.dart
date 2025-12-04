import 'package:flutter/material.dart';
import 'package:meals/providers/favorites_provider.dart';
//import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals.dart';
// import 'package:meals/models/meals_model.dart';
import '../widgets/main_drawer.dart';
import '../screens/filters_screen.dart';
import '../providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

const initialFilters = 
  {
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
  };

  
class TabsScreen extends ConsumerStatefulWidget{

  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState(){
    return _TabsScreenState();
  }
  
}
//stateclass of TabsScreen
class _TabsScreenState extends ConsumerState<TabsScreen>{

  int _selectedPageIndex = 0;
//  final List<Meal> _favoriteMeals = [];
  // Map<Filter,bool> _selectedFilters = {
  //   Filter.glutenFree:false,
  //   Filter.lactoseFree:false,
  //   Filter.vegetarian:false,
  //   Filter.vegan:false,
  // };

  // void _showInfoMessage(String message){
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message),duration: Duration(seconds: 2),)
  //   );
  // }
  // void _toggleMealFavoriteStatus(Meal meal){
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if(isExisting){
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage('Meal is no longer a Favorite!');
  //     });
      
  //   }else{
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Markes as Favorite');
  //     });
      
  //   }
  // }
  void _selectedPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
    
  }
  void _setScreen(String identifier){
    //closes the drawer if on same screen
  Navigator.pop(context); //closes drawer before navigating to filters
    if(identifier=='filters'){
    //accepts input from that filters screen function ,waits for it. 
    //and State the type of input that will be received such as <Map<Key,Value>>  
    //after push it is <Return type of function>
    //final result = await Navigator.of(context).push<Map<Filter,bool>>(
      Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(
          builder: (ctx)=> const FiltersScreen(),),);

    }
    
    }
  
  @override
  Widget build(context){
    //trying to use provider and use dummy Meal from provider instead of manual dummyMeals
    // final meals = ref.watch(mealsProvider);//meals fetched from provider
    // //final availableMeals = dummyMeals.where((meal) {
    // final activeFilters = ref.watch(filtersProvider);
      final availableMeals = ref.watch(filteredMealsProvider);
    //   meals.where((meal) {
        
    //     if(activeFilters[Filter.glutenFree]!&& !meal.isGlutenFree){
    //       return false;
    //     }
    //     if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true;
    //   }
    // ).toList();

    Widget activePage = CategoriesScreen(
      //onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,);
    var activePageTitle = 'Categories';
    final favortieMealUsingProvider = ref.watch(favoriteMealsProvider);
    //second tab selected scenario
    if(_selectedPageIndex==1){
      activePage=MealsScreen(
        meals: favortieMealUsingProvider,
        // meals: _favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
        
        );
      activePageTitle='Yours Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),

      ),
      drawer:  MainDrawer(onSelectScreen: _setScreen,) , //lets create a custom drawer main_drawer.dart

      // to set body based on tap
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index)=>_selectedPage(index),
      // to tell flutter which tab from botton is selected
      // by default it selects only categories event after clicking favorites
      currentIndex: _selectedPageIndex,

        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant,color: Colors.deepPurple,),label:'Categories' ),//category screen
          BottomNavigationBarItem(icon: Icon(Icons.star, color: Colors.amber),label:'Favorites' ),//Faviourate screen
        ],//list of taps 
      ),
    );
  }

}
