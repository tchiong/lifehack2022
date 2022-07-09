import 'package:kindness_network/data/firebase.dart';

class Request {
  late int id;
  int requesterId;
  JobType jobType;
  bool isAccepted;
  int acceptedId;
  DateTime requestTime;
  bool isCompleted;

  int newId() {
    return 0;
  }

  Request(
      {required this.id,
      required this.requesterId,
      required this.jobType,
      required this.isAccepted,
      required this.acceptedId,
      required this.requestTime,
      required this.isCompleted});

  Map toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'jobType': jobType.value,
      'isAccepted': isAccepted,
      'acceptedId': acceptedId,
      'requestTime': requestTime.toString(),
      'isCompleted': isCompleted,
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
      ids.sort(((a, b) => b - a));
      nextId = ids.first + 1;
    }
    return nextId;
  }

  static Request parseJson(record) {
    Map<String, dynamic> attributes = {
      'id': '',
      'requesterId': '',
      'jobType': '',
      'isAccepted': '',
      'acceptedId': '',
      'requestTime': '',
      'isCompleted': '',
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
        requestTime: DateTime.parse(attributes['requestTime']),
        isCompleted: attributes['isCompleted']);
  }

  // Database Calls
  static Future<List<Request>> getAllActiveRequestsForBeneficiary(
      int id) async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData == null) {
      return [];
    } else {
      List<Request> requests = List<Request>.from(requestsData.values
          .toList()
          .map((requestData) => parseJson(requestData))
          .where((request) =>
              request.isAccepted == false && request.requesterId == id)
          .toList());
      return requests;
    }
  }

  static Future<List<Request>> getAllUnacceptedRequestsForVolunteer(
      int id) async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData == null) {
      return [];
    } else {
      List<Request> requests = List<Request>.from(requestsData.values
          .toList()
          .map((requestData) => parseJson(requestData))
          .where((request) => request.isAccepted == false)
          .toList());
      return requests;
    }
  }

  static Future<List<Request>> getAllCompletedRequestsForBeneficiary(
      int id) async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData == null) {
      return [];
    } else {
      List<Request> requests = List<Request>.from(requestsData.values
          .toList()
          .map((requestData) => parseJson(requestData))
          .where((request) =>
              request.isCompleted == true && request.requesterId == id)
          .toList());
      return requests;
    }
  }

  static void completeRequest(Request request) async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData != null) {
      String? key;
      List<String> pointer = List<String>.from(requestsData.keys.toList());
      for (String string in pointer) {
        if (parseJson(requestsData[string]).id == request.id) {
          key = string;
        }
      }
      if (key != null) {
        Firebase().pushData('request/$key', request.toJson());
      }
    }
  }

  static void deleteRequestById(int id) async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData != null) {
      String? key;
      List<String> pointer = List<String>.from(requestsData.keys.toList());
      for (String string in pointer) {
        if (parseJson(requestsData[string]).id == id) {
          key = string;
        }
      }
      if (key != null) {
        Firebase().deleteData('request/$key');
      }
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
