class Product {
  final int id;
  final String kdbarang;
  final String name;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String location;
  final double rating;
  final int sold;
  final int stok;
  final String deskripsi;

  Product({
    required this.id,
    required this.kdbarang,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.location,
    required this.rating,
    required this.sold,
    required this.stok,
    required this.deskripsi,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      kdbarang: json['kd_barang'] ?? '',
      name: json['nama_b'] ?? '',
      imageUrl: 'https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/images/${json['gambar_product'] ?? ''}', // Constructing the image URL
      price: (json['harga_b'] ?? 0).toDouble(),
      originalPrice: ((json['harga_b'] ?? 0) * 1.4).toDouble(), // 40% increase for original price
      location: json['lokasi'] ?? 'Jakarta', // Example static location
      rating: (json['rating'] ?? 5.0).toDouble(), // Example static rating
      sold: (json['sold'] ?? 500).toInt(), // Example static sold value
      stok: json['stok_b'] ?? 0,
      deskripsi: json['deskripsi'] ?? '',
    );
  }
}
