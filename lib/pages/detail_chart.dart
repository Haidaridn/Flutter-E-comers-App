import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.contactName});

  final String contactName;

  static const _messages = <_ChatMessage>[
    _ChatMessage(
      message: 'Segera pesan sebelum barang habis!',
      isMine: false,
      time: '10:22',
    ),
    _ChatMessage(
      message: 'Terima kasih, saya akan segera memesan.',
      isMine: true,
      time: '10:25',
    ),
    _ChatMessage(
      message: 'Baik, kami tunggu pesanannya.',
      isMine: false,
      time: '10:26',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EditorialPageHeader(
              eyebrow: 'Online now',
              title: contactName,
              leading: EditorialIconButton(
                icon: Icons.arrow_back_rounded,
                tooltip: 'Kembali',
                onPressed: () => Navigator.pop(context),
              ),
              trailing: EditorialIconButton(
                icon: Icons.more_horiz_rounded,
                tooltip: 'Menu',
                onPressed: () {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Divider(color: AppColors.line)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'TODAY',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.line)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.isMine
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 310),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.fromLTRB(16, 13, 16, 10),
                      decoration: BoxDecoration(
                        color: message.isMine
                            ? AppColors.coral
                            : AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(22),
                          topRight: const Radius.circular(22),
                          bottomLeft: Radius.circular(message.isMine ? 22 : 5),
                          bottomRight: Radius.circular(message.isMine ? 5 : 22),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message.message,
                            style: TextStyle(
                              color: message.isMine
                                  ? AppColors.white
                                  : AppColors.charcoal,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            message.time,
                            style: TextStyle(
                              color: message.isMine
                                  ? Colors.white70
                                  : AppColors.muted,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.line),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline_rounded),
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Write a message...',
                        ),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.charcoal,
                      ),
                      icon: const Icon(
                        Icons.arrow_upward_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.message,
    required this.isMine,
    required this.time,
  });
  final String message;
  final bool isMine;
  final String time;
}
