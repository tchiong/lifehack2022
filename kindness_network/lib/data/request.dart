import 'package:kindness_network/data/firebase.dart';

class Request {
  late int id;
  int requesterId;
  String jobType;
  bool isAccepted;
  int? acceptedId;
  DateTime requestTime;

  int newId() {
    return 0;
  }

  Request(
      {required this.id,
      required this.requesterId,
      required this.jobType,
      required this.isAccepted,
      this.acceptedId,
      required this.requestTime});

  Map toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'jobType': jobType,
      'isAccepted': isAccepted,
      'acceptedId': acceptedId,
      'requestTime': requestTime,
    };
  }
  static List<Request> sampleRequests = [
    Request(id: 1, requesterId: 1, jobType: JobType.mental, isAccepted: false, acceptedId: -1, requestTime: DateTime(2022, 7, 10)),
    Request(id: 2, requesterId: 1, jobType: JobType.housekeeping, isAccepted: true, acceptedId: 2, requestTime: DateTime(2022, 7, 10)),
  ];

  static Future<int> generateRequestId() async {
    var nextId = await Firebase().readData('requests/id');

    if (nextId.exists) {
      Firebase().pushData('requests/id', nextId + 1);
    } else {
      nextId = 0;
      Firebase().pushData('requests/id', 1);
    }
    return nextId;
  }

  static parseJson(record) {
    Map<String, dynamic> attributes = {
      'id': '',
      'requesterId': '',
      'jobType': '',
      'isAccepted': '',
      'acceptedId': '',
      'requestTime': '',
    };

    record.forEach((key, value) => {attributes[key] = value});

    return Request(
        id: attributes['id'],
        requesterId: attributes['requesterId'],
        jobType: attributes['jobType'],
        isAccepted: attributes['isAccepted'],
        acceptedId: attributes['acceptedId'],
        requestTime: attributes['requestTime']);
  }
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
