import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/models/meals_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {

  const MealDetailsScreen({
    super.key,
    required this.meal,
    
    
  });
  final Meal meal;
  

  @override
  Widget build(BuildContext context,WidgetRef ref){
  final favoriteMeals =   ref.watch(favoriteMealsProvider);
  final isFavorite = favoriteMeals.contains(meal);


    return (Scaffold(
      appBar: AppBar(
        actions: [
          //icon must changes based on selection as faviorates
          IconButton(
            onPressed: () { 
              final wasAdded = ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealFavoriteStatus(meal);
               ScaffoldMessenger.of(context).clearSnackBars();
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded?'Added to Favorites':'Removed from Favorites'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon:  Icon(isFavorite?Icons.star:Icons.star_border,
            color: isFavorite?Colors.amber:Colors.grey,
            ),
          ),
        ],
        title: Text(
          meal.title,
          overflow: TextOverflow.ellipsis,
          textAlign: .center,
          softWrap: true,
          maxLines: 1,
          style: GoogleFonts.lato(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.network(meal.imageUrl,
            // width: double.infinity,
            // height: 300,
            // fit: BoxFit.cover,
            // ),

            //handles error in loading image and shows status of image loading
            Image.network(
              meal.imageUrl,
              // ... existing properties
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                // Show a progress indicator while loading
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Ingredients: ',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: .bold,
              ),
            ),
            const SizedBox(height: 20),
            // Text('Ingredients: \n', textAlign: TextAlign.left,style: GoogleFonts.headlandOne(fontSize: 15,fontWeight: .bold),),
            for (final ing in meal.ingredients)
              Text(
                ing,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

            const SizedBox(height: 20),

            Text(
              'Algorithm: ',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: .bold,
              ),
            ),

            const SizedBox(height: 10),
            for (final steps in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Text(
                  steps,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
