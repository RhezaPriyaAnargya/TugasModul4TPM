class User {
  final String username;
  final String password;

  User({required this.username, required this.password});
}

// Daftar anggota kelompok yang diizinkan login
final List<User> allowedUsers = [
  User(username: 'Dimas', password: '123230007'),
  User(username: 'Rheza', password: '123230032'),
  User(username: 'Bima', password: '123230003'),
  User(username: 'Fikar', password: '123230038'),
];