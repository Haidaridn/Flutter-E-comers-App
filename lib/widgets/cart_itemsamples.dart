import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key, required this.onCartChanged});
  final void Function(int itemCount, int totalAmount) onCartChanged;

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  final List<_CartItem> _items = [
    _CartItem(
      name: 'Form No. 02 Watch',
      detail: 'Oat · One size',
      unitPrice: 150000,
      icon: Icons.watch_rounded,
      color: AppColors.sage,
    ),
    _CartItem(
      name: 'Soft Geometry Tote',
      detail: 'Clay · Medium',
      unitPrice: 125000,
      icon: Icons.shopping_bag_rounded,
      color: const Color(0xFFFFD8C9),
    ),
    _CartItem(
      name: 'Everyday Oxford',
      detail: 'Espresso · 42',
      unitPrice: 200000,
      icon: Icons.hiking_rounded,
      color: const Color(0xFFE4E0D8),
    ),
    _CartItem(
      name: 'Jacquard Story Scarf',
      detail: 'Vermilion · 90 cm',
      unitPrice: 175000,
      icon: Icons.checkroom_rounded,
      color: const Color(0xFFFFB49F),
    ),
    _CartItem(
      name: 'Daily Ritual Serum',
      detail: 'Natural · 30 ml',
      unitPrice: 100000,
      icon: Icons.spa_outlined,
      color: const Color(0xFFDFEAD6),
    ),
    _CartItem(
      name: 'Studio Headphones',
      detail: 'Graphite · Wireless',
      unitPrice: 250000,
      icon: Icons.headphones_rounded,
      color: const Color(0xFFD9E6EA),
    ),
  ];

  int get _itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  int get _totalAmount =>
      _items.fold(0, (sum, item) => sum + item.unitPrice * item.quantity);

  String _formatRupiah(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && (digits.length - index) % 3 == 0) buffer.write('.');
      buffer.write(digits[index]);
    }
    return 'Rp ${buffer.toString()}';
  }

  void _updateCart(VoidCallback update) {
    setState(update);
    widget.onCartChanged(_itemCount, _totalAmount);
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 70),
        child: Column(
          children: [
            Icon(Icons.shopping_bag_outlined, size: 52, color: AppColors.muted),
            SizedBox(height: 14),
            Text(
              'Your bag is taking a break',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      );
    }
    return Column(
      children: _items
          .map(
            (item) => _CartRow(
              item: item,
              formattedPrice: _formatRupiah(item.unitPrice),
              onRemove: () => _updateCart(() => _items.remove(item)),
              onDecrease: item.quantity > 1
                  ? () => _updateCart(() => item.quantity--)
                  : null,
              onIncrease: () => _updateCart(() => item.quantity++),
            ),
          )
          .toList(),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({
    required this.item,
    required this.formattedPrice,
    required this.onRemove,
    required this.onDecrease,
    required this.onIncrease,
  });
  final _CartItem item;
  final String formattedPrice;
  final VoidCallback onRemove;
  final VoidCallback? onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return EditorialSurface(
      margin: const EdgeInsets.fromLTRB(20, 7, 20, 7),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            height: 106,
            child: ProductArtwork(
              icon: item.icon,
              background: item.color,
              iconSize: 42,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 106,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onRemove,
                        tooltip: 'Hapus ${item.name}',
                        icon: const Icon(Icons.close_rounded, size: 18),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  Text(
                    item.detail,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        formattedPrice,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      _QuantityButton(
                        icon: Icons.remove_rounded,
                        onTap: onDecrease,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add_rounded,
                        onTap: onIncrease,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        size: 16,
        color: onTap == null ? AppColors.line : AppColors.charcoal,
      ),
    ),
  );
}

class _CartItem {
  _CartItem({
    required this.name,
    required this.detail,
    required this.unitPrice,
    required this.icon,
    required this.color,
  });
  final String name;
  final String detail;
  final int unitPrice;
  final IconData icon;
  final Color color;
  int quantity = 1;
}
