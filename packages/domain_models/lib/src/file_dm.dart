class FileDM {
  final String name;
  final String? dlUrl;

  FileType get type => categorizeFileType(name.split('.').last);
  String get extension => name.split('.').last;
  FileDM({
    required this.name,
    this.dlUrl,
  });
}

enum FileType {
  other,
  image,
  video,
  unknown,
}

FileType categorizeFileType(String extension) {
  // Get the file extension

  // Determine the file category based on the extension using switch
  switch (extension.toLowerCase()) {
    case 'txt':
    case 'csv':
    case 'doc':
    case 'docx':
    case 'odt':
    case 'pdf':
    case 'ppt':
    case 'pptx':
    case 'mp3':
    case 'wav':
    case 'ogg':
    case 'aac':
    case 'zip':
    case 'rar':
    case 'tar':
    case 'gz':
    case 'html':
    case 'css':
    case 'js':
    case 'json':
    case 'xml':
    case 'iso':
      return FileType.other;

    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
    case 'bmp':
    case 'svg':
    case 'webp':
      return FileType.image;

    // case 'mp3':
    // case 'wav':
    // case 'ogg':
    // case 'aac':
    //   return FileType.audio;

    case 'mp4':
    case 'avi':
    case 'mov':
    case 'wmv':
    case 'mkv':
      return FileType.video;

    // case 'zip':
    // case 'rar':
    // case 'tar':
    // case 'gz':
    //   return FileType.compressed;

    // case 'html':
    // case 'css':
    // case 'js':
    // case 'json':
    // case 'xml':
    // return FileType.code;

    // case 'iso':
    //   return FileType.discImage;

    default:
      return FileType.unknown;
  }
}
