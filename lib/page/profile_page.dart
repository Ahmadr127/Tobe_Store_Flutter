import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobe_mart/page/edit_profile.dart';
import 'package:tobe_mart/page/login_page.dart';
import 'package:tobe_mart/service/api_service.dart'; // Import fungsi fetchUserDetails dan model User
import 'package:tobe_mart/model/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user; // Menyimpan data pengguna setelah diambil dari API

  @override
  void initState() {
    super.initState();
    loadUserData(); // Memanggil fungsi untuk memuat data pengguna saat halaman diinisialisasi
  }

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String kdUser = prefs.getString('kd_user') ?? '';

      // Memanggil API untuk mengambil detail pengguna berdasarkan kd_user
      User fetchedUser = await fetchUserDetails(kdUser);

      setState(() {
        user = fetchedUser;
      });
    } catch (e) {
      print('Error loading user data: $e');
      // Handle error jika terjadi kesalahan dalam memuat data pengguna
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/images/tobe.png'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.namaUsers ?? 'Loading...',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(user?.noWa.toString() ?? 'Loading...'),
                              Text(user?.email ?? 'Loading...'),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return EditProfile();
                            }));
                            // Implement action for editing profile
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Account Settings Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pengaturan Akun",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          size: 35,
                        ),
                        title: Text('Daftar Alamat'),
                        subtitle: Text("Atur alamat pengiriman pembelanjaan"),
                        onTap: () {
                          // Navigate to address list
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.payment,
                          size: 35,
                        ),
                        title: Text('Pembayaran Instan'),
                        subtitle:
                            Text("Lakukan Pembayarang Dengan E-Wallet Mu"),
                        onTap: () {
                          // Navigate to instant payment methods
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.privacy_tip,
                          size: 35,
                        ),
                        title: Text('Keamanan Akun'),
                        subtitle: Text(
                            "Tingkatkan Keamanan Akunmu dengan memberikan keamanan berlapis"),
                        onTap: () {
                          // Navigate to privacy settings
                        },
                      ),
                      Divider(),
                      ListTile(
  leading: Icon(
    Icons.exit_to_app,
    size: 35,
  ),
  title: Text('Keluar Akun'),
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Apakah Anda yakin ingin keluar dari akun?"),
          actions: <Widget>[
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Keluar"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
                // Implement log out action
              },
            ),
          ],
        );
      },
    );
  },
),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
