class RegisterMemberParams {
  final String email;
  final String password;
  final String clubId;
  final String imageUrl;
  final int rating;
  final String role;
  final String username;
  final String passwordAdmin;

  RegisterMemberParams(
      {required this.email,
      required this.password,
      required this.clubId,
      required this.imageUrl,
      required this.rating,
      required this.role,
      required this.username,
      required this.passwordAdmin});
}
