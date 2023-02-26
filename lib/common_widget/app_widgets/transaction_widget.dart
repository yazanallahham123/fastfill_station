import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/state.dart';
import '../../helper/app_colors.dart';
import '../../model/station/station_payment_transaction_result.dart';
import '../../utils/misc.dart';

class TransactionWidget extends StatefulWidget{

  final StationPaymentTransactionResult stationPaymentTransactionResult;
  final StationBloc stationBloc;
  final StationState stationState;
  const TransactionWidget({required this.stationPaymentTransactionResult, required this.stationBloc, required this.stationState});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(child:

      InkWell(child:
      Row(children: [

        SvgPicture.asset("assets/svg/refuel.svg", width: 50, height: 50,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child:
              Padding(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:
                  Text(translate("labels.transactionId"), style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),),),

                  Text("#"+widget.stationPaymentTransactionResult.id!.toString(), style: TextStyle(color: Colors.white),),
                ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0)),),

            Container(
              width: MediaQuery.of(context).size.width - 100,
              child:
              Padding(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:
                  Text(widget.stationPaymentTransactionResult.user!.firstName! + " - " + widget.stationPaymentTransactionResult.user!.mobileNumber!, style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),),),

                  Text(formatter.format(widget.stationPaymentTransactionResult.amount!-widget.stationPaymentTransactionResult.fastfill!)+' '+translate("labels.sdg"), style: TextStyle(color: Colors.white),),
                ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0)),),

            Container(
              width: MediaQuery.of(context).size.width - 100,
              child:
              Padding(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:
                  Text(DateFormat('yyyy-MM-dd - hh:mm a').format(DateTime.parse(widget.stationPaymentTransactionResult.date!)), style: TextStyle(color: textColor2),),),
                ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0)),),


          ],)
      ],), onTap: () {
        hideKeyboard(context);
        //StationPaymentResultBody prb = StationPaymentResultBody(date: DateFormat('yyyy-MM-dd - hh:mm a').format(DateTime.parse(widget.stationPaymentTransactionResult.date!)), userName:  widget.stationPaymentTransactionResult.user!.firstName!, mobileNumber:  widget.stationPaymentTransactionResult.user!.mobileNumber!, fuelTypeId: widget.stationPaymentTransactionResult.fuelTypeId!, amount: widget.stationPaymentTransactionResult.amount!, value: widget.stationPaymentTransactionResult.fastfill!, status: widget.stationPaymentTransactionResult.status!, fromList: true);
        //Navigator.pushNamed(context, StationPaymentResultPage.route, arguments: prb);
      },)

        , padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),);
  }
}

/*

 */