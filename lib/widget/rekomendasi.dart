import 'package:flutter/material.dart';
import 'package:tobe_mart/widget/product_card.dart';

class Rekomendasi extends StatelessWidget {
  const Rekomendasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: const Text(
            "Rekomendasi Buat Kamu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        ProductsCard(),
      ],
    );
  }
}
