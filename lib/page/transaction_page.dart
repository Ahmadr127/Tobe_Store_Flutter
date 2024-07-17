import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TransactionCardPage extends StatefulWidget {
  const TransactionCardPage({Key? key});

  @override
  _TransactionCardPageState createState() => _TransactionCardPageState();
}

class _TransactionCardPageState extends State<TransactionCardPage> {
  List<dynamic> transactions = []; // List to store fetched transactions

  Future<void> fetchTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String kdUser = prefs.getString('kd_user') ?? '';

    try {
      final response = await http.get(
        Uri.parse(
            'https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/transaksi/$kdUser'),
      );

      if (response.statusCode == 200) {
        setState(() {
          transactions = jsonDecode(response.body);
        });
      } else {
        // Handle other status codes or errors
        print('Failed to fetch transactions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  String formatRupiah(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    fetchTransactions(); // Fetch transactions when widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var transaction = transactions[index];
          String namaBarang = transaction['nama_barang'];
          
          // Periksa jika nama_barang lebih dari 18 karakter
          if (namaBarang.length > 13) {
            namaBarang = namaBarang.substring(0, 13) + '...'; // Potong dan tambahkan ellipsis
          }
          
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bagian atas dengan ikon, kategori, dan tanggal
                    Row(
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          color: Colors.blue,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              namaBarang, // Gunakan namaBarang yang sudah dimodifikasi
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              transaction['tgl_transaksi'],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            transaction['status_pembayaran'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            // Implementasikan fungsionalitas opsi lebih banyak
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    // Bagian tengah dengan gambar produk, nama, dan jumlah
                    Row(
                      children: [
                        Image.network(
                          'https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/images/${transaction['gambar_product']}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                namaBarang, // Gunakan namaBarang yang sudah dimodifikasi
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${transaction['jumlah_barang']} barang',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    // Bagian bawah dengan total harga dan tombol aksi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Belanja',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              formatRupiah(double.parse(
                                  transaction['total_harga'].toString())),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Implementasikan fungsionalitas beli lagi
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Beli Lagi',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
