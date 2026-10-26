import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key, this.showBackButton = true});
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return EditorialPageHeader(
      eyebrow: 'Your selection',
      title: 'The bag',
      leading: showBackButton
          ? EditorialIconButton(
              icon: Icons.arrow_back_rounded,
              tooltip: 'Kembali',
              onPressed: () => Navigator.maybePop(context),
            )
          : null,
      trailing: const Text(
        '06',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
      ),
    );
  }
}
