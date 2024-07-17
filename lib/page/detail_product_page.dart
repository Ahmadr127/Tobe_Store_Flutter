import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for currency formatting
import 'package:tobe_mart/model/product.dart'; // Adjust import based on your project structure
import 'package:tobe_mart/page/pembayaran_page.dart'; // Import your PaymentForm page

class DetailProductPage extends StatelessWidget {
  final Product product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Detail Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "RP ${NumberFormat("#,###").format(product.price)}", // Format price with IDR currency
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Rp ${NumberFormat("#,###").format(product.originalPrice)}", // Format original price with IDR currency
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 20),
                  const SizedBox(width: 5),
                  Text(product.rating.toString(),
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Text("${product.sold}+ Terjual",
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const Divider(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                "Detail Produk",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(120),
                  1: FixedColumnWidth(200),
                },
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.transparent),
                  verticalInside: BorderSide(color: Colors.transparent),
                ),
                children: [
                  _buildTableRow("Merek", product.name),
                  _buildTableRow("Tahun Rilis", "2021"),
                  _buildTableRow(
                      "Stok", product.stok.toString()), // Use product.stok
                  _buildTableRow("Tipe Garansi", "Resmi"),
                ],
              ),
            ),
            const Divider(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                "Deskripsi Produk",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.deskripsi, // Use product.deskripsi
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Divider(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  // Implement chat functionality
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: const Icon(Icons.chat, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Navigate to PaymentForm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentForm(product: product),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    "Beli",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement adding to cart logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    "+ Keranjang",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
