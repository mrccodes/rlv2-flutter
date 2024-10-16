class CreateRecipeVersionStep {
  CreateRecipeVersionStep({
    required this.instruction,
    required this.versionId,
    required this.stepNumber,
  });

  factory CreateRecipeVersionStep.fromJson(Map<String, dynamic> json) {
    return CreateRecipeVersionStep(
      instruction: json['instruction'] as String,
      versionId: json['versionId'] as String,
      stepNumber: json['stepNumber'] as int,
    );
  }
  final String instruction;
  final String versionId;
  final int stepNumber;

  Map<String, dynamic> toJson() {
    return {
      'instruction': instruction,
      'versionId': versionId,
      'stepNumber': stepNumber,
    };
  }
}
