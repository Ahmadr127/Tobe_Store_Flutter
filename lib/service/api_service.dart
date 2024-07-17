import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobe_mart/model/product.dart';
import 'package:tobe_mart/model/user.dart';
import 'package:tobe_mart/model/troli.dart';
import 'package:tobe_mart/model/transaksi.dart';

Future<List<Product>> fetchProducts() async {
  final response =
      await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/barang'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}


Future<List<Product>> fetchProductsByName(String name) async {
  final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/barang/$name'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    print("Data produk diterima: $data"); // Tambahkan log ini
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    print("Gagal memuat produk: ${response.statusCode}"); // Tambahkan log ini
    throw Exception('Failed to load products');
  }
}

Future<User> fetchUserDetails(String kdUser) async {
  final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/users/$kdUser'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return User.fromJson(data);
  } else {
    throw Exception('Failed to load user details');
  }
}
// Fungsi untuk mengambil data troli berdasarkan kd_user
Future<List<Troli>> fetchCartItems(String kdUser) async {
  final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/troli/$kdUser'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => Troli.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load cart items');
  }
}

Future<void> createTransaction(String kdBarang, int jumlahBarang, String metodePembayaran) async {
    final prefs = await SharedPreferences.getInstance();
    final kdUser = prefs.getString('kd_user');

    final response = await http.post(
      Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/transaksi'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'kd_user': kdUser!,
        'kd_barang': kdBarang,
        'jumlah_barang': jumlahBarang.toString(),
        'metode_pembayaran': metodePembayaran,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaction');
    }
  }

  Future<List<Transaction>> fetchTransactions(String kdUser) async {
  final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/transaksi/$kdUser'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => Transaction.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load transactions');
  }
}

Future<void> deleteTransaction(int id) async {
  final response = await http.delete(
    Uri.parse('https://praktikum-cpanel-unbin.com/golang_api/tobe_store_api/transaksi/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete transaction');
  }
}




