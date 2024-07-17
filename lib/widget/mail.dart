import 'package:flutter/material.dart';
import 'package:tobe_mart/page/mail_list_page.dart';

class MailDetail extends StatelessWidget {
  final ChatItem chatItem;

  const MailDetail({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(chatItem.avatar),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatItem.name,
                  style: const TextStyle(color: Colors.black),
                ),
                const Text(
                  'Terakhir online 1 jam lalu',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Text(
                  "Hati-hati penipuan! Mohon tidak bertransaksi di luar Tobe Mart dan tidak memberikan data pribadi kepada penjual, seperti nomor HP dan alamat. Tetap berinteraksi melalui aplikasi Tokopedia, ya. Baca Panduan Keamanan.",
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "29 February, 2024",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Siang Minn Apakah Khodamnya masih tersedia?",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "13:19",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Masih ready Bro",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "14:12",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tulis pesan...",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.send, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
