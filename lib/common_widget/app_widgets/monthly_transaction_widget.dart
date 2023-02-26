import 'dart:ui';

import 'package:fastfill_station_app/model/station/monthly_station_payment_transaction.dart';
import 'package:fastfill_station_app/streams/download_mode_stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/state.dart';
import '../../helper/app_colors.dart';
import '../../main.dart';
import '../../streams/add_remove_monthly_station_payment_transaction_stream.dart';
import '../../utils/misc.dart';

class MonthlyTransactionWidget extends StatefulWidget
{
  final MonthlyStationPaymentTransaction monthlyStationPaymentTransaction;
  final StationBloc stationBloc;
  final StationState stationState;
  const MonthlyTransactionWidget({Key? key, required this.monthlyStationPaymentTransaction, required this.stationBloc, required this.stationState})
      : super(key: key);

  @override
  State<MonthlyTransactionWidget> createState() => _MonthlyTransactionWidgetState();
}

class _MonthlyTransactionWidgetState extends State<MonthlyTransactionWidget> {

  @override
  void initState() {
    super.initState();
    updateDownloadModeStreamController.stream.listen((event) {
      if (event)
      {
        if (mounted) {
          setState(() {
            downloadMode = true;
            isSelected = false;
          });
        }
      }
      else
        {
          if (mounted) {
            setState(() {
              downloadMode = false;
              isSelected = false;
            });
          }
        }
    });
  }



  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    String m = widget.monthlyStationPaymentTransaction.month.toString();
    if (m.length == 1)
      m = "0"+m;
    String y = widget.monthlyStationPaymentTransaction.year.toString();
    return
      InkWell(
          onTap: () {
            if (mounted) {
              setState(() {
                if (downloadMode) {
                  isSelected = !isSelected;
                  if (!addRemoveMonthlyStationPaymentTransactionStreamController.isClosed)
                    addRemoveMonthlyStationPaymentTransactionStreamController.sink.add(widget.monthlyStationPaymentTransaction);
                }
              });
            }
          },
          child:
      Opacity(
          opacity: (downloadMode) ? (isSelected) ? 1 : 0.3 : 1,
          child:
      Container(

        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(child: SvgPicture.asset("assets/svg/refuel.svg", width: 50, height: 50,), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),),

            Expanded(child: Padding(child:  Column(
            children: [
            Align(child: Text(DateFormat('MMMM - MM/yyyy').format(DateTime.parse(y+"-"+m+"-01 10:33:00")), style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),), alignment: AlignmentDirectional.topStart,),
            Align(child: Text(translate("labels.monthlyAmount"), style: TextStyle(color: textColor2),), alignment: AlignmentDirectional.topStart,),
            Align(child: Text(translate("labels.totalMonthlyTransactions"), style: TextStyle(color: textColor2),), alignment: AlignmentDirectional.topStart,)
            ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),)),

    Padding(child:  Column(
    children: [
    Align(child: Text("", style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),), alignment: AlignmentDirectional.topStart,),
    Align(child: Text(formatter.format(widget.monthlyStationPaymentTransaction.amount)+' '+translate("labels.sdg"), style: TextStyle(color: textColor2),), alignment: AlignmentDirectional.topStart,),
    Align(child: Text(widget.monthlyStationPaymentTransaction.count.toString(), style: TextStyle(color: textColor2),), alignment: AlignmentDirectional.topStart,)
    ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),)

          ],)
    )));
  }
}