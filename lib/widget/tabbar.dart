import 'package:flutter/material.dart';
import 'package:tobe_mart/page/transaction_page.dart';
import 'package:tobe_mart/widget/image_slider.dart';
import 'package:tobe_mart/widget/rekomendasi.dart';
import 'package:tobe_mart/widget/topup.dart';
import 'package:tobe_mart/widget/flashsale.dart';
import 'package:tobe_mart/page/profile_page.dart';

class TabBarContent extends StatelessWidget {
  const TabBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  const SingleChildScrollView(
                    child: Column(
                      children: [
                        TopupGopay(),
                        ImageSlider(),
                        FlashSale(),
                        Rekomendasi(),
                      ],
                    ),
                  ),
                  const TransactionCardPage(),
                  ProfilePage(),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: const TabBar(
                indicatorColor: Colors.blue,
                unselectedLabelColor: Colors.black87,
                labelColor: Colors.blue,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(Icons.receipt_rounded),
                    text: 'Transaksi',
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
