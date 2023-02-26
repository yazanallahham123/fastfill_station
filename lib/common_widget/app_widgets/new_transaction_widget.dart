import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/state.dart';
import '../../helper/app_colors.dart';
import '../../model/station/station_payment_transaction_result.dart';
import '../../utils/misc.dart';

class NewTransactionWidget extends StatelessWidget
{
  final StationPaymentTransactionResult stationPaymentTransactionResult;
  final StationBloc stationBloc;
  final StationState stationState;
  const NewTransactionWidget({Key? key, required this.stationPaymentTransactionResult, required this.stationBloc, required this.stationState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
        child:
        InkWell(child:
        Padding(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child:
                Text(translate("labels.transactionId"), style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),),),

                Text("#"+stationPaymentTransactionResult.dailyId!.toString(), style: TextStyle(color: Colors.white),),
              ],),

          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:
            Text(translate("labels.customer_id")+": "+stationPaymentTransactionResult.userId!.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),),
            //Text(stationPaymentTransactionResult.user!.firstName! + " - " + stationPaymentTransactionResult.user!.mobileNumber!, style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),),
            ),

            Text(formatter.format(stationPaymentTransactionResult.amount!-stationPaymentTransactionResult.fastfill!)+' '+translate("labels.sdg"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ],),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child:
              Text(DateFormat('yyyy-MM-dd - hh:mm a').format(DateTime.parse(stationPaymentTransactionResult.date!)), style: TextStyle(color: textColor2),),),
            ],)

          ],), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),), onTap: () {
          hideKeyboard(context);
        },));
  }

}