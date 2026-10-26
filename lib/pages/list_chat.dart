import 'package:e_comers_app/theme/app_theme.dart';
import 'package:e_comers_app/widgets/editorial_ui.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  static const _chats = <_ChatPreview>[
    _ChatPreview(
      name: 'Pasep',
      lastMessage: 'Segera di-checkout',
      time: '10:30',
      initials: 'PA',
      isRead: false,
      color: Color(0xFFDDE8D5),
    ),
    _ChatPreview(
      name: 'Darrel',
      lastMessage: 'Ukuran tersedia kembali hari ini',
      time: '10:30',
      initials: 'DA',
      isRead: false,
      color: Color(0xFFFFD8C9),
    ),
    _ChatPreview(
      name: 'Kevin',
      lastMessage: 'Terima kasih sudah berbelanja',
      time: '22:32',
      initials: 'KE',
      isRead: true,
      color: Color(0xFFD9E6EA),
    ),
    _ChatPreview(
      name: 'James',
      lastMessage: 'Pesanan sedang kami siapkan',
      time: '09:45',
      initials: 'JA',
      isRead: true,
      color: Color(0xFFE4E0D8),
    ),
    _ChatPreview(
      name: 'Yaser',
      lastMessage: 'Ada yang bisa kami bantu?',
      time: '08:20',
      initials: 'YA',
      isRead: false,
      color: Color(0xFFE6DDF0),
    ),
    _ChatPreview(
      name: 'Lebron',
      lastMessage: 'Warna clay masih tersedia',
      time: 'Kemarin',
      initials: 'LE',
      isRead: false,
      color: Color(0xFFFFE6A8),
    ),
  ];

  bool _showUnreadOnly = false;

  void _openChat(_ChatPreview chat) {
    Navigator.pushNamed(
      context,
      '/detail_chat',
      arguments: {'contactName': chat.name},
    );
  }

  Future<void> _searchChats() async {
    final selected = await showSearch<_ChatPreview?>(
      context: context,
      delegate: _ChatSearchDelegate(_chats),
    );
    if (selected != null && mounted) _openChat(selected);
  }

  @override
  Widget build(BuildContext context) {
    final visibleChats = _showUnreadOnly
        ? _chats.where((chat) => !chat.isRead).toList()
        : _chats;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EditorialPageHeader(
              eyebrow: 'Concierge',
              title: 'Messages',
              leading: EditorialIconButton(
                icon: Icons.arrow_back_rounded,
                tooltip: 'Kembali',
                onPressed: () => Navigator.pop(context),
              ),
              trailing: EditorialIconButton(
                icon: Icons.search_rounded,
                tooltip: 'Cari chat',
                onPressed: _searchChats,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All messages',
                    selected: !_showUnreadOnly,
                    onTap: () => setState(() => _showUnreadOnly = false),
                  ),
                  const SizedBox(width: 9),
                  _FilterChip(
                    label: 'Unread',
                    selected: _showUnreadOnly,
                    onTap: () => setState(() => _showUnreadOnly = true),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                itemCount: visibleChats.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final chat = visibleChats[index];
                  return _ChatTile(chat: chat, onTap: () => _openChat(chat));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.charcoal : AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? AppColors.charcoal : AppColors.line,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.white : AppColors.charcoal,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  const _ChatTile({required this.chat, required this.onTap});
  final _ChatPreview chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: chat.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  chat.initials,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: chat.isRead
                                  ? FontWeight.w700
                                  : FontWeight.w900,
                            ),
                          ),
                        ),
                        Text(
                          chat.time,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        if (!chat.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.coral,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatSearchDelegate extends SearchDelegate<_ChatPreview?> {
  _ChatSearchDelegate(this.chats);
  final List<_ChatPreview> chats;

  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear_rounded),
      ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: const Icon(Icons.arrow_back_rounded),
  );

  @override
  Widget buildResults(BuildContext context) => _matches(context);

  @override
  Widget buildSuggestions(BuildContext context) => _matches(context);

  Widget _matches(BuildContext context) {
    final normalized = query.trim().toLowerCase();
    final matches = chats.where(
      (chat) => chat.name.toLowerCase().contains(normalized),
    );
    return ListView(
      padding: const EdgeInsets.all(20),
      children: matches
          .map(
            (chat) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ChatTile(chat: chat, onTap: () => close(context, chat)),
            ),
          )
          .toList(),
    );
  }
}

class _ChatPreview {
  const _ChatPreview({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.initials,
    required this.isRead,
    required this.color,
  });
  final String name;
  final String lastMessage;
  final String time;
  final String initials;
  final bool isRead;
  final Color color;
}
