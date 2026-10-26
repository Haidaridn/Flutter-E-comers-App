import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/categories_widget.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:e_comers_app/widgets/home_appbar.dart';
import 'package:e_comers_app/widgets/items_widget.dart';
import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.cream,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: HomeAppbar()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search the edit',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.sage,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune_rounded, size: 19),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const SliverToBoxAdapter(child: _EditorialHero()),
          const SliverToBoxAdapter(
            child: EditorialSectionTitle(
              eyebrow: 'Browse by mood',
              title: 'Find your thing',
            ),
          ),
          const SliverToBoxAdapter(child: CategoriesWidget()),
          const SliverToBoxAdapter(child: _CuratedCollection()),
          const SliverToBoxAdapter(
            child: EditorialSectionTitle(
              eyebrow: 'The new edit',
              title: 'Objects of desire',
              action: Text(
                'View all  →',
                style: TextStyle(
                  color: AppColors.inkSoft,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: ItemsWidget()),
          const SliverToBoxAdapter(child: SizedBox(height: 118)),
        ],
      ),
    );
  }
}

class _EditorialHero extends StatelessWidget {
  const _EditorialHero();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AspectRatio(
        aspectRatio: MediaQuery.sizeOf(context).width < 520 ? .82 : 1.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: ColoredBox(
            color: AppColors.charcoal,
            child: Stack(
              children: [
                Positioned(
                  right: -35,
                  top: 24,
                  child: Transform.rotate(
                    angle: -0.12,
                    child: Container(
                      width: 190,
                      height: 280,
                      decoration: BoxDecoration(
                        color: AppColors.sage,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.chair_alt_rounded,
                        size: 112,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 96,
                  bottom: 30,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: AppColors.coral,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ISSUE 04  /  HOME',
                        style: TextStyle(
                          color: AppColors.coral,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.8,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 210,
                        child: Text(
                          'Shape your\neveryday.',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 40,
                            height: 0.98,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -2.1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const SizedBox(
                        width: 190,
                        child: Text(
                          'Curated essentials that make ordinary moments feel considered.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Explore the edit  →'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CuratedCollection extends StatelessWidget {
  const _CuratedCollection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.coral,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CURATED COLLECTION',
                    style: TextStyle(
                      color: AppColors.charcoal,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Weekend\nrituals',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 26,
                      height: 1.02,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 94,
              height: 106,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.local_cafe_outlined,
                color: AppColors.charcoal,
                size: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
