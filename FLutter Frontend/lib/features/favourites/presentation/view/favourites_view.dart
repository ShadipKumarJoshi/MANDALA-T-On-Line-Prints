import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:final_assignment/features/favourites/presentation/viewmodel/favourites_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';

class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({super.key});

  @override
  ConsumerState<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends ConsumerState<FavouritesView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(favouritesViewModelProvider.notifier).fetchFavourites());
  }

  @override
  Widget build(BuildContext context) {
    final favouritesState = ref.watch(favouritesViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // Implement sorting logic
            },
          ),
        ],
      ),
      body: favouritesState.items.isEmpty
          ? _buildEmptyState()
          : _buildFavoritesList(favouritesState.items),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/empty_favourites.json',
            height: 201,
            width: 201,
          ),
          const SizedBox(height: 20),
          const Text(
            'No favorites yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Start adding some items to your favorites!',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardView(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_bag),
            label: const Text('Explore Products'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(List<FavouritesEntity> items) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FavouriteItem(
          favouriteEntity: items[index],
          onRemove: () => _removeFromFavourites(items[index]),
        );
      },
    );
  }

  void _removeFromFavourites(FavouritesEntity favouriteEntity) {
    // print("REMOVE ${favouriteEntity.designEntity.id ?? 'No ID found'}");
    ref
        .read(favouritesViewModelProvider.notifier)
        .removeFromFavourites(favouriteEntity.designEntity.id!);
  }
}

class FavouriteItem extends StatelessWidget {
  final FavouritesEntity favouriteEntity;
  final VoidCallback onRemove;

  const FavouriteItem({
    super.key,
    required this.favouriteEntity,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  '${ApiEndpoints.designImage}${favouriteEntity.designEntity.designImage}',
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: onRemove,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favouriteEntity.designEntity.designName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Rs ${favouriteEntity.designEntity.designPrice}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
