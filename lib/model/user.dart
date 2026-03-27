class User {
  final String username;
  final String password;
  final String NIM;

  User({required this.username, required this.password, required this.NIM});
}

// Daftar anggota kelompok yang diizinkan login
final List<User> allowedUsers = [
  User(username: 'Dimas', password: '123230007', NIM: '123230007'),
  User(username: 'Rheza', password: '123230032', NIM:'123230032'),
  User(username: 'Bima', password: '123230003', NIM: '123230003'),
  User(username: 'Fikar', password: '123230038', NIM: '123230038'),
];
