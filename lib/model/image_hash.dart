class ImageHash {
  String imageUrl;
  String imageHash;

  ImageHash({required this.imageUrl, required this.imageHash});
  factory ImageHash.fromJson(
    Map<String, dynamic> json,
  ) {
    return ImageHash(
      imageUrl: json["image_url"],
      imageHash: json["image_hash"],
    );
  }

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "image_hash": imageHash,
      };
}
