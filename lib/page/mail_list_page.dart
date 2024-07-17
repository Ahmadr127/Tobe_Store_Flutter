import 'package:flutter/material.dart';
import 'package:tobe_mart/widget/mail.dart';

class ListMail extends StatelessWidget {
  const ListMail({super.key});

  final List<ChatItem> chatItems = const [
    ChatItem(
      avatar: 'https://example.com/avatar1.png',
      name: 'WibuTech',
      message: 'ready bro',
      timestamp: 'Feb 2024',
    ),
    ChatItem(
      avatar: 'https://example.com/avatar2.png',
      name: 'zaeen_shop21',
      message: 'ready',
      timestamp: 'Feb 2024',
    ),
    ChatItem(
      avatar: 'https://example.com/avatar3.png',
      name: 'ambon.jaya',
      message: 'Yuk diorder',
      timestamp: 'Feb 2024',
    ),
    ChatItem(
      avatar: 'https://example.com/avatar4.png',
      name: 'Ciki Comstore',
      message: 'ready',
      timestamp: 'Feb 2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          final item = chatItems[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(item.avatar),
            ),
            title: Text(item.name),
            subtitle: Text(item.message),
            trailing: Text(item.timestamp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MailDetail(chatItem: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatItem {
  final String avatar;
  final String name;
  final String message;
  final String timestamp;

  const ChatItem({
    required this.avatar,
    required this.name,
    required this.message,
    required this.timestamp,
  });
}

void main() {
  runApp(MaterialApp(
    home: ListMail(),
  ));
}
