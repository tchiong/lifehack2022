class Request {
  int id;
  int requesterId;
  JobType jobType;
  bool isAccepted;
  int acceptedId;
  DateTime requestTime;

  Request({
    required this.id,
    required this.requesterId,
    required this.jobType,
    required this.isAccepted,
    required this.acceptedId,
    required this.requestTime,
  });

  Map toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'jobType': jobType.value,
      'isAccepted': isAccepted,
      'acceptedId': acceptedId,
      'requestTime': requestTime,
    };
  }
}

enum JobType {
  mental('mental'),
  housekeeping('housekeeping'),
  mobility('mobility'),
  literacy('literacy');

  const JobType(this.value);
  final String value;
}
