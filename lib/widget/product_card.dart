import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobe_mart/page/detail_product_page.dart';
import 'package:tobe_mart/model/product.dart';
import 'package:tobe_mart/service/api_service.dart';

class ProductsCard extends StatefulWidget {
  final String? searchQuery;

  ProductsCard({Key? key, this.searchQuery}) : super(key: key);

  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  late Future<List<Product>> futureProducts;
  late List<Product> allProducts;
  List<Product> filteredProducts = [];
  NumberFormat rupiahFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _startPolling();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _fetchProducts();
    });
  }

  Future<void> _fetchProducts() async {
    futureProducts = fetchProducts();
    futureProducts.then((products) {
      setState(() {
        allProducts = products;
        _filterProducts();
      });
    });
  }

  void _filterProducts() {
    setState(() {
      if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
        filteredProducts = allProducts
            .where((product) => product.name.toLowerCase().contains(widget.searchQuery!.toLowerCase()))
            .toList();
      } else {
        filteredProducts = allProducts;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Gagal memuat produk'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Tidak ada produk ditemukan'));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await _fetchProducts();
            },
            child: GridView.count(
              controller: _scrollController,
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 0.59,
              children: filteredProducts.map((product) {
                // Debugging print
                print(product.imageUrl);
                return Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailProductPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product.imageUrl,
                            height: 190,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8, right: 5, left: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.name,
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8, right: 5, left: 5),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  rupiahFormat.format(product.price),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  rupiahFormat.format(product.originalPrice),
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset(
                                "assets/images/products/official-badge.svg",
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              product.location,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8, right: 5, left: 5),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.rating.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${product.sold}+ Terjual",
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
