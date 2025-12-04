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
          //close icon

        SafeArea(
            // Ensures content starts below the status bar
            child: Align(
              alignment: Alignment
                  .topRight, // Pushes the IconButton to the top-right of its parent (the Drawer)
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  bottom: 0,
                ), // Add some padding for visual appeal
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 28,
                  ), // Use const if possible
                  // The color will automatically match the theme's background color.
                ),
              ),
            ),
          ),

          //drawer header
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
                  'Feast',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 30,
                    
                  ),
                ),
              ],
            ),
          ),

           const SizedBox(height: 40),
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
       



          // Add your signature/initials here
          const Spacer(), // Pushes the following widget to the very bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Developed by Karan Katakdhond', // <- Add your mark here
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              ),
            ),
          ) // End of Column children
     
        ],
      ),
    );
  }
}
