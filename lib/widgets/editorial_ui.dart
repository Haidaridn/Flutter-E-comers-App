import 'package:e_comers_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EditorialPageHeader extends StatelessWidget {
  const EditorialPageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.leading,
    this.trailing,
  });

  final String eyebrow;
  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
        child: Row(
          children: [
            ...(leading == null
                ? const <Widget>[]
                : <Widget>[leading!, const SizedBox(width: 12)]),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.coral,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.charcoal,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.1,
                    ),
                  ),
                ],
              ),
            ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class EditorialIconButton extends StatelessWidget {
  const EditorialIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.backgroundColor = AppColors.white,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        color: AppColors.charcoal,
        icon: Icon(icon, size: 21),
      ),
    );
  }
}

class EditorialSectionTitle extends StatelessWidget {
  const EditorialSectionTitle({
    super.key,
    required this.eyebrow,
    required this.title,
    this.action,
  });

  final String eyebrow;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.coral,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.9,
                  ),
                ),
              ],
            ),
          ),
          action ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class EditorialSurface extends StatelessWidget {
  const EditorialSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin,
    this.color = AppColors.white,
    this.radius = 24,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.charcoal.withValues(alpha: 0.045)),
        boxShadow: [
          BoxShadow(
            color: AppColors.charcoal.withValues(alpha: 0.055),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ProductArtwork extends StatelessWidget {
  const ProductArtwork({
    super.key,
    required this.icon,
    required this.background,
    this.imageUrl,
    this.heroTag,
    this.iconSize = 64,
  });

  final IconData icon;
  final Color background;
  final String? imageUrl;
  final Object? heroTag;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final fallbackArtwork = Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -34,
          right: -22,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.35),
            ),
          ),
        ),
        Positioned(
          bottom: -24,
          left: -16,
          child: Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.charcoal.withValues(alpha: 0.08),
                width: 12,
              ),
            ),
          ),
        ),
        Center(
          child: Transform.rotate(
            angle: -0.08,
            child: Icon(icon, size: iconSize, color: AppColors.charcoal),
          ),
        ),
      ],
    );

    final artwork = DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: imageUrl == null
            ? fallbackArtwork
            : Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                    errorBuilder: (_, _, _) =>
                        ColoredBox(color: background, child: fallbackArtwork),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x26000000)],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );

    return heroTag == null ? artwork : Hero(tag: heroTag!, child: artwork);
  }
}
