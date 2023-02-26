import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_body.g.dart';

@JsonSerializable()
class NotificationBody extends Equatable{
   final int? id;
   final String? typeId;
   final String? date;
   final String? time;
   final String? title;
   final String? content;
   final String? notes;
   final String? imageURL;
   final int? userId;
   final String? price;
   final String? liters;
   final String? material;
   final String? address;
   final int? companyId;
   final String? userName;
   final String? userMobileNo;
   final String? transactionId;
   final String? fastFill;

   NotificationBody({this.id, this.typeId, this.date, this.time, this.title, this.content, this.notes,
      this.imageURL, this.userId, this.price, this.liters, this.material, this.address, this.companyId,
   this.userName, this.userMobileNo, this.transactionId, this.fastFill});

   factory NotificationBody.fromJson(Map<String, dynamic> json) =>
       _$NotificationBodyFromJson(json);

   Map<String, dynamic> toJson() => _$NotificationBodyToJson(this);

   @override
   List<Object?> get props =>
       [this.id, this.typeId, this.date, this.time, this.title, this.content, this.notes,
          this.imageURL, this.userId, this.price, this.liters, this.material, this.address,
          this.companyId, this.userName, this.userMobileNo, this.transactionId, this.fastFill];
}
