import 'dart:convert';

class ConfigSplashScreen {
  final bool? available;
  final bool? isGif;
  final bool? isVideo;
  final bool? isImage;
  final bool? isLocal;
  final String? path;

  ConfigSplashScreen({
    this.available = true,
    this.isGif = false,
    this.isVideo = false,
    this.isImage = false,
    this.isLocal = true,
    this.path = "",
  });

  ConfigSplashScreen copyWith({
    bool? available,
    bool? isGif,
    bool? isVideo,
    bool? isImage,
    bool? isLocal,
    String? path,
  }) =>
      ConfigSplashScreen(
        available: available ?? this.available,
        isGif: isGif ?? this.isGif,
        isVideo: isVideo ?? this.isVideo,
        isImage: isImage ?? this.isImage,
        isLocal: isLocal ?? this.isLocal,
        path: path ?? this.path,
      );

  factory ConfigSplashScreen.fromRawJson(String str) =>
      ConfigSplashScreen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfigSplashScreen.fromJson(Map<String, dynamic> json) =>
      ConfigSplashScreen(
        available: json["available"],
        isGif: json["isGif"],
        isVideo: json["isVideo"],
        isImage: json["isImage"],
        isLocal: json["isLocal"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "isGif": isGif,
        "isVideo": isVideo,
        "isImage": isImage,
        "isLocal": isLocal,
        "path": path,
      };
}
