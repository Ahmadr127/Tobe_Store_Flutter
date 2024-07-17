import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for currency formatting
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences package
import 'package:http/http.dart' as http; // Import http package for API calls
import 'dart:convert'; // Import dart:convert for JSON encoding and decoding
import 'package:tobe_mart/model/product.dart'; // Adjust import based on your project structure
import 'package:tobe_mart/widget/payment_card.dart';

class PaymentForm extends StatefulWidget {
  final Product product;

  PaymentForm({required this.product});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  int quantity = 1; // Quantity default
  String selectedPaymentMethod = 'Alfamart'; // Default selected payment method
  String namaUser = '';
  String alamatUser = '';
  String kdUser = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      namaUser = prefs.getString('nama_users') ?? 'Guest';
      alamatUser = prefs.getString('alamat') ?? 'Alamat tidak tersedia';
      kdUser = prefs.getString('kd_user') ?? '';
    });
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _submitTransaction() async {
    final double totalHarga = widget.product.price * quantity +   9000; // Total tagihan
    final Map<String, dynamic> transaksiData = {
      'kd_user': kdUser,
      'kd_barang': widget.product.kdbarang,
      'jumlah_barang': quantity,
      'total_harga': totalHarga,
      'metode_pembayaran': selectedPaymentMethod,
    };

    try {
      final response = await http.post(
        Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/transaksii'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transaksiData),
      );

      if (response.statusCode == 201) {
        // Transaction created successfully
        final responseData = jsonDecode(response.body);
        _showSuccessDialog(responseData['message']);
        String kdTransaksi = responseData['kd_transaksi']; // Ambil kd_transaksi dari respons API
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentCard(
                kdTransaksi: kdTransaksi,
                totalTagihan: totalHarga, // Pass the totalHarga to PaymentCard
              )),
        );
      } else {
        final errorData = jsonDecode(response.body);
        _showErrorDialog(errorData['error'] ?? 'Terjadi kesalahan pada server.');
      }
    } catch (e) {
      _showErrorDialog('Terjadi kesalahan pada koneksi. Silakan coba lagi.');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sukses'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back to previous page
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format currency
    NumberFormat currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text('Rumah · $namaUser'), // Nama user
              subtitle: Text(alamatUser), // Alamat user
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const Divider(),
            ListTile(
              leading: Image.network(
                widget.product.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currencyFormat.format(widget.product.price),
                          style: const TextStyle(fontSize: 14)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              decrementQuantity();
                            },
                          ),
                          Text(quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              incrementQuantity();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text('Next Day'),
              subtitle: Text('Tobe Express (Rp9.000)\nEst. tiba besok Insyaallah'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const Divider(),
            ListTile(
              title: const Text('Metode pembayaran'),
              subtitle: DropdownButton<String>(
                value: selectedPaymentMethod,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue!;
                  });
                },
                items: <String>['Alfamart', 'COD'] // Pilihan metode pembayaran
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text('Total Harga (${quantity.toString()} Barang)'),
              trailing: Text(currencyFormat.format(widget.product.price * quantity)),
            ),
            const ListTile(
              title: Text('Total Ongkos Kirim'),
              trailing: Text('Rp9.000'),
            ),
            ListTile(
              title: const Text('Total Tagihan'),
              trailing: Text(
                currencyFormat.format(widget.product.price * quantity + 9000),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi'),
                        content: Text('Apakah data pembelianmu sudah benar?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Tidak'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Ya'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _submitTransaction(); // Submit transaction after confirmation
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Text(
              'Dengan klik Bayar Sekarang, kamu menyetujui S&K Asuransi Pengiriman & Proteksi.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
