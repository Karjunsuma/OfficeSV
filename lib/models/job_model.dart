import 'dart:convert';

class JobModel {
  final String id;
  final String nameRecord;
  final String jobName;
  final String detailJob;
  final String factoryKey;
  final String agree;
  final String item;
  final String addDate;
  final String qRcode;
  final String pathImage;

  JobModel(
      this.id,
      this.nameRecord,
      this.jobName,
      this.detailJob,
      this.factoryKey,
      this.agree,
      this.item,
      this.addDate,
      this.qRcode,
      this.pathImage);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameRecord': nameRecord,
      'jobName': jobName,
      'detailJob': detailJob,
      'factoryKey': factoryKey,
      'agree': agree,
      'item': item,
      'addDate': addDate,
      'qRcode': qRcode,
      'pathImage': pathImage,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      map['id'] ?? '',
      map['nameRecord'] ?? '',
      map['jobName'] ?? '',
      map['detailJob'] ?? '',
      map['factoryKey'] ?? '',
      map['agree'] ?? '',
      map['item'] ?? '',
      map['addDate'] ?? '',
      map['qRcode'] ?? '',
      map['pathImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) => JobModel.fromMap(json.decode(source));
}
