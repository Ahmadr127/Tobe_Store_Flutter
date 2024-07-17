import 'package:flutter/material.dart';
import 'package:tobe_mart/widget/appbar.dart';
import 'package:tobe_mart/widget/tabbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black26,
        appBar: CustomAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: TabBarContent(), // Panggil TabBarContent di sini
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const HomePage());
}
