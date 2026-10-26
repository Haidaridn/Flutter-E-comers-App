import 'package:e_comers_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CartBottomNavbar extends StatelessWidget {
  const CartBottomNavbar({
    super.key,
    required this.itemCount,
    required this.totalAmount,
  });
  final int itemCount;
  final int totalAmount;

  String _formatRupiah(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && (digits.length - index) % 3 == 0) buffer.write('.');
      buffer.write(digits[index]);
    }
    return 'Rp ${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = itemCount == 0;
    return Material(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$itemCount ITEMS · TOTAL',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _formatRupiah(totalAmount),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: isEmpty
                  ? null
                  : () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur checkout belum tersedia.'),
                      ),
                    ),
              child: const Text('Checkout  →'),
            ),
          ],
        ),
      ),
    );
  }
}
