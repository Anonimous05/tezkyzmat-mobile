import 'dart:io';

class TempImageItem {
  const TempImageItem({
    required this.id,
    this.imageNetwork,
    this.isDeleting = false,
    this.imageFile,
  });
  final int id;
  final String? imageNetwork;
  final bool isDeleting;
  final File? imageFile;
}
