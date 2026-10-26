import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/cart_appbar.dart';
import 'package:e_comers_app/widgets/cart_bottomnavbar.dart';
import 'package:e_comers_app/widgets/cart_itemsamples.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, this.showBackButton = true});
  final bool showBackButton;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _itemCount = 6;
  int _totalAmount = 1000000;

  void _updateCart(int itemCount, int totalAmount) {
    setState(() {
      _itemCount = itemCount;
      _totalAmount = totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          CartAppBar(showBackButton: widget.showBackButton),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: 8,
                bottom: widget.showBackButton ? 24 : 110,
              ),
              children: [
                EditorialSurface(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                  color: AppColors.sage,
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppColors.charcoal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivering to',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Jl. Sudirman No. 45, Jakarta Selatan',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Pengaturan alamat belum tersedia.',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: AppColors.coral),
                        ),
                      ),
                    ],
                  ),
                ),
                CartItemSamples(onCartChanged: _updateCart),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CartBottomNavbar(
        itemCount: _itemCount,
        totalAmount: _totalAmount,
      ),
    );
  }
}
