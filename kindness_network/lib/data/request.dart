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

  static List<Request> sampleRequests = [
    Request(id: 1, requesterId: 1, jobType: JobType.mental, isAccepted: false, acceptedId: -1, requestTime: DateTime(2022, 7, 10)),
    Request(id: 2, requesterId: 1, jobType: JobType.housekeeping, isAccepted: true, acceptedId: 2, requestTime: DateTime(2022, 7, 10)),
  ];
}

enum JobType {
  mental('Mental Wellbeing'),
  housekeeping('House-keeping'),
  mobility('Mobility'),
  literacy('Digital Literacy');

  const JobType(this.value);
  final String value;

  @override
  String toString() {
    return value;
  }
}
