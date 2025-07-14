class ResponseModel {
  final String status;
  final List<DataItem> data;

  ResponseModel({
    required this.status,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      data: (json['data'] as List)
          .map((item) => DataItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class DataItem {
  final String id;
  final String title;
  final String description;
  final String status;
  final String email;
  final DateTime createdDate;

  DataItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    required this.createdDate,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      email: json['email'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'status': status,
      'email': email,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
