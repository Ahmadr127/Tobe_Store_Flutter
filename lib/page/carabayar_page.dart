import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import NumberFormat for currency formatting
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tobe_mart/page/home_page.dart'; // Import QrImage for QR code generation

class CaraPembayaranPage extends StatelessWidget {
  final String kdTransaksi;
  final double totalTagihan;

  CaraPembayaranPage({required this.kdTransaksi, required this.totalTagihan});

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return Scaffold(
      appBar: AppBar(
        title: Text('Cara Pembayaran'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.network(
                  'https://logos-world.net/wp-content/uploads/2022/04/Alfamart-Logo.png',
                  // Replace with actual Alfamart logo URL
                ),
                title: Text(
                  'Alfamart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('1. Datang ke Alfamart.'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('2. Tunjukkan kode pembayaran ke kasir.'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                    '3. Bayar dengan uang tunai sesuai total pembayaran (sudah termasuk biaya layanan).'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('4. Transaksi selesai, simpan bukti pembayaranmu.'),
              ),
              Divider(),

              SizedBox(height: 16),
              Text(
                'Kode Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    kdTransaksi,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Total Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                currencyFormat.format(totalTagihan),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Center(
                child: QrImageView(
                  data: kdTransaksi,
                  version: QrVersions.auto,
                  size: 150.0,
                ),
              ),
              SizedBox(height: 16),
              Divider(),

              // Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.security, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                          'Pembayaran terjamin\nTobe Store menjamin keamanan dana yang kamu bayarkan di tiap transaksi.'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.lock, color: Colors.yellow),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                          'Jaga keamanan datamu\nJangan menyebarkan bukti & data pembayaran ke pihak mana pun kecuali Tobe Store.'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
