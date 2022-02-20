class Audio {
  final int? id;
  final String name;
  final String folder;
  final String uriPath;

  const Audio(
      {this.id,
      required this.name,
      required this.folder,
      required this.uriPath});

  Map<String, dynamic> toMap() {
    return {"name": name, "folder": folder, "uri_path": uriPath};
  }

  @override
  String toString() {
    return 'Audio(id: $id, name: $name, folder: $folder, uri_path: $uriPath)';
  }
}
