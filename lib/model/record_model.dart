class RecordModel {
  final String audioUrl;
  final String audioTime;

  RecordModel({required this.audioUrl, required this.audioTime});

  factory RecordModel.fromJson(jsonData) {
    return RecordModel(
        audioUrl: jsonData['audioUrl'], audioTime: jsonData['audioTime']);
  }

  Map<String, dynamic> toMap() {
    return {
      'audioUrl': audioUrl,
      'audioTime': audioTime,
    };
  }
}
