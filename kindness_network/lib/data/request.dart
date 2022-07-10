import 'package:kindness_network/data/firebase.dart';

class Request {
  late int id;
  int requesterId;
  JobType jobType;
  bool isAccepted;
  int acceptedId;
  DateTime requestTime;
  bool isCompletedAcceptee;
  bool isCompletedBeneficiary;
  double rating;
  String feedback;

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
      required this.isCompletedAcceptee,
      required this.isCompletedBeneficiary,
      required this.rating,
      required this.feedback});

  Map toJson() {
    return {
      'id': id,
      'requesterId': requesterId,
      'jobType': jobType.value,
      'isAccepted': isAccepted,
      'acceptedId': acceptedId,
      'requestTime': requestTime.toString(),
      'isCompletedAcceptee': isCompletedAcceptee,
      'isCompletedBeneficiary': isCompletedBeneficiary,
      'rating': rating,
      'feedback': feedback,
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
      'isCompletedAcceptee': '',
      'isCompletedBeneficiary': '',
      'rating': '',
      'feedback': '',
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
        isCompletedAcceptee: attributes['isCompletedAcceptee'],
        isCompletedBeneficiary: attributes['isCompletedBeneficiary'],
        rating: (attributes['rating'] as int).toDouble(),
        feedback: attributes['feedback']);
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
              request.isCompletedAcceptee == false && request.requesterId == id)
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
              request.isCompletedBeneficiary == true &&
              request.isCompletedAcceptee == true &&
              request.requesterId == id)
          .toList());
      return requests;
    }
  }

  static Future<List<Request>> getAllCompletedRequestsForVolunteer(
      int id) async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData == null) {
      return [];
    } else {
      List<Request> requests = List<Request>.from(requestsData.values
          .toList()
          .map((requestData) => parseJson(requestData))
          .where((request) =>
              request.isCompletedAcceptee == true && request.acceptedId == id)
          .toList());
      return requests;
    }
  }

  static Future<List<Request>> getAllAcceptedRequestsForVolunteer(
      int id) async {
    Map? requestsData = await Firebase().readData('request/');
    if (requestsData == null) {
      return [];
    } else {
      List<Request> requests = List<Request>.from(requestsData.values
          .toList()
          .map((requestData) => parseJson(requestData))
          .where((request) =>
              request.isAccepted == true &&
              request.isCompletedAcceptee == false &&
              request.acceptedId == id)
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
          .where((request) =>
              request.isAccepted == false &&
              request.isCompletedAcceptee == false &&
              request.isCompletedBeneficiary == false)
          .toList());
      return requests;
    }
  }

  static void acceptRequest(Request request, int userId) async {
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
        request.isAccepted = true;
        request.acceptedId = userId;
        Firebase().pushData('request/$key', request.toJson());
      }
    }
  }

  static void completeRequestBenficiary(Request request) async {
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
        request.isCompletedBeneficiary = true;
        Firebase().pushData('request/$key', request.toJson());
      }
    }
  }

  static void completeRequestVolunteer(Request request) async {
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
        request.isCompletedAcceptee = true;
        Firebase().pushData('request/$key', request.toJson());
      }
    }
  }

  static void submitFeedback(
      Request request, double rating, String feedback) async {
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
        request.rating = rating;
        request.feedback = feedback;
        Firebase().pushData('request/$key', request.toJson());
      }
    }
  }

  static void removeRequestAcceptedId(Request request) async {
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
        request.isAccepted = false;
        request.acceptedId = -1;
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

  String toChinese() {
    switch (value) {
      case 'Mental Wellbeing':
        return '心理健康';
      case 'House-keeping':
        return '家政';
      case 'Mobility':
        return '运输服务';
      case 'Digital Literacy':
        return '数字素养';
      default:
        return value;
    }
  }
}
