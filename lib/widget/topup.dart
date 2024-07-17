import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopupGopay extends StatefulWidget {
  const TopupGopay({Key? key}) : super(key: key);

  @override
  _TopupGopayState createState() => _TopupGopayState();
}

class _TopupGopayState extends State<TopupGopay> {
  String userName = "User";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('nama_users') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Selamat Datang $userName",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeatureItem(
                icon: Icons.account_balance_wallet,
                color: Colors.blue,
                title: 'Rp1.301',
                subtitle: 'Top-Up ToBe',
                onTap: () {
                  // Handle top-up GoPay tap
                },
              ),
              _buildFeatureItem(
                icon: Icons.subscriptions,
                color: Colors.green,
                title: 'Coba 1 Bulan',
                subtitle: 'Langganan, Yuk!',
                onTap: () {
                  // Handle langganan tap
                },
              ),
              _buildFeatureItem(
                icon: Icons.star_border,
                color: Colors.grey,
                title: 'Silver',
                subtitle: '8 Kupon Baru',
                onTap: () {
                  // Handle silver kupon tap
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 16,
            child: Icon(
              icon,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
