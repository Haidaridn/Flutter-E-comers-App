import 'package:e_comers_app/pages/cart_page.dart';
import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, this.showBackButton = true});
  final bool showBackButton;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _fade = curve;
    _slide = Tween(
      begin: const Offset(0, .05),
      end: Offset.zero,
    ).animate(curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          EditorialPageHeader(
            eyebrow: 'Your space',
            title: 'Account',
            leading: widget.showBackButton
                ? EditorialIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Kembali',
                    onPressed: () => Navigator.maybePop(context),
                  )
                : null,
            trailing: EditorialIconButton(
              icon: Icons.notifications_none_rounded,
              tooltip: 'Notifikasi',
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tidak ada notifikasi baru saat ini'),
                ),
              ),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    widget.showBackButton ? 28 : 116,
                  ),
                  children: [
                    const _ProfileCard(),
                    const SizedBox(height: 16),
                    const _StatsCard(),
                    const EditorialSectionTitle(
                      eyebrow: 'Personalize',
                      title: 'Your settings',
                    ),
                    _SettingsTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Profile details',
                      subtitle: 'Name, email and delivery information',
                      onTap: () => _info('Membuka halaman Edit Profil'),
                    ),
                    _SettingsTile(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My bag',
                      subtitle: 'Review your selected pieces',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const CartPage(),
                        ),
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'Password & security',
                      subtitle: 'Keep your account protected',
                      onTap: () =>
                          Navigator.pushNamed(context, '/change_password_page'),
                    ),
                    _SettingsTile(
                      icon: Icons.shield_outlined,
                      title: 'Privacy & policy',
                      subtitle: 'How we protect your information',
                      onTap: _showPrivacyDialog,
                    ),
                    _SettingsTile(
                      icon: Icons.logout_rounded,
                      title: 'Sign out',
                      subtitle: 'End this shopping session',
                      isDestructive: true,
                      onTap: _showLogoutDialog,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _info(String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  void _showPrivacyDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Privacy & Policy'),
        content: const Text(
          'Data akun digunakan hanya untuk mendukung pengalaman belanja, pesanan, dan keamanan akun Anda.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('Anda akan kembali ke halaman login.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login_page',
                (_) => false,
              );
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            width: 74,
            height: 86,
            decoration: BoxDecoration(
              color: AppColors.sage,
              borderRadius: BorderRadius.circular(37),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 42,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GOLD MEMBER',
                  style: TextStyle(
                    color: AppColors.coral,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Prabu Widodo',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.7,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'joko@gmail.com',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_outward_rounded, color: AppColors.white),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();
  @override
  Widget build(BuildContext context) {
    return const EditorialSurface(
      child: Row(
        children: [
          _Stat(value: '12', label: 'ORDERS'),
          _Rule(),
          _Stat(value: '05', label: 'VOUCHERS'),
          _Rule(),
          _Stat(value: '2.4K', label: 'POINTS'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 8,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
      ],
    ),
  );
}

class _Rule extends StatelessWidget {
  const _Rule();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: AppColors.line);
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? const Color(0xFFC84532) : AppColors.charcoal;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? const Color(0xFFFFE5DE)
                        : AppColors.sage,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: color, size: 19),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
