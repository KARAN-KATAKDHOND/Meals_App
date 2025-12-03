import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key,required this.onSelectScreen});
  final void Function(String identifier) onSelectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Colors.amber,
      child: Column(
        children: [
          //Fix this button in the end
          IconButton(
            onPressed: (){Navigator.pop(context);}, 
            icon: Icon(Icons.close),
            alignment: AlignmentGeometry.topRight,
            ),
          DrawerHeader(
            padding: const EdgeInsetsGeometry.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 35),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          //body of Drawer
        ListTile(
          leading: Icon(Icons.restaurant_menu,size: 26,color:Theme.of(context).colorScheme.onBackground,),
          title: Text('Meals',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,

          ),
          ),
          onTap: (){
            //Navigator.of(context).push(route)
            onSelectScreen('meals');
          },
        ),

        ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24,
              ),
            ),
            onTap: () {
              //showCupertinoDialog(context: context, builder: (ctx)=>Text('Hello guys!'));
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
