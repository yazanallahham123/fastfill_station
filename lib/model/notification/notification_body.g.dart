// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationBody _$NotificationBodyFromJson(Map<String, dynamic> json) =>
    NotificationBody(
      id: json['id'] as int?,
      typeId: json['typeId'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      notes: json['notes'] as String?,
      imageURL: json['imageURL'] as String?,
      userId: json['userId'] as int?,
      price: json['price'] as String?,
      liters: json['liters'] as String?,
      material: json['material'] as String?,
      address: json['address'] as String?,
      companyId: json['companyId'] as int?,
      userName: json['userName'] as String?,
      userMobileNo: json['userMobileNo'] as String?,
      transactionId: json['transactionId'] as String?,
      fastFill: json['fastFill'] as String?,
    );

Map<String, dynamic> _$NotificationBodyToJson(NotificationBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeId': instance.typeId,
      'date': instance.date,
      'time': instance.time,
      'title': instance.title,
      'content': instance.content,
      'notes': instance.notes,
      'imageURL': instance.imageURL,
      'userId': instance.userId,
      'price': instance.price,
      'liters': instance.liters,
      'material': instance.material,
      'address': instance.address,
      'companyId': instance.companyId,
      'userName': instance.userName,
      'userMobileNo': instance.userMobileNo,
      'transactionId': instance.transactionId,
      'fastFill': instance.fastFill,
    };
