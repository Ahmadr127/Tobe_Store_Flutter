import 'package:intl/intl.dart'; // untuk formatting tanggal

class Transaction {
  final String kdTransaksi;
  final String kdUser;
  final String namaUser;
  final String namaSeller;
  final String namaBarang;
  final int jumlahBarang;
  final double totalHarga;
  final DateTime tglTransaksi;
  final String statusPembayaran;
  final String gambarP; // Tambahkan properti gambarP untuk URL gambar produk

  Transaction({
    required this.kdTransaksi,
    required this.kdUser,
    required this.namaUser,
    required this.namaSeller,
    required this.namaBarang,
    required this.jumlahBarang,
    required this.totalHarga,
    required this.tglTransaksi,
    required this.statusPembayaran,
    required this.gambarP,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      kdTransaksi: json['kd_transaksi'],
      kdUser: json['kd_user'],
      namaUser: json['nama_user'],
      namaSeller: json['nama_seller'],
      namaBarang: json['nama_barang'],
      jumlahBarang: json['jumlah_barang'],
      totalHarga: json['total_harga'].toDouble(),
      tglTransaksi: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['tgl_transaksi']),
      statusPembayaran: json['status_pembayaran'],
      gambarP: json['gambar_p'], // Tambahkan pengambilan data gambar_p dari JSON
    );
  }
}
