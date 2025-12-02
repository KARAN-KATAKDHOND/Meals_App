import 'package:flutter/material.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  
  var _glutenFreeFilterSet = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(onSelectScreen: (identifier) {
        Navigator.of(context).pop();
        if(identifier=='meals'){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const TabsScreen(),));
        }
      } ),
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
          value: _glutenFreeFilterSet, 
          onChanged: (isChecked){
            setState(() {
              _glutenFreeFilterSet = isChecked;
            });
          },
          title: Text('Gluten-free',style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),),
          subtitle: Text('Only include gluten-free meals.',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),),
          activeThumbColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34,right: 22),
          ),
          ],
      ),
    );
  }
}
