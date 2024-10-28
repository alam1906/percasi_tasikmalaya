import 'dart:io';

class AddNewsParams {
  final String title;
  final String description;
  final File imageFile;

  AddNewsParams(
      {required this.title,
      required this.description,
      required this.imageFile});
}
