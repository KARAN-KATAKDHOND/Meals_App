import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meals_model.dart';
import '../widgets/main_drawer.dart';
import '../screens/filters_screen.dart';
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
    final result = await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx)=> FiltersScreen()));
    print(result);

    }
  }
  @override
  Widget build(context){
    
    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus,);
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