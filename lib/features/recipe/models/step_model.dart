class Step {
  Step({
    required this.id,
    required this.instruction,
    required this.versionId,
    required this.stepNumber,
    required this.createdAt,
    required this.updatedAt,

  });

  factory Step.fromJson(Map<String, String> json) {
    return Step(
      id: json['id']!,
      instruction: json['instruction']!,
      versionId: json['versionId']!,
      stepNumber: int.parse(json['stepNumber']!),
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
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
