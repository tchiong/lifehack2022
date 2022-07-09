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
}

enum JobType { mental, housekeeping, mobility, literacy }
