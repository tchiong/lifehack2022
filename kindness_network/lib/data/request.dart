import 'package:kindness_network/data/firebase.dart';

class Request {
  late int id;
  int requesterId;
  JobType jobType;
  bool isAccepted;
  int acceptedId;
  DateTime requestTime;

  int newId() {
    return 0;
  }

  Request(
      {required this.id,
      required this.requesterId,
      required this.jobType,
      required this.isAccepted,
      required this.acceptedId,
      required this.requestTime});

  Map toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'jobType': jobType,
      'isAccepted': isAccepted,
      'acceptedId': acceptedId,
      'requestTime': requestTime.toString(),
    };
  }

  static Future<int> generateRequestId() async {
    Map? nextIdData = await Firebase().readData('request/');
    int nextId;

    if (nextIdData == null) {
      nextId = 0;
    } else {
      List<dynamic> ids =
          nextIdData.values.toList().map((request) => request['id']).toList();
      ids.sort();
      nextId = ids.first + 1;
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

    JobType jobType = JobType.mobility;
    switch (attributes['jobType']) {
      case 'Mental Wellbeing':
        {
          jobType = JobType.mental;
        }
        break;
      case 'House-keeping':
        {
          jobType = JobType.housekeeping;
        }
        break;
      case 'Mobility':
        {
          jobType = JobType.mobility;
        }
        break;
      case 'Digital Literacy':
        {
          jobType = JobType.literacy;
        }
        break;
    }

    record.forEach((key, value) => {attributes[key] = value});

    return Request(
        id: attributes['id'],
        requesterId: attributes['requesterId'],
        jobType: jobType,
        isAccepted: attributes['isAccepted'],
        acceptedId: attributes['acceptedId'],
        requestTime: DateTime.parse(attributes['requestTime']));
  }

  static getAllActiveRequests() async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData == null) {
      return null;
    } else {
      List<dynamic> requests = requestsData.values
          .toList()
          .map((requestData) => parseJson(requestData))
          .where((request) => request.accepted)
          .toList();
    }
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
