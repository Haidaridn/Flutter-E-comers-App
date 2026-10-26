import 'package:e_comers_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  static const _categories = <({String label, IconData icon})>[
    (label: 'All', icon: Icons.apps_rounded),
    (label: 'Wear', icon: Icons.checkroom_rounded),
    (label: 'Living', icon: Icons.chair_alt_rounded),
    (label: 'Beauty', icon: Icons.spa_outlined),
    (label: 'Tech', icon: Icons.headphones_rounded),
    (label: 'Taste', icon: Icons.local_cafe_outlined),
  ];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final category = _categories[index];
          final selected = index == _selected;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => setState(() => _selected = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.charcoal : AppColors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selected ? AppColors.charcoal : AppColors.line,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category.icon,
                        size: 18,
                        color: selected ? AppColors.coral : AppColors.charcoal,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category.label,
                        style: TextStyle(
                          color: selected
                              ? AppColors.white
                              : AppColors.charcoal,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
