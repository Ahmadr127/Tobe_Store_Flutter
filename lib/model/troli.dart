class Troli {
  final int id;
  final String kdSeller;
  final String namaSeller;
  final String namaBarang;
  final String kdBarang;
  final String gambarP;
  final double hargaB;
  final int jumlahBarang;

  Troli({
    required this.id,
    required this.kdSeller,
    required this.namaSeller,
    required this.namaBarang,
    required this.kdBarang,
    required this.gambarP,
    required this.hargaB,
    required this.jumlahBarang,
  });

  factory Troli.fromJson(Map<String, dynamic> json) {
    return Troli(
      id: json['id'],
      kdSeller: json['kd_seller'],
      kdBarang: json['kd_barang'],
      namaSeller: json['nama_seller'] ?? 'Nama Seller Tidak Tersedia',
      namaBarang: json['nama_b'] ?? 'Nama Barang Tidak Tersedia',
      gambarP:
          'https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/images/${json['gambar_p'] ?? ''}', // Constructing the image URL
      hargaB: json['harga_b'] != null ? json['harga_b'].toDouble() : 0.0,
      jumlahBarang: json['jumlah_barang'] != null ? json['jumlah_barang'] : 0,
    );
  }
}
