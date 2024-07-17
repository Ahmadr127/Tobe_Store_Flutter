import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobe_mart/model/troli.dart';
import 'package:tobe_mart/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobe_mart/page/home_page.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final Map<int, bool> _checkedItems = {};
  final Map<int, int> _itemQuantities = {};
  List<Troli> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final kdUser = prefs.getString('kd_user');

    if (kdUser != null) {
      try {
        final cartItems = await fetchCartItems(kdUser);
        setState(() {
          _cartItems = cartItems;
          for (var item in cartItems) {
            _itemQuantities[item.id] = item.jumlahBarang; // Initialize quantities from API data
          }
        });
      } catch (e) {
        print('Error fetching cart items: $e');
        // Handle error, show error message, etc.
      }
    }
  }

  String _formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Keranjang", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const HomePage();
            }));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _cartItems.isEmpty
                ? Center(child: Text('Keranjang Kosong'))
                : ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return buildCartItem(
                        item.id,
                        item.namaSeller,
                        item.gambarP,
                        item.namaBarang,
                        item.hargaB,
                        item.jumlahBarang,
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 18)),
                Text(_formatCurrency(_calculateTotal()),
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child:
                    const Text('Beli', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      if (_checkedItems[item.id] ?? false) { // Consider only checked items
        final quantity = _itemQuantities[item.id] ?? 1;
        total += item.hargaB * quantity;
      }
    }
    return total;
  }

  Widget buildCartItem(int id, String storeName, String imageUrl,
      String productName, double price, int initialQuantity) {
    _itemQuantities.putIfAbsent(id, () => initialQuantity);

    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _checkedItems[id] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  _checkedItems[id] = value ?? false;
                });
              },
              checkColor: Colors.white,
              activeColor: Colors.blue,
            ),
            Image.network(imageUrl, width: 70, height: 70), // Load images from network
          ],
        ),
        title: Text(
          storeName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              _formatCurrency(price),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove,
                      size: 18,
                    ),
                    onPressed: () {
                      if (_itemQuantities[id]! > 1) {
                        _itemQuantities[id] = _itemQuantities[id]! - 1;
                      }
                      setState(() {});
                    },
                  ),
                  Text(
                    '${_itemQuantities[id]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        _itemQuantities[id] = _itemQuantities[id]! + 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _deleteCartItem(id); // Call delete method here
          },
        ),
      ),
    );
  }

  void _deleteCartItem(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus item dari troli?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                try {
                  await deleteTransaction(id);
                  setState(() {
                    _cartItems.removeWhere((item) => item.id == id);
                    _itemQuantities.remove(id);
                    _checkedItems.remove(id);
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Failed to delete item: $e');
                  // Handle error, show error message, etc.
                }
              },
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }
}
