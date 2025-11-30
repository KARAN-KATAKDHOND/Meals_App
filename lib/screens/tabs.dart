import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget{

  const TabsScreen({super.key});
  State<TabsScreen> createState(){
    return _TabsScreenState();
  }
  
}
//stateclass of TabsScreen
class _TabsScreenState extends State<TabsScreen>{

  int _selectedPageIndex = 0;

  void _selectedPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
    
  }

  @override
  Widget build(context){

    Widget activePage =const CategoriesScreen();
    var activePageTitle = 'Categories';
    if(_selectedPageIndex==1){
      activePage=MealsScreen(meals: [],);
      activePageTitle='Yours Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),

      ),
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