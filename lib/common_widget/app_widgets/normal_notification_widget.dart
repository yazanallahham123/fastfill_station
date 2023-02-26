
import 'package:flutter/material.dart';

import '../../helper/const_styles.dart';
import '../../model/notification/notification_body.dart';

class NormalNotificationWidget extends StatelessWidget
{
  final NotificationBody notification;
  const NormalNotificationWidget({Key? key, required this.notification
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: radiusAll16),

        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
        child:
        Column(children: [
          Padding(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text((notification.title != null ) ? notification.title! : "")),
              Flexible(child: Text((notification.time != null) ? notification.time! : ""))
            ],),padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 2),),
          Divider(color: (notification.typeId == "3") ? Colors.black45 : Colors.red, thickness: 0.3,),

          Row(children: [

            Padding(child: Image(image: AssetImage("assets/notification.png"),
                width: 50, height: 50
            ), padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child:
                  Padding(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text((notification.content != null) ? notification.content! : "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                    ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0)),),
              ],)
          ],)],));
  }

}