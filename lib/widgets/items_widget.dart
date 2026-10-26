import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  static const _items = <ProductData>[
    ProductData(
      title: 'Form No. 02 Watch',
      subtitle: 'Brushed steel · oat',
      price: 'Rp 1.450.000',
      label: 'NEW',
      icon: Icons.watch_rounded,
      color: AppColors.sage,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=85',
      description:
          'A quiet statement piece with a considered silhouette and precise everyday function.',
    ),
    ProductData(
      title: 'Soft Geometry Tote',
      subtitle: 'Pebbled leather · clay',
      price: 'Rp 2.100.000',
      label: 'EDITORS PICK',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFFFFD8C9),
      imageUrl:
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=900&q=85',
      description:
          'A sculptural carry-all designed for an unhurried day in the city.',
    ),
    ProductData(
      title: 'Everyday Oxford',
      subtitle: 'Calf leather · espresso',
      price: 'Rp 950.000',
      label: 'ICON',
      icon: Icons.hiking_rounded,
      color: Color(0xFFE4E0D8),
      imageUrl:
          'https://images.unsplash.com/photo-1549298916-b41d501d3772?auto=format&fit=crop&w=900&q=85',
      description:
          'Classic proportions, softened edges, and comfort that lasts beyond the commute.',
    ),
    ProductData(
      title: 'Jacquard Story Scarf',
      subtitle: 'Silk blend · vermilion',
      price: 'Rp 420.000',
      label: 'LIMITED',
      icon: Icons.checkroom_rounded,
      color: Color(0xFFFFB49F),
      imageUrl:
          'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?auto=format&fit=crop&w=900&q=85',
      description:
          'A playful graphic layer that turns the simplest uniform into something personal.',
    ),
    ProductData(
      title: 'Line Frame Glasses',
      subtitle: 'Titanium · charcoal',
      price: 'Rp 780.000',
      label: 'NEW',
      icon: Icons.visibility_rounded,
      color: Color(0xFFD9E6EA),
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=900&q=85',
      description:
          'Featherlight titanium frames with a clean, architectural point of view.',
    ),
    ProductData(
      title: 'After Dark Blazer',
      subtitle: 'Velvet · midnight',
      price: 'Rp 1.850.000',
      label: 'CURATED',
      icon: Icons.dry_cleaning_rounded,
      color: Color(0xFFD7D0E6),
      imageUrl:
          'https://images.unsplash.com/photo-1598808503746-f34c53b9323e?auto=format&fit=crop&w=900&q=85',
      description:
          'Relaxed tailoring and deep texture for dinners that turn into late nights.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 620
            ? 3
            : 2;
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: columns == 2 ? 0.62 : 0.7,
            crossAxisSpacing: 14,
            mainAxisSpacing: 20,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) =>
              _ProductCard(item: _items[index], index: index),
        );
      },
    );
  }
}

class ProductData {
  const ProductData({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.label,
    required this.icon,
    required this.color,
    required this.imageUrl,
    required this.description,
  });

  final String title;
  final String subtitle;
  final String price;
  final String label;
  final IconData icon;
  final Color color;
  final String imageUrl;
  final String description;
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.item, required this.index});

  final ProductData item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final heroTag = 'product-$index';
    return Semantics(
      button: true,
      label: 'Lihat ${item.title}',
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ProductDetailPage(item: item, heroTag: heroTag),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ProductArtwork(
                      icon: item.icon,
                      background: item.color,
                      imageUrl: item.imageUrl,
                      heroTag: heroTag,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton.filledTonal(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.white.withValues(
                          alpha: 0.88,
                        ),
                      ),
                      icon: const Icon(Icons.favorite_border_rounded, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 3),
            Text(
              item.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.muted, fontSize: 11),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => _addToCart(context),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: AppColors.charcoal,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppColors.white,
                      size: 19,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.title} ditambahkan ke keranjang')),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.item,
    required this.heroTag,
  });

  final ProductData item;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.sizeOf(context).height * 0.52,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: EditorialIconButton(
                icon: Icons.arrow_back_rounded,
                tooltip: 'Kembali',
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: EditorialIconButton(
                  icon: Icons.favorite_border_rounded,
                  tooltip: 'Favorit',
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(20, 90, 20, 18),
                child: ProductArtwork(
                  icon: item.icon,
                  background: item.color,
                  imageUrl: item.imageUrl,
                  heroTag: heroTag,
                  iconSize: 126,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: const TextStyle(
                      color: AppColors.coral,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 36,
                      height: 1.03,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.subtitle,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: AppColors.inkSoft,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Row(
                    children: [
                      _DetailFact(value: '4.9', label: 'RATING'),
                      SizedBox(width: 34),
                      _DetailFact(value: 'Free', label: 'SHIPPING'),
                      SizedBox(width: 34),
                      _DetailFact(value: '7 days', label: 'RETURN'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PRICE',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.title} ditambahkan ke keranjang'),
                ),
              ),
              icon: const Icon(Icons.shopping_bag_outlined, size: 19),
              label: const Text('Add to bag'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailFact extends StatelessWidget {
  const _DetailFact({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 8,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
