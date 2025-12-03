import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meals_model.dart';
import '../widgets/main_drawer.dart';
import '../screens/filters_screen.dart';
const initialFilters = 
  {
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
  };
class TabsScreen extends StatefulWidget{

  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState(){
    return _TabsScreenState();
  }
  
}
//stateclass of TabsScreen
class _TabsScreenState extends State<TabsScreen>{

  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter,bool> _selectedFilters = {
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
  };

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),duration: Duration(seconds: 2),)
    );
  }
  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting = _favoriteMeals.contains(meal);
    if(isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a Favorite!');
      });
      
    }else{
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Markes as Favorite');
      });
      
    }
  }
  void _selectedPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
    
  }
  void _setScreen(String identifier) async{
    //closes the drawer if on same screen
  Navigator.pop(context); //closes drawer before navigating to filters
    if(identifier=='filters'){
    //accepts input from that filters screen function ,waits for it. 
    //and State the type of input that will be received such as <Map<Key,Value>>  
    //after push it is <Return type of function>
    final result = await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx)=> FiltersScreen(currentFilters: _selectedFilters,)));
    setState(() {
      _selectedFilters = result ?? initialFilters ;
      // ?? gives a fallback value to use in case if we did not receive the intended value

    });

    }
  }
  @override
  Widget build(context){
    final availableMeals = dummyMeals.where((meal) {
        if(_selectedFilters[Filter.glutenFree]!&& !meal.isGlutenFree){
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
      }
    ).toList();

    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus,availableMeals: availableMeals,);
    var activePageTitle = 'Categories';
    //second tab selected scenario
    if(_selectedPageIndex==1){
      activePage=MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
        
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