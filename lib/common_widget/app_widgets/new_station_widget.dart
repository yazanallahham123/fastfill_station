import 'dart:io';
import 'dart:math';

import 'package:fastfill_station_app/model/station/station_with_transactions_total.dart';
import 'package:fastfill_station_app/ui/home/payment_transactions_page.dart';
import 'package:fastfill_station_app/ui/home/transactions_tab_page_company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../helper/methods.dart';
import '../../helper/size_config.dart';
import '../../model/station/station.dart';
import '../../utils/misc.dart';
import 'favorite_button.dart';

class NewStationWidget extends StatefulWidget{

  final StationWithTransactionsTotal station;
  final StationBloc? stationBloc;
  final StationState? stationState;
  final int sourceId;
  const NewStationWidget({required this.station, this.stationBloc, this.stationState,
  required this.sourceId});

  @override
  State<NewStationWidget> createState() => _NewStationWidgetState();
}

class _NewStationWidgetState extends State<NewStationWidget> {
  @override
  Widget build(BuildContext context) {
    return

      InkWell(child:
          Card(child:
      Container(
      padding: EdgeInsetsDirectional.fromSTEB(25, 15, 25, 15),
      margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child:
      Row(children: [
        Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Align(
              child: Text(
                (isArabic()) ? widget.station.arabicName! : widget.station.englishName!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            alignment: AlignmentDirectional.topStart,),
              Align(
                child: Text(
                  translate("labels.totalTransactionsValue")+": "+
    formatter.format(widget.station.amount!)+" "+translate("labels.sdg"),
                  style: TextStyle(fontSize: 16),
                ),
                alignment: AlignmentDirectional.topStart,),
              Align(
                child: Text(
    translate("labels.totalTransactionsCount")+": "+widget.station.count!.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                alignment: AlignmentDirectional.topStart,),

          ],)),
      ],),
    )), onTap: () {
        if (widget.sourceId == 1) {
          Navigator.pushNamed(
              context, PaymentTransactionsPage.route,
              arguments: widget.station);
        }
        else
          {
            if (widget.sourceId == 2) {
              Navigator.pushNamed(
                  context, TransactionsTabPageCompany.route,
                  arguments: widget.station);
            }

          }
      });
  }
}