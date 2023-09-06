class ExerciseData {
  final String clientId;
  final String createdAt;
  final String type;
  final String message;
  final String id;

  ExerciseData(this.clientId, this.createdAt, this.type, this.message, this.id);

  ExerciseData.fromJson(Map<String, dynamic> json)
      : clientId = json['clientId'],
        createdAt = json['createdAt'],
        type = json['type'],
        message = json['message'],
        id = json['id'];
}
