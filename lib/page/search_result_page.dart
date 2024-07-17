import 'package:flutter/material.dart';
import 'package:tobe_mart/widget/product_card.dart';

class SearchResultPage extends StatelessWidget {
  final String searchQuery;

  const SearchResultPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Pencarian: $searchQuery'),
      ),
      body: ProductsCard(searchQuery: searchQuery),
    );
  }
}
