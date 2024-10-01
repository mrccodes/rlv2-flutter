class Tip {
  Tip({
    required this.id,
    required this.body,
    required this.versionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tip.fromJson(Map<String, String> json) {
    return Tip(
      id: json['id']!,
      body: json['body']!,
      versionId: json['versionId']!,
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
    );
  }
  final String id;
  final String body;
  final String versionId;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'versionId': versionId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
