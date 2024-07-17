class User {
  
  final String namaUsers;
  final String email;
  final String username;
  final int noWa;
  final String alamat;
  final int nik;
  final DateTime tglLahir;
  final String fotoProfile;

  User({
    required this.namaUsers,
    required this.email,
    required this.username,
    required this.noWa,
    required this.alamat,
    required this.nik,
    required this.tglLahir,
    required this.fotoProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      namaUsers: json['nama_users'],
      email: json['email'],
      username: json['username'],
      noWa: json['no_wa'],
      alamat: json['alamat'],
      nik: json['nik'],
      tglLahir: DateTime.parse(json['tgl_lahir']),
      fotoProfile: json['foto_profile'],
    );
  }
}
