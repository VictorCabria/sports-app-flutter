import 'dart:convert';

class MenuItem {
  final String? label;
  final String? iconAsset;

  MenuItem({
    this.label,
    this.iconAsset,
  });

  MenuItem copyWith({
    String? label,
    String? iconAsset,
  }) {
    return MenuItem(
      label: label ?? this.label,
      iconAsset: iconAsset ?? this.iconAsset,
    );
  }

  factory MenuItem.fromRawJson(String str) =>
      MenuItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      label: json['label'] as String?,
      iconAsset: json['iconAsset'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'iconAsset': iconAsset,
    };
  }
}
