import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tobe_mart/page/carabayar_page.dart'; // Import the CaraPembayaranPage

class PaymentCard extends StatelessWidget {
  final String kdTransaksi;
  final double totalTagihan;

  PaymentCard({required this.kdTransaksi, required this.totalTagihan});

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 480,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bayar sebelum',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.red),
                          SizedBox(width: 4),
                          Text(
                            '23:59:51',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '18 Jul 2024, 10:45 WIB',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kode Bayar',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            kdTransaksi,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                          TextButton.icon(
                            onPressed: () {
                              FlutterClipboard.copy(kdTransaksi)
                                  .then((value) => print('copied'));
                            },
                            icon: Icon(Icons.copy, color: Colors.green),
                            label: Text('Copy',
                                style: TextStyle(color: Colors.green)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Tagihan',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            currencyFormat.format(totalTagihan),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        'Lihat Detail',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
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
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CaraPembayaranPage(
                                  kdTransaksi: kdTransaksi,
                                  totalTagihan: totalTagihan,
                                ),
                              ),
                            );
                          },
                          child: Text('Lihat Cara Bayar'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // handle check payment status
                          },
                          child: Text('Cek Status Bayar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
