class Step {
  Step({
    required this.id,
    required this.instruction,
    required this.versionId,
    required this.stepNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      id: json['id'] as String,
      instruction: json['instruction'] as String,
      versionId: json['versionId'] as String,
      stepNumber: json['stepNumber'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
  final String id;
  final String instruction;
  final String versionId;
  final int stepNumber;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instruction': instruction,
      'versionId': versionId,
      'stepNumber': stepNumber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
