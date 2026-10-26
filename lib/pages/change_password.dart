import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value, String label) {
    if (value == null || value.trim().isEmpty) return 'Masukkan $label';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    if (_newPasswordController.text == _currentPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password baru harus berbeda dari password saat ini'),
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berhasil diperbarui')),
    );
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: EditorialPageHeader(
                eyebrow: 'Account security',
                title: 'New password',
                leading: EditorialIconButton(
                  icon: Icons.arrow_back_rounded,
                  tooltip: 'Kembali',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.charcoal,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Row(
                              children: [
                                CircleAvatar(
                                  radius: 27,
                                  backgroundColor: AppColors.coral,
                                  child: Icon(
                                    Icons.shield_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                                SizedBox(width: 17),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Keep it personal',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Gunakan minimal 6 karakter dan hindari password lama.',
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 11,
                                          height: 1.45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          _PasswordField(
                            controller: _currentPasswordController,
                            label: 'Current password',
                            obscureText: _obscureCurrent,
                            onToggle: () => setState(
                              () => _obscureCurrent = !_obscureCurrent,
                            ),
                            validator: (value) =>
                                _validatePassword(value, 'password saat ini'),
                          ),
                          const SizedBox(height: 14),
                          _PasswordField(
                            controller: _newPasswordController,
                            label: 'New password',
                            obscureText: _obscureNew,
                            onToggle: () =>
                                setState(() => _obscureNew = !_obscureNew),
                            validator: (value) =>
                                _validatePassword(value, 'password baru'),
                          ),
                          const SizedBox(height: 14),
                          _PasswordField(
                            controller: _confirmPasswordController,
                            label: 'Confirm new password',
                            obscureText: _obscureConfirm,
                            onToggle: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                            validator: (value) {
                              final validation = _validatePassword(
                                value,
                                'konfirmasi password',
                              );
                              if (validation != null) {
                                return validation;
                              }
                              if (value != _newPasswordController.text) {
                                return 'Konfirmasi password tidak cocok';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _submitForm,
                              icon: const Icon(Icons.lock_reset_rounded),
                              label: const Text('Update password'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.onToggle,
    required this.validator,
  });
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final VoidCallback onToggle;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }
}
