class Tip {
  Tip({
    required this.id,
    required this.body,
    required this.versionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      id: json['id'] as String,
      body: json['body'] as String,
      versionId: json['versionId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
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
