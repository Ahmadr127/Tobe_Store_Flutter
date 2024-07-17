import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Detail Product"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/products/Tobe_store.png'),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Ubah Foto Profil',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ProfileSection(
              title: 'Info Profil',
              children: [
                ProfileInfoRow(
                  label: 'Nama',
                  value: 'Ahmad Rifai',
                ),
                ProfileInfoRow(
                  label: 'Username',
                  value: 'Buat username yang unik',
                ),
                ProfileInfoRow(
                  label: 'Bio',
                  value: 'Tulis bio tentangmu',
                ),
              ],
            ),
            SizedBox(height: 16),
            ProfileSection(
              title: 'Info Pribadi',
              children: [
                ProfileInfoRow(
                  label: 'User ID',
                  value: '73415734',
                ),
                ProfileInfoRow(
                  label: 'E-mail',
                  value: 'ahmdrifai808@gmail.com',
                ),
                ProfileInfoRow(
                  label: 'Nomor HP',
                  value: '62895711580060',
                ),
                ProfileInfoRow(
                  label: 'Jenis Kelamin',
                  value: 'Pilih Jenis Kelamin',
                ),
                ProfileInfoRow(
                  label: 'Tanggal Lahir',
                  value: 'Pilih Tanggal Lahir',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  ProfileSection({required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;
  ProfileInfoRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
