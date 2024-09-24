import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:final_assignment/features/favourites/presentation/viewmodel/favourites_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritesWidgetView extends ConsumerWidget {
  const FavouritesWidgetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritesState = ref.watch(favouritesViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favourites'),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: favouritesState.items.isEmpty
                    ? const Center(child: Text('Your favourites list is empty'))
                    : ListView.builder(
                        itemCount: favouritesState.items.length,
                        itemBuilder: (context, index) {
                          return FavouritesItem(
                              favouriteEntity: favouritesState.items[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavouritesItem extends ConsumerWidget {
  final FavouritesEntity favouriteEntity;

  const FavouritesItem({
    super.key,
    required this.favouriteEntity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              '${ApiEndpoints.designImage}${favouriteEntity.designEntity.designImage}',
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favouriteEntity.designEntity.designName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs ${favouriteEntity.designEntity.designPrice}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref
                    .read(favouritesViewModelProvider.notifier)
                    .removeFromFavourites(favouriteEntity.id!);
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
