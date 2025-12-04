import 'package:flutter/material.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum Filter{
//   glutenFree,lactoseFree,
//   vegetarian,vegan,
// }
// as we are outsourcing state to the provider we dont need a stateful widget here
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    //rexecutes the widget whenever there is any change in the state of provider using listener
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if(identifier=='meals'){
      //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const TabsScreen(),));
      //   }
      // } ),
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
          children: [

        
            SwitchListTile(
            value: activeFilters[Filter.glutenFree]!, 
            onChanged: (isChecked){
              ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, isChecked);
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
        
        //Second SwitchList Tile
        
        SwitchListTile(
              value: activeFilters[Filter.lactoseFree]!, 
            onChanged: (isChecked){
              ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, isChecked);
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
        
        
        //3rd SwitchList
        
        SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
              title: Text(
                'Vegatarian Food',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include Vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
        
        
        SwitchListTile(
              value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
              title: Text(
                'Vegan Food',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include Vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            ],
        ),
      );
  }
}





